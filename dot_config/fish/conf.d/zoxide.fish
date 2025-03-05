set -x _ZO_FZF_OPTS "
--exact \
--no-sort \
--bind=ctrl-z:ignore,btab:up,tab:down \
--cycle \
--keep-right \
--border=sharp \
--info=inline \
--tabstop=1 \
--exit-0 \
--select-1 \
--preview='_fzf_preview_file {2..}' \
--preview-window=up,40%,sharp \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--color=border:#313244,label:#cdd6f4
"
