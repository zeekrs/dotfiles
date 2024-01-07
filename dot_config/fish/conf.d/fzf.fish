
set -x FZF_DEFAULT_OPTS "--cycle --keep-right --border=sharp --info=inline --preview-window=up,30%,sharp"
set -x _ZO_FZF_OPTS "--exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --info=inline --tabstop=1 --exit-0 --select-1 --preview='__fzf_preview_file {2..}' --preview-window=up,30%,sharp"
