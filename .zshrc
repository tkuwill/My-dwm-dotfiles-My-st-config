
# Description: Look up the word in the dict://dict.org
function dict() {
	echo -n "The word you want to search: "
	read word
	curl dict://dict.org/d:${word}
}
# Description: see the cheatsheet of a command.
function cheatsheet() {
	echo -n "Input the command that you want to see its cheatsheet: "
	read com
	curl cheat.sh/${com}
}

# Description: see weather locally or select a region.
function weather() {
	echo -n "Which region's weather do you want to know ? "
	read region
	curl https://wttr.in/${region}
}

# Description: reminder.
function reminder() {    
	echo -n "Input mins: "
	read mins
	echo -n "Input reminder messages: "
	read msg
	echo "Now time is $(date "+%T")"
	echo "Set a timer for ${mins} minute(s)."
	sleep ${mins}m && notify-send -u critical -t 10000 ${msg}
    mpv ~/Music/lovesongs/+\ 1day.mp3 --start=0 --end=10 --keep-open=no --no-resume-playback --no-terminal --no-video

}

# Description: record the battery cycle into batterycycle.log, then show the batterycycle.log with bat.
function batterycycle() {
    echo -e "\e[34mWriting the battery record into batterycycle.log ..."
    date "+%Y/%m/%d(%a) %T" >> ~/batterycycle.log && upower --show-info /org/freedesktop/UPower/devices/battery_BAT0 | grep 'charge-cycles' >> ~/batterycycle.log && upower --show-info /org/freedesktop/UPower/devices/battery_BAT0 | grep 'capacity' >> ~/batterycycle.log
    echo -e "\e[34mfinished !"
    sleep 1s
    bat ~/batterycycle.log 
}

# Download music from YouTube
function musicDownload() {

    lastdir="$(pwd)"
    echo -n -e "\e[34mInput the url of the song: "
    read urls
    echo -n -e "\e[35mInput the name of the song: "
    read name
    echo -e "\e[33mcd to Downloads"
    cd ~/Downloads

    echo -e "\e[32mNow downloading music from YouTube..."
    yt-dlp -f 'ba' -x --audio-format mp3 ${urls}  -o 'name.%(ext)s'
    mv name.mp3 ${name}.mp3

    cd "$lastdir"
    echo "Download finished !!!"
}
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b %m%u%c'
 
function battime {
  acpi | grep 'Battery 0' | grep  -Eo '[0-9][0-9]:[0-9][0-9]'
 
}
setopt promptsubst

# RPROMPT='%F{225}[%?]%f|%F{15}%*%f|%F{38}$(battery_pct_prompt)%f|%F{154}$(battime)-remaining%f'
# %D{%K:%M:%S} TMOUT=1  TRAPALRM() {zle reset-prompt} zsh automatic updated time
# RPROMPT='%F{254}%D{%K:%M:%S}%f'
PROMPT='%F{14} %~ ${vcs_info_msg_0_} %f
%F{40} %#%f  '
# TMOUT=1
# TRAPALRM() {
    # zle reset-prompt
# }
# TRAPALRM() {
    # if [ "$WIDGET" != "complete-word" ]; then
        # zle reset-prompt
    # fi
# }
# PROMPT='%F{38} %f%F{231}%n@%f%F{38}%m%f  %F{14}in %~ ${vcs_info_msg_0_} %f
# %F{40} %#%f  '
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=99999
HISTORY_IGNORE="(ls|cd|pwd|exit|cmus|la|bye|fff|ranger|mpv|yt-dlp|paru|yay|pavucontrol|rofi|./batterycycle.sh|tmux|alsamixer|acpi| ..)"
# The meaning of these options can be found in man page of `zshoptions`.
# setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
# setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
# setopt EXTENDED_HISTORY  # record command start time
setopt beep nomatch
unsetopt autocd extendedglob notify
bindkey -e
bindkey "\e[3~" delete-char
# for urxvt and uxterm
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
# for tmux
bindkey "\E[1~" beginning-of-line
bindkey "\E[4~" end-of-line
# for st terminal
bindkey "^[[H" beginning-of-line
bindkey "^[[4~" end-of-line 
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/will/.zshrc'
zstyle ':completion:*' menu yes select
autoload -Uz compinit
compinit
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting.git/zsh-syntax-highlighting.zsh
export LANGUAGE=en_US:en
export LANG="zh_TW.utf8"
# End of lines added by compinstall
alias lah="ls -lah --color=auto"
alias la="ls -la --color=auto"
alias ls -la="ls -la --color=auto"
alias ls="ls --color=auto"
# alias newsboat="urxvt -e bash -c "newsboat" &"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#686868,bg=black,bold,underline"
export GTK_IM_MODULE=fcitx5
export XMODIFIERS=@im=fcitx5
export QT_IM_MODULE=fcitx5

export LESS_TERMCAP_mb=$'\E[01;4m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;76m' # begin underline
export MANPAGER="/bin/sh -c \"col -b | vim --noplugin -c 'set ft=man ts=8 nomod nolist nonu noma' -\""

