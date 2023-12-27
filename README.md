# zeekrs' dotfiles

## zeekrs' dot files - management by [chezmoi](https://chezmoi.io/)

### tool set

- [fish shell](https://github.com/fish-shell/fish-shell) -
  Command line shell for the 90s
- [starship](https://github.com/starship/starship) -
  The minimal, blazing-fast, and infinitely customizable prompt for any shell!
- [alacritty](https://github.com/alacritty/alacritty) -
  Fast, cross-platform, OpenGL terminal emulator
- [tmux](https://github.com/tmux/tmux) -
  terminal multiplexer
- [karabiner](https://github.com/pqrs-org/Karabiner-Elements) -
  Powerful utility for keyboard customization on macOS
- [yabai](https://github.com/koekeishiya/yabai) -
  Tiling window manager for macOS based on binary space partitioning
- [skhd](https://github.com/koekeishiya/skhd) -
  Simple hotkey daemon for macOS
- [sketchybar](https://github.com/FelixKratz/SketchyBar) -
  Highly customizable macOS status bar replacement
- [neovim](https://github.com/neovim/neovim) -
  Vim like Editor
- [homebrew](https://github.com/Homebrew/brew) -
  The missing package manager for macOS
- [volta](https://github.com/volta-cli/volta) -
  JS Toolchains as Code. ⚡
- [sdkman](https://github.com/sdkman/sdkman-cli) -
  Software Development Kit Manager Command Line Interface
- [yazi](https://github.com/sxyazi/yazi) -
  Blazing Fast Terminal File Manager
- [fzf](https://github.com/junegunn/fzf) -
  Command-line fuzzy finder
- [ripgrep](https://github.com/BurntSushi/ripgrep) -
  Recursively searches directories for a regex pattern
- [zoxide](https://github.com/ajeetdsouza/zoxide) -
  Smarter cd command. Supports all major shells.
- [bat](https://github.com/sharkdp/bat) -
  cat(1) clone with syntax highlighting and Git integration.
- [bottom](https://github.com/ClementTsang/bottom) -
  Customizable cross-platform graphical process/system monitor for the terminal
- [lazygit](https://github.com/jesseduffield/lazygit) -
  Simple terminal UI for git commands
- [neofetch](https://github.com/dylanaraps/neofetch) -
  Command-line system information tool
- [eza](https://github.com/eza-community/eza) Modern replacement for ‘ls’.
- [fd](https://github.com/sharkdp/fd) -
  Simple, fast and user-friendly alternative to 'find'
- [procs](https://github.com/dalance/procs) -
  Modern replacement for ps written in Rust
- [sd](https://github.com/chmln/sd) -
  Intuitive find & replace CLI.
- [dust](https://github.com/bootandy/dust) -
  More intuitive version of du in rust
- [tealdeer](https://github.com/dbrgn/tealdeer) -
  Very fast implementation of tldr in Rust.
- [tokei](https://github.com/XAMPPRocky/tokei) -
  Count your code, quickly.
- [grex](https://github.com/pemistahl/grex) -
  Generating regular expressions from user-provided test cases

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
