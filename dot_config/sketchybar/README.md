# SketchyBar

## Installation

### Dependencies

- lua
- sketchybar
- sf-symbols
- font-sf-mono
- font-sf-pro

```bash
brew install lua
brew tap FelixKratz/formulae
brew install sketchybar


# Fonts
brew install --cask sf-symbols
brew install --cask font-sf-mono
brew install --cask font-sf-pro

curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.32/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
```

### Linking

```bash
 ln -s $(which sketchybar) $(dirname $(which sketchybar))/top_bar
 ln -s $(which sketchybar) $(dirname $(which sketchybar))/bottom_bar

```

## Thanks

- [sketchybar](https://github.com/FelixKratz/sketchybar)
- [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font)
- [sbarlua](https://github.com/FelixKratz/SbarLua)
- [sketchybar-system-stats](https://github.com/joncrangle/sketchybar-system-stats)
