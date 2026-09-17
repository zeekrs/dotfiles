if status is-interactive
    set -gx ATUIN_NOBIND true

    atuin init fish | source

    starship init fish | source

    zoxide init fish | source

    orb completion fish | source

    hostctl completion fish | source

end

# Lang
set -x LANG en_US.UTF-8
set -x LC_ALL en_US.UTF-8

# config file
set -x XDG_CONFIG_HOME "$HOME/.config"

#Editor
set -x EDITOR nvim

# ripgrep
set -x RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
