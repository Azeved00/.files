use std::fs;
use std::process::Command;

const BAT_PATH= "/sys/class/power_supply/BAT0";

fn read_file(path: &str) -> String {
    fs::read_to_string(path).unwrap_or_default().trim().to_string()
}

fn monitor_battery() {
    let mut last_status = String::new();
    let mut last_capacity = 255; // force initial update
    let capacity_path = format!("{BAT_PATH}/capacity");
    let status_path = format!("{BAT_PATH}/status");

    loop {
        let status = read_file(status_path);
        let capacity_str = read_file(capacity_path);
        let capacity: u8 = capacity_str.parse().unwrap_or(0);
        
        if status != last_status || capacity != last_capacity {
            last_status = status.clone();
            last_capacity = capacity;

            let icon = match status {
                "Charging" => "",
                _ => { 
                    match per {
                        91..=100 => "󰁹",
                        81..=90 => "󰂂",
                        71..=80 => "󰂀",
                        61..=70 => "󰁿",
                        51..=60 => "󰁾",
                        41..=50 => "󰁽",
                        31..=40 => "󰁼",
                        21..=30 => "󰁻",
                        11..=20 => "󰁺",
                        0..=10 => "󰂃",
                        _ => "X",
                    }
                }
            }

            println!("{} {}%", icon,capacity);
        }
        thread::sleep(Duration::from_millis(200)); 
    }
}

fn main() {
    monitor_battery();

}

