ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function last_exit_code() {
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        local result="%F{243}$exit_code%{$reset_color%}"
        echo "$result"
    fi
}

PROMPT='%F{247}%n@%F{33}%m%{$reset_color%}:%F{33}$(collapse_pwd)%{$reset_color%}$ '
RPROMPT='$(last_exit_code)   $(git_prompt_short_sha)$(git_prompt_info)$(git_prompt_status)'
