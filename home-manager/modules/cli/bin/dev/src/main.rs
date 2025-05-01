use clap::{
    Parser,
};
use std::{
    env,
    fs,
    path::PathBuf,
    process::Command,
};

struct Config{
    history_path: String,
}

#[derive(Parser)]
#[command(version, about = "Launch a dev environment with tmux and nix", long_about = None)]
struct Cli {
    /// Directory to start the tmux session in
    directory: Option<PathBuf>,

    /// Set a session name
    #[arg(short = 'n', default_value="")]
    session_name: String,

    /// Do not save a history
    #[arg(short = 's')]
    no_save_history: bool,

    /// Do not attach to the tmux server
    #[arg(short = 'a')]
    no_attach: bool,

    /// Initiate a nix shell
    #[arg(short = 'k')]
    nix_shell: bool,

    /// Rename the session based on the nix session
    #[arg(short = 'r')]
    nix_rename: bool,
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

fn initiate_tmux(inst: Cli){
    Command::new("tmux")
        .args(["new-session", "-d", "-s", &inst.session_name])
        .spawn()
        .expect("Failed to start tmux session");

    if inst.nix_shell {
        if PathBuf::from("flake.nix").exists() && inst.nix_rename {
            let rename_cmd = r#"tmux rename-session "$(nix --quiet develop --quiet -c bash -c 'env | awk -F= '\''{ if ($1 == "name") print $2 }'\'')" ; clear"#;
            Command::new("tmux")
                .args(["send-keys", "-t", &format!("{}:1.0", inst.session_name), rename_cmd, "Enter"])
                .status()
                .ok();
        }

        Command::new("tmux")
            .args(["send-keys", "-t", &format!("{}:1.0", inst.session_name), "nix develop --impure", "Enter"])
            .status()
            .ok();
    }

    if !inst.no_attach {
        if env::var("TERM").unwrap_or_default() != "screen" || env::var("TMUX").is_err() {
            Command::new("tmux")
                .args(["attach-session", "-t", &inst.session_name])
                .status()
                .ok();
        } else {
            Command::new("tmux")
                .args(["switch-client", "-t", &inst.session_name])
                .status()
                .ok();
        }
    }
}

fn main() {
    let config = get_config();
    let mut cli = Cli::parse();

    match cli.directory{
        None => {
            run_last_command(&config);
            std::process::exit(0);
        }
        Some(ref path) => {
            let directory = fs::canonicalize(path.clone()).unwrap_or_else(|_| {
                eprintln!("Invalid directory");
                std::process::exit(1);
            });
             
            if cli.session_name == "" {
                cli.session_name = directory
                    .file_name()
                    .unwrap_or_default()
                    .to_string_lossy()
                    .to_string();
            }
            env::set_current_dir(&directory).expect("Failed to change directory");

            if !cli.no_save_history {
                let args = std::env::args().skip(1).collect::<Vec<_>>().join(" ");
                fs::write(&config.history_path, format!("dev {} {}", path.display(), args)).ok();
            }

            initiate_tmux(cli);
        }
    }

}
