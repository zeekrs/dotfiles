# if you want to reset it 
# use set -e fish_user_paths 
#
# homebrew 
fish_add_path fish_user_paths /opt/homebrew/bin

# volta
fish_add_path fish_user_paths "$HOME/.volta/bin"

fish_add_path fish_user_paths "$HOME/.local/bin"

# go 
set -x GOPATH $HOME/go
fish_add_path "$GOPATH/bin"

# libtool coreutils
fish_add_path /opt/homebrew/opt/libtool/libexec/gnubin
fish_add_path /opt/homebrew/opt/make/libexec/gnubin
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

#jpeg 
fish_add_path /opt/homebrew/opt/jpeg/bin
# For compilers to find jpeg
set -gx LDFLAGS -L/opt/homebrew/opt/jpeg/lib
set -gx CPPFLAGS -I/opt/homebrew/opt/jpeg/include
# For pkg-config to find jpeg
set -gx PKG_CONFIG_PATH /opt/homebrew/opt/jpeg/lib/pkgconfig

#k8s
fish_add_path "$HOME/.krew/bin"

# terminfo path
set -gx TERMINFO "$HOME/.local/share/terminfo"

# android 
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"
fish_add_path "$ANDROID_HOME/tools"
fish_add_path "$ANDROID_HOME/tools/bin"
fish_add_path "$ANDROID_HOME/platform-tools"

# ruby 
fish_add_path /opt/homebrew/opt/ruby/bin

#jet brains ide
fish_add_path "/Users/zeekrs/Library/Application Support/JetBrains/Toolbox/scripts"

#conda
fish_add_path /opt/homebrew/anaconda3/bin
