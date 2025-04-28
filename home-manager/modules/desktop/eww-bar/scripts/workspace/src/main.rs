use i3ipc::I3Connection;
use std::time::Duration;

fn main() {
    // Establish connection to i3
    let mut conn = I3Connection::connect().expect("Unable to connect to i3");

    let mut ws_open = [false, false, false, false, false, false, false ,false, false];
    let mut ws_vis = [false, false, false, false, false, false, false ,false, false];
    
    let mut change = false;

    loop {
        let mut workspaces = conn
            .get_workspaces()
            .expect("Failed to get workspaces")
            .workspaces;
        workspaces.sort_by(|a, b| a.num.cmp(&b.num));
        //println!("{:?}",workspaces);


        let mut ws_idx = 0;
        for idx in 0..9 as usize{
            let ws_i_num = if ws_idx < workspaces.len() {workspaces[ws_idx].num} else {-1};
            let ws_i_vis = if ws_idx < workspaces.len() {workspaces[ws_idx].visible} else {false};

            if ws_i_num == idx as i32 {
                //println!("check {}", idx);
                if ws_vis[idx] != ws_i_vis {
                    ws_vis[idx] = ws_i_vis;
                    change = true;
                }
                if !ws_open[idx] {
                    ws_open[idx] = true;
                    change = true;
                }
                ws_idx+=1;
            } else {
                if ws_vis[idx]{
                    ws_vis[idx] = false;
                    change = true;
                }
                if ws_open[idx] {
                    ws_open[idx] = false;
                    change = true;
                }
            }
        }
        //println!("{:?}",ws_open);
        //println!("{:?}",ws_vis);
        if change {
            print!("(defwidget workspaces [] (box  :orientation \"h\" :class \"workspaces\" :space-evenly true :spacing 10");

            for idx in 0..9 as usize{
                if ws_open[idx] && !ws_vis[idx]{
                    print!("(button :class \"workspace\" :onclick \"i3-msg workspace {:}\" \"{:}\")",idx,idx);
                }
                if ws_open[idx] && ws_vis[idx]{
                    print!("(button :class \"workspace visible\" :onclick \"i3-msg workspace {:}\" \"{:}\")",idx,idx);
                }
            }

            println!("))");
        }
        change = false;

    }
}
