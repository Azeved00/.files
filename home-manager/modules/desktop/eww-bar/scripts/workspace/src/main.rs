use i3ipc::I3Connection;
use std::thread;
use std::time::Duration;

/// Small program to connect to i3 Server and get workspace status for eww
/// 
/// This program returns an eww widget to be used as literal
fn main() {
    let mut conn = I3Connection::connect().expect("Unable to connect to i3");

    let mut ws_open: u16 = 0;
    let mut ws_vis: u16 = 0;
    let arr = ["0", "", "", "", "", "5", "󰍹", "7", "8" ];
    
    loop {
        let workspaces = conn
            .get_workspaces()
            .expect("Failed to get workspaces")
            .workspaces;

        let mut new_ws_open: u16 = 0;
        let mut new_ws_vis: u16 = 0;

        for ws in workspaces{
            new_ws_open |= 1 << ws.num;
            if ws.visible {
                new_ws_vis |= 1 << ws.num;
            }
        }

        if ws_open != new_ws_open || ws_vis != new_ws_vis {
            ws_open = new_ws_open;
            ws_vis = new_ws_vis;
            
            print!("(box  :orientation \"h\" :class \"workspaces\" :space-evenly true :spacing 10");
            for idx in 0..9 as usize{
                let is_open = (ws_open & (1 << idx)) != 0;
                let is_vis = (ws_vis & (1 << idx)) != 0;

                if is_open {
                    if is_vis {
                        print!(" (button :class \"workspace visible\" :onclick \"i3-msg workspace {:}\" \"{:}\")",idx,arr[idx]);
                    } else {
                        print!(" (button :class \"workspace\" :onclick \"i3-msg workspace {:}\" \"{:}\")",idx,arr[idx]);
                    }
                }
            }

            println!(")");

        }

        thread::sleep(Duration::from_millis(200));
    }
}
