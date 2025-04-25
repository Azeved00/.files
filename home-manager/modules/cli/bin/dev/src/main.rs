use clap::{Arg,ArgMatches, Command as ClapCommand};
use std::{
    env,
    fs,
    path::PathBuf,
    process::Command,
};

struct Config{
    history_path: String,
}

struct Inst{
    directory: PathBuf,
    session_name: String,
    nix_rename: bool,
    nix_shell: bool,
    save_history: bool,
    mono: bool,
    attach: bool
}

fn get_config() -> Config {
    let xdg_config_home = env::var("XDG_CONFIG_HOME").unwrap_or_else(|_| {
        dirs::config_dir()
            .unwrap_or_else(|| PathBuf::from("."))
            .to_string_lossy()
            .to_string()
    });

    Config {
        history_path: format!("{}/last_dev", xdg_config_home),
    }
}


fn get_parameters(matches: ArgMatches) -> Option<Inst> {
    let nix_rename  = !matches.contains_id("no-rename");
    let nix_shell   = !matches.contains_id("no-nix-shell");
    let mono        = !matches.contains_id("split");
    let attach      = !matches.contains_id("no-attach");
    let save_history= !matches.contains_id("no-history");

    let directory = if let Some(dir) = matches.get_one::<String>("directory") {
        fs::canonicalize(dir).unwrap_or_else(|_| {
            eprintln!("Invalid directory");
            std::process::exit(1);
        })
    } else {
        return None;
    };
    env::set_current_dir(&directory).expect("Failed to change directory");

    let session_name = directory
        .file_name()
        .unwrap_or_default()
        .to_string_lossy()
        .to_string();

    Some(Inst{
        directory,
        session_name,
        nix_rename,
        nix_shell,
        save_history,
        mono,
        attach,
    })
}

fn run_last_command(config: &Config){
    if fs::metadata(&config.history_path).is_ok() {
        let last_cmd = fs::read_to_string(&config.history_path).unwrap_or_default();
        println!("Running last command: {}", last_cmd);
        std::process::Command::new("bash")
            .arg("-c")
            .arg(&last_cmd)
            .status()
            .unwrap();
        return;
    } else {
        eprintln!("No previous command found.");
        std::process::exit(1);
    };
}

fn initiate_tmux(inst: Inst){
    Command::new("tmux")
        .args(["new-session", "-d", "-s", &inst.session_name])
        .status()
        .expect("Failed to start tmux session");

    if inst.nix_shell {
        if PathBuf::from("flake.nix").exists() && inst.nix_rename {
            let rename_cmd = r#"tmux rename-session "$(nix --quiet develop --quiet -c bash -c 'env | awk -F= '\''{ if ($1 == "name") print $2 }'\'')" ; clear"#;
            Command::new("tmux")
                .args(["send-keys", "-t", &format!("{}:1.0", inst.session_name), rename_cmd, "Enter"])
                .status()
                .ok();
        }

        if !inst.mono {
            Command::new("tmux")
                .args(["split-window", "-h", "-t", &format!("{}:1", inst.session_name), "nix develop --impure"])
                .status()
                .ok();
        }

        Command::new("tmux")
            .args(["send-keys", "-t", &format!("{}:1.0", inst.session_name), "nix develop --impure", "Enter"])
            .status()
            .ok();
    }

    if inst.attach || env::var("TERM").unwrap_or_default() != "screen" || env::var("TMUX").is_err() {
        Command::new("tmux")
            .args(["attach-session", "-t", &inst.session_name])
            .status()
            .ok();
    } else {
        println!("Already inside tmux, not attaching to new session");
    }
}

fn main() {
    let matches = ClapCommand::new("dev")
        .about("Launch a dev environment with tmux and nix")
        .arg(Arg::new("directory").index(1))
        .arg(Arg::new("no-rename").short('r'))
        .arg(Arg::new("no-nix-shell").short('k'))
        .arg(Arg::new("split").short('s'))
        .arg(Arg::new("no-history").short('n'))
        .arg(Arg::new("no-attach").short('a'))
        .get_matches();



    let config = get_config();

    let cmd = get_parameters(matches).unwrap_or_else(|| {
        run_last_command(&config);
        std::process::exit(0);
    });

    if cmd.save_history {
        let args = std::env::args().skip(1).collect::<Vec<_>>().join(" ");
        fs::write(&config.history_path, format!("dev {} {}", cmd.directory.display(), args)).ok();
    }

    initiate_tmux(cmd);
}
