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
- [delta](https://github.com/dandavison/delta) -
  A syntax-highlighting pager for git, diff, and grep output
- [commitizen](https://github.com/commitizen-tools/commitizen) -
  Is release management tool designed for teams.
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
- [hostctl](https://github.com/guumaster/hostctl) -
  Tool to manage /etc/hosts like a pro!
- [atuin](https://github.com/ellie/atuin) -
  Magical shell history
- [dog](https://github.com/ogham/dog) -
  A command-line DNS client.
- [jq](https://github.com/jqlang/jq) -
  Command-line JSON processor
- [jless](https://github.com/PaulJuliusMartinez/jless) -
  A command-line JSON viewer designed for reading, exploring, and searching through JSON data.
- [htmlq](https://github.com/mgdm/htmlq) -
  Like jq, but for HTML.
- [just](https://github.com/casey/just/tree/master) -
  A handy way to save and run project-specific commands.
- [macchina](https://github.com/macchina-cli/macchina) -
  A system information frontend with an emphasis on performance.
- [ouch](https://github.com/ouch-org/ouch) -
  Stands for Obvious Unified Compression Helper.
- [tailspin](https://github.com/bensadeh/tailspin) -
  A log file highlighter
- [xh](https://github.com/ducaale/xh) -
  Friendly and fast tool for sending HTTP requests
- [orbstack](https://github.com/orbstack/orbstack) -
  Fast, light, simple Docker containers & Linux machines for macOS
- [translate-shell](https://github.com/soimort/translate-shell)
  Command-line translator using Google Translate, Bing Translator, Yandex.Translate, etc.

### Installation

- [install chezmoi](https://www.chezmoi.io/install)

- edit chezmoi config file

  ```bash
   echo "[data]
      email = \${YOUR_EMAIL}
      proxy_host = \${YOUR_HOST_PROXY_IF_EXSIT}
      openai_api_host = \${YOUR_HOST_PROXY_IF_EXSIT}
      [diff]
      pager = \"delta --dark --paging=never\"
      " > ~/.config/chezmoi/chezmoi.toml

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
