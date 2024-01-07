function fzf_find_file --description "Search the current directory. Replace the current token with the selected file paths."

    set -f find_cmd $(command -v fd) --color=always --strip-cwd-prefix --hidden --follow --exclude .git

    set -f fzf_arguments --ansi

    if string match -rq '^(z |cd |ls |ll |la ).*' (commandline)
        set --append find_cmd --type d --select-1
        set --prepend fzf_arguments --no-multi
    else
        set --prepend fzf_arguments --multi --marker="*"
    end

    set -f token (commandline --current-token)
    # expand any variables or leading tilde (~) in the token
    set -f expanded_token (eval echo -- $token)
    # unescape token because it's already quoted so backslashes will mess up the path
    set -f unescaped_exp_token (string unescape -- $expanded_token)

    # find the argv[1] for commandline 

    set -f cmd

    # If the current token is a directory and has a trailing slash,
    # then use it as fd's base directory.
    if string match --quiet -- "*/" $unescaped_exp_token && test -d "$unescaped_exp_token"
        set --append find_cmd --base-directory=$unescaped_exp_token
        set --prepend fzf_arguments --prompt="$unescaped_exp_token" --preview='__fzf_preview_file {}'
        set -f file_paths_selected $unescaped_exp_token($find_cmd 2>/dev/null | fzf $fzf_arguments)
    else
        set --prepend fzf_arguments --query="$unescaped_exp_token" --preview='__fzf_preview_file {}'
        set -f file_paths_selected ($find_cmd 2>/dev/null | fzf $fzf_arguments)
    end

    if test $status -eq 0
        commandline --current-token --replace -- (string escape -- $file_paths_selected | string join ' ')
    end

    commandline -f repaint
end
