# Battery % from oh-my-zsh

if [[ "$OSTYPE" = darwin* ]]; then
  function battery_is_charging() {
    ioreg -rc AppleSmartBattery | command grep -q '^.*"ExternalConnected"\ =\ Yes'
  }
  function battery_pct() {
    pmset -g batt | grep -Eo "\d+%" | cut -d% -f1
  }
  function battery_pct_remaining() {
    if battery_is_charging; then
      echo "External Power"
    else
      battery_pct
    fi
  }
  function battery_time_remaining() {
    local smart_battery_status="$(ioreg -rc "AppleSmartBattery")"
    if [[ $(echo $smart_battery_status | command grep -c '^.*"ExternalConnected"\ =\ No') -eq 1 ]]; then
      timeremaining=$(echo $smart_battery_status | command grep '^.*"AvgTimeToEmpty"\ =\ ' | sed -e 's/^.*"AvgTimeToEmpty"\ =\ //')
      if [ $timeremaining -gt 720 ]; then
        echo "::"
      else
        echo "~$((timeremaining / 60)):$((timeremaining % 60))"
      fi
    else
      echo "∞"
    fi
  }
  function battery_pct_prompt () {
    local battery_pct color
    if ioreg -rc AppleSmartBattery | command grep -q '^.*"ExternalConnected"\ =\ No'; then
      battery_pct=$(battery_pct_remaining)
      if [[ $battery_pct -gt 50 ]]; then
        color='green'
      elif [[ $battery_pct -gt 20 ]]; then
        color='yellow'
      else
        color='red'
      fi
      echo "%{$fg[$color]%}[${battery_pct}%%]%{$reset_color%}"
    else
      echo "∞"
    fi
  }

elif [[ "$OSTYPE" = freebsd* ]]; then
  function battery_is_charging() {
    [[ $(sysctl -n hw.acpi.battery.state) -eq 2 ]]
  }
  function battery_pct() {
    if (( $+commands[sysctl] )); then
      sysctl -n hw.acpi.battery.life
    fi
  }
  function battery_pct_remaining() {
    if ! battery_is_charging; then
      battery_pct
    else
      echo "External Power"
    fi
  }
  function battery_time_remaining() {
    local remaining_time
    remaining_time=$(sysctl -n hw.acpi.battery.time)
    if [[ $remaining_time -ge 0 ]]; then
      ((hour = $remaining_time / 60 ))
      ((minute = $remaining_time % 60 ))
      printf %02d:%02d $hour $minute
    fi
  }
  function battery_pct_prompt() {
    local battery_pct color
    battery_pct=$(battery_pct_remaining)
    if battery_is_charging; then
      echo "∞"
    else
      if [[ $battery_pct -gt 50 ]]; then
        color='green'
      elif [[ $battery_pct -gt 20 ]]; then
        color='yellow'
      else
        color='red'
      fi
      echo "%{$fg[$color]%}${battery_pct}%%%{$reset_color%}"
    fi
  }
elif [[ "$OSTYPE" = linux-android ]] && (( ${+commands[termux-battery-status]} )); then
  function battery_is_charging() {
    termux-battery-status 2>/dev/null | command awk '/status/ { exit ($0 ~ /DISCHARGING/) }'
  }
  function battery_pct() {
    # Sample output:
    # {
    #   "health": "GOOD",
    #   "percentage": 93,
    #   "plugged": "UNPLUGGED",
    #   "status": "DISCHARGING",
    #   "temperature": 29.0,
    #   "current": 361816
    # }
    termux-battery-status 2>/dev/null | command awk '/percentage/ { gsub(/[,]/,""); print $2}'
  }
  function battery_pct_remaining() {
    if ! battery_is_charging; then
      battery_pct
    else
      echo "External Power"
    fi
  }
  function battery_time_remaining() { } # Not available on android
  function battery_pct_prompt() {
    local battery_pct color
    battery_pct=$(battery_pct_remaining)
    if battery_is_charging; then
      echo "∞"
    else
      if [[ $battery_pct -gt 50 ]]; then
        color='green'
      elif [[ $battery_pct -gt 20 ]]; then
        color='yellow'
      else
        color='red'
      fi
      echo "%{$fg[$color]%}${battery_pct}%%%{$reset_color%}"
    fi
  }
elif [[ "$OSTYPE" = linux*  ]]; then
  function battery_is_charging() {
    if (( $+commands[acpitool] )); then
      ! acpitool 2>/dev/null | command grep -qE '^\s+Battery.*Discharging'
    elif (( $+commands[acpi] )); then
      ! acpi 2>/dev/null | command grep -v "rate information unavailable" | command grep -q '^Battery.*Discharging'
    fi
  }
  function battery_pct() {
    if (( $+commands[acpitool] )); then
      # Sample output:
      #   Battery #1     : Unknown, 99.55%
      #   Battery #2     : Discharging, 49.58%, 01:12:05
      #   All batteries  : 62.60%, 02:03:03
      local -i pct=$(acpitool 2>/dev/null | command awk -F, '
        /^\s+All batteries/ {
          gsub(/[^0-9.]/, "", $1)
          pct=$1
          exit
        }
        !pct && /^\s+Battery/ {
          gsub(/[^0-9.]/, "", $2)
          pct=$2
        }
        END { print pct }
        ')
      echo $pct
    elif (( $+commands[acpi] )); then
      # Sample output:
      # Battery 0: Discharging, 0%, rate information unavailable
      # Battery 1: Full, 100%
      acpi 2>/dev/null | command awk -F, '
        /rate information unavailable/ { next }
        /^Battery.*: /{ gsub(/[^0-9]/, "", $2); print $2; exit }
      '
    fi
  }
  function battery_pct_remaining() {
    if ! battery_is_charging; then
      battery_pct
    else
      echo "External Power"
    fi
  }
  function battery_time_remaining() {
    if ! battery_is_charging; then
      acpi 2>/dev/null | command grep -v "rate information unavailable" | cut -f3 -d ','
    fi
  }
  function battery_pct_prompt() {
    local battery_pct color
    battery_pct=$(battery_pct_remaining)
    if battery_is_charging; then
      echo "ﮣ"
    else
      if [[ $battery_pct -gt 50 ]]; then
        color='green'
      elif [[ $battery_pct -gt 20 ]]; then
        color='yellow'
      else
        color='red'
      fi
      echo "%{$fg[$color]%}${battery_pct}%%%{$reset_color%}"
    fi
  }
else
  # Empty functions so we don't cause errors in prompts
  function battery_is_charging { false }
  function battery_pct \
    battery_pct_remaining \
    battery_time_remaining \
    battery_pct_prompt { }
fi

function battery_level_gauge() {
  local gauge_slots=${BATTERY_GAUGE_SLOTS:-10}
  local green_threshold=${BATTERY_GREEN_THRESHOLD:-$(( gauge_slots * 0.6 ))}
  local yellow_threshold=${BATTERY_YELLOW_THRESHOLD:-$(( gauge_slots * 0.4 ))}
  local color_green=${BATTERY_COLOR_GREEN:-%F{green}}
  local color_yellow=${BATTERY_COLOR_YELLOW:-%F{yellow}}
  local color_red=${BATTERY_COLOR_RED:-%F{red}}
  local color_reset=${BATTERY_COLOR_RESET:-%{%f%k%b%}}
  local battery_prefix=${BATTERY_GAUGE_PREFIX:-'['}
  local battery_suffix=${BATTERY_GAUGE_SUFFIX:-']'}
  local filled_symbol=${BATTERY_GAUGE_FILLED_SYMBOL:-'▶'}
  local empty_symbol=${BATTERY_GAUGE_EMPTY_SYMBOL:-'▷'}
  local charging_color=${BATTERY_CHARGING_COLOR:-$color_yellow}
  local charging_symbol=${BATTERY_CHARGING_SYMBOL:-'⚡'}

  local -i battery_remaining_percentage=$(battery_pct)
  local filled empty gauge_color

  if [[ $battery_remaining_percentage =~ [0-9]+ ]]; then
    filled=$(( ($battery_remaining_percentage * $gauge_slots) / 100 ))
    empty=$(( $gauge_slots - $filled ))

    if [[ $filled -gt $green_threshold ]]; then
      gauge_color=$color_green
    elif [[ $filled -gt $yellow_threshold ]]; then
      gauge_color=$color_yellow
    else
      gauge_color=$color_red
    fi
  else
    filled=$gauge_slots
    empty=0
    filled_symbol=${BATTERY_UNKNOWN_SYMBOL:-'.'}
  fi

  local charging=' '
  battery_is_charging && charging=$charging_symbol

  # Charging status and prefix
  print -n ${charging_color}${charging}${color_reset}${battery_prefix}${gauge_color}
  # Filled slots
  [[ $filled -gt 0 ]] && printf ${filled_symbol//\%/\%\%}'%.0s' {1..$filled}
  # Empty slots
  [[ $filled -lt $gauge_slots ]] && printf ${empty_symbol//\%/\%\%}'%.0s' {1..$empty}
  # Suffix
  print -n ${color_reset}${battery_suffix}${color_reset}
}

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b %m%u%c'
 
# Set up the prompt (with git branch name)



#function mem {
#	free -h | grep 'Mem' | cut -c 28-32
#}

function battime {
  acpi | grep 'Battery 0' | grep  -Eo '[0-9][0-9]:[0-9][0-9]'
 
}
#function battery1 {
#	 acpi | grep 'Battery 0' | cut -c 25-27  
#}
#function battery {
#    if [[ $battery1 -gt 99 ]]; then
#	    echo "FULL"
#    else 
#   upower --show-info /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | cut  -c 26-27
	 
#    fi
#}
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
HISTORY_IGNORE="(ls|cd|pwd|exit|cmus|la|bye|fff|ranger|mpv|yt-dlp|paru|yay|pavucontrol|rofi|./batterycycle.sh|tmux| ..)"
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

# fff filemanager's config
export FFF_HIDDEN=1
export FFF_OPENER="xdg-open"
export FFF_COL5=0
export FFF_COL2=7
export FFF_LS_COLORS=1
# auto startx (for dwm)
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
