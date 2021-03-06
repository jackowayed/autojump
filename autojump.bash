#This shell snippet sets the prompt command and the necessary aliases
#Only excecute if the shell is bash and it is interactive
if [ "$BASH_VERSION" ] && [ -n "$PS1" ]; then
    _autojump() 
    {
            local cur
            COMPREPLY=()
            unset COMP_WORDS[0] #remove "j" from the array
            cur=${COMP_WORDS[*]}
            IFS=$'\n' read -d '' -a COMPREPLY < <(autojump --completion "$cur")
            return 0
    }
    complete -F _autojump j
    export PROMPT_COMMAND='autojump -a "$(pwd -P)"'
    alias jumpstat="autojump --stat"
    function j { new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; echo; cd "$new_path";fi }
fi
