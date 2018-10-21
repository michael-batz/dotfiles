# .bashrc 

# prompt definition
PROMPT_COMMAND="PROMPT_EXTENSION=\$(prompt_git)"
PS1="[\u@\h: \w]\$PROMPT_EXTENSION\$ "
PROMPT_DIRTRIM=4

# alias definition
alias vi='vim'

# update window size after each command
shopt -s checkwinsize

# function: print git status information
function prompt_git()
{
    # get branch
    local BRANCH=$(git status -b --porcelain 2> /dev/null | grep '##' --color=never | cut -d ' ' -f 2)
    # if a branch could be found
    if [ -n "${BRANCH}" ]; then
        # get marker of changed files
        local CHANGECOUNTER=$(git status --porcelain 2> /dev/null | wc -l)
        local CHANGEDMARKER=""
        if [ $CHANGECOUNTER -gt 0 ]; then
            CHANGEDMARKER="*"
        fi
        # print git prompt
        echo "[git:${BRANCH}${CHANGEDMARKER}]"
    fi
}
