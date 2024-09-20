# HI! These are my .files.

I like minimalistic GUIs as well as knowing exacly what and how im using the applications,
I also don`t like bloatware as such I keep programs I use to a minimum and most of them are customized.

## Theme
The theme i use is [Bright Bit](https://github.com/Azeved00/bright-bit)

## Aplications:
- Text Editor -> [NeoVim](https://github.com/neovim/neovim)
- Managing Configuration Files -> [Home-Manager](https://github.com/nix-community/home-manager)
- File Browser -> [LF](https://github.com/gokcehan/lf)
- Terminal multiplexer -> [Tmux](https://github.com/tmux/tmux)
- Window Manager -> [I3](https://github.com/i3/i3)
- Bar -> [EWW](https://github.com/elkowar/eww)
- Browser -> [Firefox](https://www.mozilla.org/en-US/firefox/)
- Terminal -> [Alacrity](https://github.com/alacritty/alacritty)

Feel free to take what you want and use them as you need. **Have fun!**

## Files and Folders
| Folder                         | Description                              |
| -----------                    | -----------                              |
| [Assets](./Assets)             | Assets used (backgrounds and icons)      |
| [Home-Manager](./home-manager) | Configuration files for [Home-Manager](https://github.com/nix-community/home-manager) (user level) | 
| [NixOs](./NixOs)               | NixOs configuration files                |
| [Dev templates](./dev-template)| Custom development templates             |

## Installing & configuring

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
