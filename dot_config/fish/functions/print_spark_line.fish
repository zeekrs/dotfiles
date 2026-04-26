function print_spark_line
    echo
    seq 1 (tput cols) | sort -R | spark | lolcat
end
