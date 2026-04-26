function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase

    bind \cg 'commandline -r lazygit; commandline -f execute'
    bind -M insert \cg 'commandline -r lazygit; commandline -f execute'

    bind \cz 'commandline -r zz; commandline -f execute'
    bind -M insert \cz 'commandline -r zz; commandline -f execute'

    fzf_configure_bindings --variables=\cv --directory=\ct --history=

    bind \cp _atuin_bind_up
    bind -M insert \cp _atuin_bind_up

    bind \cr _atuin_search
    bind -M insert \cr _atuin_search

end
set -g fish_key_bindings fish_hybrid_key_bindings
