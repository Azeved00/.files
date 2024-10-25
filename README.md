# HI! These are my .files.

I like minimalistic GUIs as well as knowing exacly what and how im using the applications,
I also don`t like bloatware as such I keep programs I use to a minimum and most of them are customized.

## Theme
The theme i use is [Bright Bit](https://github.com/Azeved00/bright-bit)

## Aplications:

## Applications Overview

This system is built on **NixOS**, and uses the following applications.

### Core System
- **[Nix](https://github.com/NixOS/nix)** - Declarative package manager and system configuration tool.
- **[Home-Manager](https://github.com/nix-community/home-manager)** - Manages user-level configurations through Nix.
- **[I3](https://github.com/i3/i3)** - Window Manager
- **[EWW](https://github.com/elkowar/eww)** - Custom status Bar

### Productivity and Utilities
- **[Firefox](https://www.mozilla.org/en-US/firefox/)** - Primary web browser.
- **[Alacrity](https://github.com/alacritty/alacritty)** - Terminal emulator.
- **[Zathura](https://github.com/pwmt/zathura)** - PDF Viewer
- **[Feh](https://github.com/derf/feh)** - Image Viewer

### Development Tools
- **[NeoVim](https://github.com/neovim/neovim)** - Primary text editor.
- **[Tmux](https://github.com/tmux/tmux)** - Terminal multiplexer.
- **[LF](https://github.com/gokcehan/lf)** -  File Manager.

For more info and what applications I`m using you can checkout the individual modules.
And feel free to take what you want and use them as you need. **Have fun!**

## Files and Folders
| Folder                         | Description                              |
| -----------                    | -----------                              |
| [Assets](./Assets)             | Assets used (backgrounds and icons)      |
| [Home-Manager](./home-manager) | Configuration files for Home-Manager( user level) | 
| [NixOs](./NixOs)               | NixOs configuration files                |
| [Dev templates](./dev-template)| Custom development templates             |
| [Lib](./lib)                   | Custom nix functions                     |

## Installing & configuring

0. Notes and Pre-requesits
    - `git` is necessary to install these dotfiles, you can use `nix-shell -p git` for a temporary install

1. Clone the Repository

```bash
    git clone https://your-repo-url.git
    cd your-repo-folder
```

2. Set Up the System Profile

Open the `flake.nix` file in your preferred text editor.

Add a system profile from `./nixos/profiles/`. Use the following line, 
replacing profile with the name of your profile (i.e., the file name without extension):

```nix
    nixosConfigurations.profile = mkSystem system ./nixos/profiles/profile;
```

3. Install the System Configuration

Run the following command to apply the system configuration:

```bash
    sudo nixos-rebuild switch --flake .#profile
```

4. Set Up the User Configuration

Open `flake.nix` again, and add the user configuration from `./home-manager/profiles/`. 

Add the following line, replacing profile with your profile name:

```nix
    homeConfigurations.profile = mkHome system ./home-manager/profiles/profile;
```

5. Install the User Configuration

Apply the user configuration by running:

```bash
home-manager switch --flake .#profile
```

## Credits
[One half](https://github.com/sonph/onehalf)

[Bright Bit](https://github.com/Azeved00/bright-bit)

Rofi theme is [rounded](https://github.com/newmanls/rofi-themes-collection) with custom colors

[The eww bar](https://github.com/saimoomedits/eww-widgets.git) with custom colors
