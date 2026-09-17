function fish_greeting
    if test "$TERM_PROGRAM" = tmux
        and not test -n "$NVIM"
        print_spark_line
        macchina
    end
end
