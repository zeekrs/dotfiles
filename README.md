# dotfiles

## dot files management by [chezmoi](https://chezmoi.io/)

### tool set

- [fish shell](https://github.com/fish-shell/fish-shell)
- [starship](https://github.com/starship/starship)
- [alacritty](https://github.com/alacritty/alacritty)
- [tmux](https://github.com/tmux/tmux)
- [karabiner](https://github.com/pqrs-org/Karabiner-Elements)
- [yabai](https://github.com/koekeishiya/yabai)
- [skhd](https://github.com/koekeishiya/skhd)
- [sketchybar](https://github.com/FelixKratz/SketchyBar)
- [neovim](https://github.com/neovim/neovim)
- [homebrew](https://github.com/Homebrew/brew)
- [volta](https://github.com/volta-cli/volta)
- [sdkman](https://github.com/sdkman/sdkman-cli)
- [joshuto](https://github.com/kamiyaa/joshuto)
- [fzf](https://github.com/junegunn/fzf)
- [bat](https://github.com/sharkdp/bat)
- [bottom](https://github.com/ClementTsang/bottom)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [neofetch](https://github.com/dylanaraps/neofetch)

### Installation

- [install chezmoi](https://www.chezmoi.io/install)

- edit chezmoi config file

  ```bash
    echo "[data]
      email = \${YOUR_EMAIL}" > ~/.config/chezmoi/chezmoi.toml
  ```

- initialize dot files

  ```bash
    chezmoi init git@github.com:zeekrs/dotfiles.git
  ```

- check diff

  ```bash
    chezmoi diff
  ```

- apply changes

  ```bash
    chezmoi apply -v
  ```

- pull and apply the latest changes from repo

  ```bash
    chezmoi update -v
  ```
