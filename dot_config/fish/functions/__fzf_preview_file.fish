
function __fzf_preview_file --description "Print a preview for the given file based on its file type."
    function __fzf_report_file_type --argument-names file_path file_type --description "Explain the file type for a file."
        set_color red
        echo "Cannot preview '$file_path': it is a $file_type."
        set_color normal
    end
    # because there's no way to guarantee that _fzf_search_directory passes the path to _fzf_preview_file
    # as one argument, we collect all the arguments into one single variable and treat that as the path
    set -f file_path $argv

    if test -L "$file_path" # symlink
        # notify user and recurse on the target of the symlink, which can be any of these file types
        set -l target_path (realpath "$file_path")

        set_color yellow
        echo "'$file_path' is a symlink to '$target_path'."
        set_color normal

        __fzf_preview_file "$target_path"
    else if test -f "$file_path" # regular file
        if file --mime-type $file_path | grep -qF image/
            __fzf_report_file_type "$file_path" "image file"
        else
            bat --style=numbers --color=always "$file_path"
        end
    else if test -d "$file_path" # directory
        ls -a "$file_path"
    else if test -c "$file_path"
        __fzf_report_file_type "$file_path" "character device file"
    else if test -b "$file_path"
        __fzf_report_file_type "$file_path" "block device file"
    else if test -S "$file_path"
        __fzf_report_file_type "$file_path" socket
    else if test -p "$file_path"
        __fzf_report_file_type "$file_path" "named pipe"
    else
        echo "$file_path doesn't exist." >&2
    end
end
