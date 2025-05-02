use clap::Parser;
use std::{
    env, fs,
    path::PathBuf,
    process::Command,
};
use serde::Deserialize;
use std::collections::HashMap;

const DEFAULT_CONFIG_PATH:&str = "$XDG_CONFIG_HOME/dev/config.toml";

#[derive(Deserialize, Clone, Debug)]
struct Session{
    #[serde(default = "default_num_windows")]
    windows: i64,
    #[serde(default = "default_nix_shell")]
    nix_shell: String,
    path: String,
    #[serde(default = "default_title")]
    title: String,
    #[serde(default = "default_attach")]
    attach: bool,
    #[serde(default = "default_nix_rename")]
    nix_rename: bool,
}
fn default_num_windows() -> i64{ 1 }
fn default_nix_shell() -> String { "default".to_string() }
fn default_title() -> String { "".to_string() }
fn default_attach() -> bool { true }
fn default_nix_rename() -> bool { false }

#[derive(Deserialize)]
struct Config{
    sessions: HashMap<String, Session>,
}


#[derive(Parser)]
#[command(version, about = "Launch a dev environment with tmux and nix", long_about = None)]
struct Cli {
    /// Directory to start the tmux session in
    #[arg(short = 'd', default_value=".")]
    directory: PathBuf,

    /// Set a session title,
    /// If no title is given then the basename of the directory is used
    #[arg(short = 't', default_value="")]
    session_title: String,

    ///  Use a saved session from config
    #[arg(short = 'n')]
    session_name: Option<String>,

    /// Do not attach to the tmux server
    #[arg(short = 'a')]
    no_attach: bool,

    /// Initiate a nix shell
    #[arg(short = 'k')]
    nix_shell: bool,

    /// Rename the session based on the nix session
    #[arg(short = 'r')]
    nix_rename: bool,

    /// Give a custom config
    #[arg(short = 'c', long="config", default_value=DEFAULT_CONFIG_PATH)]
    config: PathBuf,
}

fn expand_env_vars(path: &str) -> PathBuf {
    let expanded = shellexpand::full(path).unwrap();
    PathBuf::from(expanded.as_ref())
}

fn get_config(path:PathBuf) -> Result<Config, Box<dyn std::error::Error>> {
    let b = path.to_string_lossy();
    let expanded = shellexpand::full(&b).unwrap();
    let content = fs::read_to_string(expanded.as_ref())?; 
    let config: Config = toml::from_str(&content)?;
    Ok(config)
}

fn initiate_tmux(session: Session){
    Command::new("tmux")
        .args(["new-session", "-d", "-s", &session.title])
        .spawn()
        .expect("Failed to start tmux session");


    if PathBuf::from("flake.nix").exists() &&session.nix_rename {
        let rename_cmd = r#"tmux rename-session "$(nix --quiet develop --quiet -c bash -c 'env | awk -F= '\''{ if ($1 == "name") print $2 }'\'')" ; clear"#;
        Command::new("tmux")
            .args(["send-keys", "-t", &format!("{}:1.0", session.title), rename_cmd, "Enter"])
            .status()
            .ok();
    }

    Command::new("tmux")
        .args(["send-keys", "-t", &format!("{}:1.0", session.title), &format!("nix develop --impure .#{}", session.nix_shell), "Enter"])
        .status()
        .ok();


    if session.attach {
        if env::var("TERM").unwrap_or_default() != "screen" || env::var("TMUX").is_err() {
            Command::new("tmux")
                .args(["attach-session", "-t", &session.title])
                .status()
                .ok();
        } else {
            Command::new("tmux")
                .args(["switch-client", "-t", &session.title])
                .status()
                .ok();
        }
    }
}

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let mut cli = Cli::parse();
    let mut config = get_config(cli.config.clone())?;


    let s = match cli.session_name {
        Some(name) => {
            let s = config.sessions.get_mut(&name).unwrap_or_else(|| {
                eprintln!("No session with that name in the config file");
                std::process::exit(1);
            });

            let path = expand_env_vars(&s.path);
            let directory = fs::canonicalize(path).unwrap_or_else(|_| {
                eprintln!("Invalid directory");
                std::process::exit(1);
            });

            env::set_current_dir(&directory).expect("Failed to change directory");

            if s.title == "" {
                s.title = directory
                    .file_name()
                    .unwrap_or_default()
                    .to_string_lossy()
                    .to_string();
            }

            s.clone()
        }

        None => {
            let directory = fs::canonicalize(cli.directory.clone()).unwrap_or_else(|_| {
                eprintln!("Invalid directory");
                std::process::exit(1);
            });

            env::set_current_dir(&directory).expect("Failed to change directory");

            if cli.session_title == "" {
                cli.session_title = directory
                    .file_name()
                    .unwrap_or_default()
                    .to_string_lossy()
                    .to_string();
            }

            Session {
                windows: 1,
                title: cli.session_title,
                attach: !cli.no_attach,
                nix_rename: cli.nix_rename,
                nix_shell: "default".to_string(),
                path: "".to_string(),
            }
        }
    };

    //println!("{:?}", s);

    initiate_tmux(s);
    Ok(())
}
