# dotfiles

## my dot files management by [chezmoi](https://chezmoi.io/)

### tool set

- [fish shell](https://github.com/fish-shell/fish-shell)
- [alacritty](https://github.com/alacritty/alacritty)
- [tmux](https://github.com/tmux/tmux)
- [neovim](https://github.com/neovim/neovim)
- [yabai](https://github.com/koekeishiya/yabai)

### setup

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
