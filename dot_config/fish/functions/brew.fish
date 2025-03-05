
function brew -d "brew with update sketchybar state"

    command brew $argv

    if contains -- $argv upgrade || contains -- $argv update || contains -- $argv outdated
        /opt/homebrew/bin/top_bar --trigger brew_update
    end
end
