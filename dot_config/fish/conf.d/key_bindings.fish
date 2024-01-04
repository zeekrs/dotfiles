function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase


    bind \cg lazygit
    bind \cz yazi
    bind -M insert \cg lazygit
    bind -M insert \cz yazi
    fzf_configure_bindings --directory=\ct --git_log=\e/
end
set -g fish_key_bindings fish_hybrid_key_bindings
