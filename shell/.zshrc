export LANG=en_US.UTF-8
# Ordered by priority
export PATH="$HOME/.local/bin:${PATH}"
export PATH="/local/bin:${PATH}"
export PATH="/data/bin:${PATH}"
export PATH="/home/mallchad/.dotnet/tools:${PATH}"
# True Colour
export TERM=xterm-256color

# qt Themeing
# Only required when Plasma isn't in use
# export QT_QPA_PLATFORMTHEME=qt5ct

export EDITOR=vim
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Options
setopt noautomenu
setopt nomenucomplete
setopt extendedglob
# Error on no glob match
setopt nomatch
# Report change on background status immediately
setopt notify
# Appends every command to the history file once it is executed
setopt inc_append_history
# Reloads the history whenever you use it
setopt share_history
# Disable cd given just a path
unsetopt autocd
# Disable beep on error
unsetopt beep
histfile_depreceated=($HOME/.zsh_history
                      $HOME/.config/zsh/zhistory
                      $HOME/.config/zsh)
HISTFILE=~/.local/share/zsh/history
HISTSIZE=10000
SAVEHIST=10000
bindkey -e
## Variables
zsh_dirty_dir=${HOME}/tmp/session
mkdir -p ${zsh_dirty_dir}
# Startup instructions
# Merge and delete old history files
tmp_histfile=$(dirname $HISTFILE)/history.tmp
mkdir -p $(dirname $tmp_histfile)
for x_histfile in ${histfile_depreceated}
do
    if [[ -f ${x_histfile} ]]
    then
        cat ${x_histfile} >> ${tmp_histfile}
    fi
    if [[ -e ${x_histfile} ]]
    then
        rm -d ${x_histfile}
    fi
done
cat ${HISTFILE} >> ${tmp_histfile}
mv ${tmp_histfile} ${HISTFILE}
unset tmp_histfile
# The following lines were added by compinstall
zstyle :compinstall filename '/home/mallchad/.zshrc'
# Sanity Functions
function DEBUG()
{
    if [[ $DEBUG ]]
    then
        $@
    fi
}
# Only for non-systemd systems, could be updated for Windows maybe?
# Alias and Command Behaviour Modifacation
# alias poweroff="loginctl poweroff"
# alias reboot="loginctl reboot"
# alias halt="loginctl halt"
# alias suspend="loginctl suspend"
alias merge="diff --line-format %L"
alias zmount="mount | column -t"
alias zcp="cp -pnv"
alias zrm="rm -dv"
alias zmv="mv -nv"
alias zdu="du -sh"
alias zdf="df -h"
# Global aliases
alias -g znull="> /dev/null 2> /dev/null"
alias -g ZNULL="> /dev/null 2> /dev/null"
# Because apps like to litter your *real* "home"
export zsh_data_home=${HOME}/userdata
alias -g zhome=$zsh_data_home
# Creates an ISO compliant utc timestamp
# The hyphen + T format is chosen for its readability and
# simplicity when navigating / parsing the format
# Here the Z (zulu) notation is used to be explicit about UTC
# TODO: This would be more useful as a bundled script which is
# copied / linked to a folder on the path
alias -g ztime_stamp="date --utc +%Y-%m-%dT%-H%mZ"
# Show the weather using curl
alias zweather="curl wttr.in"
alias zwth="curl wttr.in"
alias zweatherg="curl v2.wttr.in"
alias zwtg="curl v2.wttr.in"
zpsmem()
{
    ps auxf | sort -nr -k 4
    # Add a duplicate table header at the bottom
    echo "USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
}
zpscpu()
{
    ps auxf | sort -nr -k 3
    # Add a duplicate table header at the bottom
    echo "USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND"
}
zcmake_compile_commands()
{
    echo "Attemtping to use any given generator"
    echo "This may assume UNIX Makefiles"
    cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
    echo "Copying 'compile_commands.json' to parent directory"
    echo -n "Copy - "
    cp -v compile_commands.json ../
}
sudo()
{
    arguments=()
    command=()
    pacman_force=0
    for varg in $@
    do
        DEBUG echo "varg is: " $varg
        DEBUG echo "Current argument list: " $arguments

        if [[ $varg == "--force" ]]
        then
            pacman_force=1
            echo "zpacman: overwriting all files indiscriminantly"
        elif [[ $varg == "pacman" || $varg == "aura" ]]
        then
            command=pacman
            arguments=($arguments $varg)
        else
            arguments=($arguments $varg)
        fi
    done
    if [[ $command == pacman &&  $pacman_force != 0 ]]
    then
        DEBUG echo "final command: ""/usr/bin/sudo" $arguments '--overwrite=*'

        "/usr/bin/sudo" $arguments '--overwrite=*'
    else
        "/usr/bin/sudo" $@
    fi
}
zlsblk()
{
    lsblk -o NAME,FSTYPE,FSAVAIL,FSUSED,FSSIZE,TYPE,MOUNTPOINT,SIZE,MODEL $@
}
zls()
{
    lsd -1A $@
}
zffmpeg()
{
    ffmpeg -hwaccel cuda -n -i $1 -vcodec libx264 $2
}
zlooking-glass-client()
{
    looking-glass-client \
        spice:enable=yes \
        spice:port=5930 \
        egl:multisample=no \
        win:showFPS=no \
        win:fpsMin=144 \
        win:borderless=yes \
        app:renderer=egl \
        app:framePollInterval=100 \
        app:cursorPollInterval=100 \
        app:shmFile=/dev/shm/looking-glass \
        egl:vsync=no \
        app:cursorPollInterval=0 \
        input:grabKeyboardOnFocus=no \
        input:mouseRedraw=yes \
        input:hideCursor=yes \
        input:rawMouse=yes \
        input:mouseSmoothing=false \
        win:ignoreQuit=yes \
        win:noScreensaver=yes \
        win:fullScreen=no \
        win:quickSplash=yes \
        $@
}
zzstd()
{
    target=$1
    tar -cf - $target | zstd -T12 -3 -o $target.tar.zst
}
zssh()
{
    no_fingerprint_check=0
    for varg in $@
    do
        if [[ $varg == "--no-fingerprint-check" ]]
        then
            no_fingerprint_check=1
        fi
    done
    if [[ $no_fingerprint_check != 0 ]]
    then
        ssh $@ "-o StrictHostKeyChecking=No -o UserKnownHostsFile=/dev/null"
    else
        ssh $@
    fi

}
# Git Commit
gcom()
{
    # Signed with gpg key
    git commit --gpg-sign --message $@
}
# Unsigned Git Commit
gcomu()
{
    # Prevent gpg signing
    git commit --no-gpg-sign --message $@

}
# Git Short Log
glog()
{
    # Visualize branches with --graph
    # pretty format uses '%' placeholder/replacements to format the log output
    # %C<color> - change the lines of colours, breaks up the text for readability
    # %h - abbreviated commit hash
    # %aN - author name
    # %G? - gpg signature system
    # G means good signature, X/Y is expired, R is revoked, E is unchecked, N is none
    # %D - ref names, basically branch and commit refs
    # %s - subject, the short commit message
    git log --graph --pretty="format:%C(auto) %h| %Cblue%aN|%Cgreen%G?|%Creset%D %s" $@
}
gtlog
{
    # Visualize branches with --graph
    # pretty format uses '%' placeholder/replacements to format the log output
    # %C<color> - change the lines of colours, breaks up the text for readability
    # %h - abbreviated commit hash
    # %aN - author name
    # %G? - gpg signature system
    # G means good signature, X/Y is expired, R is revoked, E is unchecked, N is none
    # %D - ref names, basically branch and commit refs
    # %s - subject, the short commit message
    git log --graph --pretty="format:%C(auto) %h| %ai %Cblue%aN|%Cgreen%G?|%Creset%D %s" $@
}
# Git Short Status
gstat()
{
    # rainbow command can be found
    if [ -n "$(rainbow --version)" ]
    then
        # Summarize changes
        git diff --compact-summary
        # Show a short status with the branch
        git status --short --branch
        # Also show stash, since there is enough space
        # Colourize for readability
        # reset the colour to normal after ": " seperators
        # again, reset after newline
        git stash list | rainbow \
                             --yellow-before "stash" \
                             --green-after ":" \
                             --reset-after "\n"
    else
        # Summarize Changes
        git diff --compact-summary
        # Show a short status with the branch
        git status --short --branch $@
        # Also show stash, since there is enough space
        git stash list
    fi
}
# Diminishing length aliasing to help with learning new alias
# Since, 'gstat' is far more memorable initially that 'gs', w hich will
# eventually be baked into memory
alias gsta="gstat"
alias gs="gstat"
gadd()
{
    # TODO rainbow mode this up at some point
    git add --verbose $@
}
zzp()
{
    arguments=${@}
    # Silence output since its made redundant by `dirs -v`
    pushd -q "$(z -e $arguments)"
    dirs -v
}
zd() { dirs -v }
# z stack pushd
# Move 1 place off the directory stack
zs()
{
    pushd +1
    dirs -v
}
alias zp=zs
# autoload -Uz compinit
#Prompt
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# compinit
## Completion and Correction
# source <(cod init $$ zsh)
# setopt correct_all

aur_zsh_autocomplete_dir=/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
if [[ -e $aur_zsh_autocomplete_dir ]]
then
    source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
else
    source ${HOME}/.local/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi
# The code below sets all of `zsh-autocomplete`'s settings to their default values.
zstyle ':autocomplete:*' default-context ''
# '': Start each new command line with normal autocompletion.
# history-incremental-search-backward: Start in live history search mode.

zstyle ':autocomplete:*' min-delay 0.0  # number of seconds (float)
# 0.0: Start autocompletion immediately when you stop typing.
# 0.4: Wait 0.4 seconds for more keyboard input before showing completions.

zstyle ':autocomplete:*' min-input 0  # number of characters (integer)
# 0: Show completions immediately on each new command line.
# 1: Wait for at least 1 character of input.

zstyle ':autocomplete:*' ignored-input '' # extended glob pattern
# '':     Always show completions.
# '..##': Don't show completions when the input consists of two or more dots.

# When completions don't fit on screen, show up to this many lines:
zstyle ':autocomplete:*' list-lines 16  # (integer)
# NOTE: The actual amount shown can be less.

# If any of the following are shown at the same time, list them in the order given:
zstyle ':completion:*:' group-order \
       expansions history-words options \
       aliases functions builtins reserved-words \
       executables local-directories directories suffix-aliases
# NOTE: This is NOT the order in which they are generated.

zstyle ':autocomplete:tab:*' insert-unambiguous no
# no:  (Shift-)Tab inserts top (bottom) completion.
# yes: Tab first inserts substring common to all listed completions (if any).

zstyle ':autocomplete:tab:*' widget-style complete-word
# complete-word: (Shift-)Tab inserts top (bottom) completion.
# menu-complete: Press again to cycle to next (previous) completion.
# menu-select:   Same as `menu-complete`, but updates selection in menu.
# NOTE: Can NOT be changed at runtime.

zstyle ':autocomplete:tab:*' fzf-completion no
# no:  Tab uses Zsh's completion system only.
# yes: Tab first tries Fzf's completion, then falls back to Zsh's.
# NOTE 1: Can NOT be changed at runtime.
# NOTE 2: Requires that you have installed Fzf's shell extensions.

# Add a space after these completions:
zstyle ':autocomplete:*' add-space executables aliases functions builtins reserved-words commands
# NOTE: All settings below should come AFTER sourcing zsh-autocomplete!
#
bindkey $key[Up]    up-line-or-search
# up-line-or-search:  Open history menu.
# up-line-or-history: Cycle to previous history line.
bindkey $key[Down]  down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.
bindkey $key[Control-Space] list-expand
# list-expand:      Reveal hidden completions.
# set-mark-command: Activate text selection.
# bindkey -M menuselect $key[Return] .accept-line
# .accept-line: Accept command line.
# accept-line:  Accept selection and exit menu.
# Uncomment the following lines to disable live history search:
zle -A {.,}history-incremental-search-forward
zle -A {.,}history-incremental-search-backward

#Eval $(thefuck --alias)
# Autosuggestions
# source /data/repos/zsh_autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_USE_ASYNC=1

# z.lua faster directory navigation
source $HOME/.local/share/z.lua/z.lua.plugin.zsh
zl_data_dir="$HOME/.local/share/zlua/"
if [[ -n ${XDG_DATA_HOME} ]]
then
    zl_data_dir=${XDG_DATA_HOME}/zlua
fi
export _ZL_DATA=${zl_data_dir}/database
mkdir -p ${zl_data_dir}
# thefuck Autocorrection
eval $(thefuck --alias)

## Visuals
# Syntax Highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[global-alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[path]=underline
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[command-substitution]=none
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[process-substitution]=none
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=magenta
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=cyan
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=cyan
ZSH_HIGHLIGHT_STYLES[assign]=none
ZSH_HIGHLIGHT_STYLES[redirection]=fg=yellow
ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
ZSH_HIGHLIGHT_STYLES[named-fd]=none
ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
ZSH_HIGHLIGHT_STYLES[arg0]=fg=grey

# Startup
# Navigate to a directory that is ok to pollute and dirt with programs
# dumping in the current working directory
cd ${zsh_dirty_dir}
