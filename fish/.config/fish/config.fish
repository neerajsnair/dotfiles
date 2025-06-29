#aliases
# SYSTEM ALIAS'S
alias hl='Hyprland'
alias sdn='shutdown now'
#alias ff='fastfetch'
alias linutil='curl -fsSL https://christitus.com/linux | sh'
alias bctl='brightnessctl'
alias clip='cliphist list | fzf --no-sort | cliphist decode | wl-copy'
alias ff="fzf --multi --preview='bat --color=always {}' | xargs -r nvim"
alias fc='fzf | wl-copy'
alias fkill="ps aux | fzf --multi | awk '{print $2}' | xargs kill"
alias hist-prune='history | fzf | read --line cmd; and history delete --exact --case-sensitive "$cmd"'

#pacman alias
alias ins="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias rem="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rs"


# Set the default editor
export EDITOR="nvim"
export VISUAL="nvim"
export TERMINAL="kitty"
export BROWSER="chromium"
export VIDEO="mpv"
export IMAGE="loupe"
export OPENER="xdg-open"

alias pico='edit'
alias spico='sedit'
alias nano='edit'
alias snano='sedit'
alias cat='bat'

# Alias's to modified commands
alias cp='cp -i'
alias mv='mv -i'
alias rm='trash'
alias mkdir='mkdir -p'
alias fd='fd -H'
alias ps='ps auxf'
alias ping='ping -c 10'
alias less='less -R'
alias cls='clear'
alias nv='nvim'
alias svi='sudoedit'
alias vis='nvim "+set si"'

# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Alias's for multiple directory listing commands
alias ls='eza --icons --color=always --hyperlink --group-directories-first -aF'
alias ll='eza --icons --color=always --hyperlink --group-directories-first -alF'

#alias la='ls -Alh'                # show hidden files
#alias ls='ls -aFh --color=always' # add colors and file type extensions
#alias lx='ls -lXBh'               # sort by extension
#alias lk='ls -lSrh'               # sort by size
#alias lc='ls -ltcrh'              # sort by change time
#alias lu='ls -lturh'              # sort by access time
#alias lr='ls -lRh'                # recursive ls
#alias lt='ls -ltrh'               # sort by date
#alias lm='ls -alh |more'          # pipe through 'more'
#alias lw='ls -xAh'                # wide listing format
#alias ll='ls -Fls'                # long listing format
#alias labc='ls -lap'              # alphabetical sort
#alias lf="ls -l | grep -vE '^d'"  # files only
#alias ldir="ls -l | grep  -E '^d'"   # directories only
#lias lla='ls -Al'                # List and Hidden Files
#lias las='ls -A'                 # Hidden Files
#lias lls='ls -l'                 # List

# alias chmod commands
alias mx='chmod a+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
alias 777='chmod -R 777'

# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# set up XDG folders
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

#=============================================================================
#
# Yazi
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end
#============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    string replace --regex -- '^function cd\s' 'function __zoxide_cd_internal ' <$__fish_data_dir/functions/cd.fish | source
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    if set -q __zoxide_loop
        builtin echo "zoxide: infinite loop detected"
        builtin echo "Avoid aliasing `cd` to `z` directly, use `zoxide init --cmd=cd fish` instead"
        return 1
    end
    __zoxide_loop=1 __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (builtin count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if test $argc -eq 2 -a $argv[1] = --
        __zoxide_cd -- $argv[2]
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (builtin commandline --current-process --tokenize)
    set -l curr_tokens (builtin commandline --cut-at-cursor --current-process --tokenize)

    if test (builtin count $tokens) -le 2 -a (builtin count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(builtin commandline --cut-at-cursor --current-token) | string match --regex -- '.*/$'
    else if test (builtin count $tokens) -eq (builtin count $curr_tokens)
        # If the last argument is empty, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (command zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and __zoxide_cd $result
        and builtin commandline --function cancel-commandline repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase z &>/dev/null
alias z=__zoxide_z

abbr --erase zi &>/dev/null
alias zi=__zoxide_zi

# =============================================================================

starship init fish | source

# =============================================================================

# Set up fzf key bindings
fzf --fish | source

