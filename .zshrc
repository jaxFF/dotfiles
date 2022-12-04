export LANG=en_US.UTF-8

HISTFILE=~/.bash_history
ZSH_THEME=jax

ENABLE_CORRECTION="true"
DISABLE_UPDATE_PROMPT="true"

setopt noautomenu
setopt nomenucomplete
setopt nocorrectall
setopt correct

plugins=(
    colorize
    git
    python
    archlinux
    emoji
    zsh-syntax-highlighting
    zsh-autosuggestions
)

export ZSH_CUSTOM="$HOME/.config/ohmyzsh/"
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

alias tmux="tmux -u"
export EDITOR='nvim'

# WSL specific aliases and such
kernel=$(cat /proc/version)
if [[ $kernel =~ "microsoft" ]]
then

export PATH=$PATH:$HOME/bin

# tmux seems to inherit the wrong enivroment if more than one session is running.
#  We observe that in the second-created session, the WSL set enviroment variables
#  from the terminal are not available in tmux.
# We easily get around this by always starting a new tmux session on a *different*
#  socket. Here are links tracking the bug:
# https://github.com/microsoft/WSL/issues/8706#issuecomment-1211458435
# https://bugs.x2go.org/cgi-bin/bugreport.cgi?bug=1591
alias tmux="tmux -uL other"

sudo sh -c "echo :WindowsBatch:E::bat::/init: > /proc/sys/fs/binfmt_misc/register" > /dev/null 2>&1

# KeeAgent -- https://gist.github.com/strarsis/e533f4bca5ae158481bbe53185848d49
. ~/wsl-ssh-agent-forwarder

alias msbuild="msbuild.exe"
alias cl="cl.exe"
alias clang-cl="clang-cl.exe"
alias lib="lib.exe"
alias nmake="nmake.exe"
alias xcopy="xcopy.exe"
alias setx="setx.exe"
alias dumpbin="dumpbin.exe"
alias devenv="devenv.exe"
fi

# Initalize the completion system
autoload -Uz compinit && compinit
