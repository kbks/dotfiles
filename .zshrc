~ # cat ~/.zshrc                                                                                                                                                                                                                                                  root at x5650
#====================================================================
# Filename     : $HOME/.zshrc
# Purpose      : setup file for the shell 'zsh'
# http://zshwiki.org
# http://zsh.sunsite.dk/Guide/zshguide.html
# http://kubikus.org.ua
# Thnx 2 dh3rm3 http://dh3rm3.aikotoba.org/
#====================================================================

# ssh management
[[ -e "/etc/profile.env" ]] && source /etc/profile.env

export BROWSER="opera"
autoload -U compinit; compinit
zstyle ':completion::complete:*' use-cache 1
unsetopt beep
unsetopt hist_beep
unsetopt list_beep
unsetopt ignore_eof
unsetopt rm_star_silent
zmodload -i zsh/complist
eval `/usr/bin/dircolors -b ~/.dircolors`
alias ls='ls --color=auto'
unset SCREENDIR
limit coredumpsize 0
HISTFILE=$HOME/.zshist
SAVEHIST=1000
HISTSIZE=1600
export HISTIGNORE="ls*:fg"
TMPPREFIX=$HOME/tmp
# Completion function path
fpath=(~/.zsh/zfunc $fpath)

#====================================================================
# Environement Variables
#====================================================================

#CFLAGS="-march=core2 -O2 -pipe -fomit-frame-pointer"
#CXXFLAGS="${CFLAGS}"
#CHOST="x86_64-pc-linux-gnu"

#MAKEOPTS="-j49"


###PGI
PGI=/opt/pgi
PATH=/opt/pgi/linux86-64/11.7/bin:$PATH
export PGI
export PATH


export COLORTERM=yes
export EDITOR=vim
#export PATH="$HOME/soft/bin:/bin:/usr/bin:/usr/sbin:/usr/local/bin:/bin:/usr/bin:/usr/X11/bin:/usr/local/bin:/opt/bin:/usr/sbin:/opt/nagios/bin:/opt/nagios/sbin" #/usr/non-sles/nagios/bin:/usr/non-sles/bin:/usr/non-sles/nagios/sbin:/usr/non-sles/sbin"
#export MANPATH="$MANPATH:/home/cub/soft/share/man/"
cdpath=(~ ..) ## on cd command offer dirs in home and one dir up.

if [[ "$USER" == root ]]; then
	export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:${ROOTPATH}"
else
	export PATH="/bin:/usr/bin:/usr/local/bin:${PATH}"
fi
unset ROOTPATH

#export UNAME_S=$(uname -s 2>&1 || echo "Linux" )


## if we are in X then disable TMOUT
case $TERM in
	*xterm*|rxvt|(dt|k|E)term)
	unset TMOUT
	;;
esac

## This set of functions implements a sort of magic history searching.
## After predict-on, typing characters causes the editor to look backward
## in the history for the first line beginning with what you have typed so
## far.  After predict-off, editing returns to normal for the line found.
## In fact, you often don't even need to use predict-off, because if the
## line doesn't match something in the history, adding a key performs
## standard completion - though editing in the middle is liable to delete
## the rest of the line.
autoload -U predict-on
zle -N predict-on
zle -N predict-off
bindkey "^X^Z" predict-on ## C-x C-z
bindkey "^Z" predict-off ## C-z
bindkey ' ' magic-space  # also do history expanse on space
#====================================================================
# Directory Shortcurts
#====================================================================
moviez="/mnt/ftp/pub/video"
downloadz="/mnt/ftp/incoming"
wind="/mnt/c"
mp3s="/mnt/ftp/pub/music"

#====================================================================
# Color Settings & Prompt
#====================================================================
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;32'

if [ -f /usr/bin/grc ]; then
  alias ping="grc --colour=auto ping"
  alias traceroute="grc --colour=auto traceroute"
  alias make="grc --colour=auto make"
  alias diff="grc --colour=auto diff"
  alias cvs="grc --colour=auto cvs"
  alias netstat="grc --colour=auto netstat"
  alias ping="grc --colour=auto ping"
  alias traceroute="grc --colour=auto traceroute"
  alias make="grc --colour=auto make"
  alias diff="grc --colour=auto diff"
  alias cvs="grc --colour=auto cvs"
  alias netstat="grc --colour=auto netstat"
  alias grca="grc --colour=auto"

  for c in ping traceroute make diff last cvs netstat ifconfig uptime vmstat iostat df mount uname ps route lsmod whereis yum; do
    alias ${c}="grca ${c}"
  done

  alias ll="grca ls --color=force -l"
  alias ccal="grca cal"
fi



precmd () { vcs_info 'prompt' }

setprompt () {
# See these pages for info on special characters:
#   http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html
#   http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#SEC273

autoload -Uz vcs_info  # enable the use of VCS information
setopt prompt_subst    # perform expansions and substitutions within prompts

         local VCS_PATH="%F{green}%r/%S%f"            # display only repo path when inside a reUUUUlocal REG_PATH="%F{yellow}%~%f"              # display full path when outside a repo
         local REG_PATH="%F{yellow}%~%f"              # display full path when outside a repo
         local VCS_USER="%%(!.%F{red}.%F{blue})%n%f"  # display username in red when root inside a repo
         local REG_USER="%(!.%F{red}.%F{blue})%n%f"   # display username in red when root outside a repo

         local VCS_HOST="%F{cyan}%%m%f"               # display hostname when inside a repo
         local REG_HOST="%F{cyan}%m%f"                # display hostname when outside a repo

         local VCS_INFO="%s %F{green}%c%u%b%f"        # current VCS name and branch
         zstyle ':vcs_info:*:prompt:*' enable cvs git hg svn    # only enable checking for these VCSs
         zstyle ':vcs_info:*:prompt:*' check-for-changes true   # can be slow, but displays working dir & index changes
         zstyle ':vcs_info:*:prompt:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
         zstyle ':vcs_info:*:prompt:*' stagedstr '%F{yellow}+'  # display this when there are staged changes

         #sets vcs_info_msg_{0,1}_ when inside a repo, when inside a repo and performing an action, and when not inside a repo
         zstyle ':vcs_info:*:prompt:*' formats       "${VCS_PATH}" "${VCS_USER} at ${VCS_HOST} on ${VCS_INFO}"
         zstyle ':vcs_info:*:prompt:*' actionformats "${VCS_PATH}" "${VCS_USER} at ${VCS_HOST} on ${VCS_INFO} (%a)"
         zstyle ':vcs_info:*:prompt:*' nvcsformats   "${REG_PATH}" "${REG_USER} at ${REG_HOST}"

         local FMT_PATH='${vcs_info_msg_0_}'    # necessary to allow expansion elsewhere
         local ERR_EXIT="%(?..%F{red}[%?] )%f"  # conditionally display any non-zero exit status

         # the actual prompt definitions
         PROMPT="${FMT_PATH} ${ERR_EXIT}%F{magenta}%# %f"  # left prompt
         RPROMPT='${vcs_info_msg_1_}'                      # right prompt
         PS2="%_ %F{8}>%F{13}>%F{magenta}> %f"             # continuation prompt
    }
setprompt


#====================================================================
# Aliases
#====================================================================
alias nocomm="sed -e 's/#.*//;/^\s*$/d' "$@""
alias xclock="xclock -geometry 80x80"
alias lastsync="qlop -s | tail -n 1"
alias xload="xload -geometry 128x56+0+968 -label load"
alias ncmpc="ncmpc -c -f .ncpmc/config"
#alias rar="/opt/rar/bin/rar"
#alias rarnopass="/opt/rar/bin/rar a -m5 -ep1 -r -rr1%"
#alias rarpass="/opt/rar/bin/rar a -m5 -ep1 -r -rr1% -hp"
alias system_log="mtail -f /var/log/syslog /var/log/messages /var/log/kern.log"
alias webcam="camE -f -c ~/camErc"
alias webcamstop="touch ~/pictures/block"
alias webcamrestart="rm ~/pictures/block"
#alias blankcd="cdrecord -v -speed=8 -dev=0,3,0 -blank=all"
#alias blanktoc="cdrecord -v -speed=8 -dev=0,3,0 -blank=fast"
#alias burncue="cdrdao write --device 0,3,0 --driver generic-mmc"
#alias ls="ls --color=always"
alias bt="btdownloadcurses.py --minport 31000 --maxport 31099 --max_connections 30 --max_uploads 5 --display_interval 1 --min_peers 10 --max_initiate 10 --spew 1"
alias bt_full="btdownloadcurses.py --minport 31000 --maxport 31099 --display_interval 1 --spew 1"
alias bt_full_noup="btdownloadcurses.py --minport 31000 --maxport 31100 --display_interval 1 --spew 1 --max_upload_rate 1"
alias divergencefm="mplayern -cache 64  http://antesis.freecontrib.org:8000/divergence.ogg"
alias franceculture="mplayern -cache 64  http://ogg.tv-radio.fr:1441/encoderfculture.ogg"
alias franceinfo="mplayer -cache 64  http://ogg.tv-radio.fr:1441/encoderfinfo.ogg"
alias franceinter="mplayer -cache 64  mms://vip9.yacast.fr/encoderfranceinter/franceinter.asx"
alias lynx="lynx -use_mouse -term=${TERM}"
alias dum='du -h --max-depth=1'
alias lock='xscreensaver-command -lock'
alias myports="netstat -alpe --ip"
alias cd2iso="dd if=/dev/cdrom of=cd.iso"
alias att="screen -r"
alias d="ls -alh --color"
alias ll="ls --color -ahl |more"
alias c='clear'
alias df='pydf -h'
alias mad='madplay --tty-control -v -r *.mp3'
alias ogg='ogg123 -v -d esd *.ogg'
alias flac_="flac123 -d esd *.flac"
alias cd..='cd ..'
alias merge='ACCEPT_KEYWORDS="~x86" emerge'
alias grep="grep --color=auto"
alias sfv='cksfv -f *.sfv -i'
alias csfv='cksfv * > files.sfv'
alias slurm="slurm -i eth0 -d 1 -s -L"
alias dpms='sleep 5 ; clear ; xset dpms force off'
# Aliases Suffix
#alias -s pdf=gpdf
#alias -s mp3=mad
#alias -s ogg=ogg
#alias -s html=bluefish
#alias -s php=bluefish
alias nautilus="nautilus --no-desktop --browser"
# zed is a tiny command-line editor in pure ZSH; no other shell could do this.
# zed itself is simple as anything, but it's killer feature for me is that it
# can edit functions on the go with zed -f <funcname>. Some people argue ZSH's
# bloatedness is a liability - I disagree. zed, zmv, and zftp are LIFESAVERS.
# ^X^W to save, ^C to abort.
autoload -U zed
autoload -U zmv
autoload -U zcalc
#====================================================================
#====================================================================
# zsh functions
#====================================================================
#====================================================================
#====================================================================
# Screen Completion
#====================================================================

#====================================================================
# Quick Rename
#====================================================================
name() {
    newname=$1
    vared -c -p 'rename to: ' newname
    command mv $1 $newname
}
#====================================================================
#`Command` | grep
#
# Usage:
# % lsgrep		#ls | grep
# % psgrep apache	#ps aux | grep
#
#
#====================================================================
function lsgrep () {
	ls -1 | grep $* | xargs ls -la
}

function psgrep () {
  case $SYSTEM {
  sun)
    echo "USER       PID %CPU %MEM   SZ  RSS TT STAT START  TIME COMMAND"
    ps auxw | grep $* ;;
  sol)
    echo "USER       PID %CPU %MEM   SZ  RSS TT       S    START  TIME COMMAND"
    \ps -auwx | grep $* ;;
  sgi)
    echo "     UID   PID  PPID  C    STIME TTY     TIME CMD"
    ps -ef | grep $* ;;
  gnu)
    echo "USER       PID %CPU %MEM  SIZE   RSS TTY STAT START   TIME COMMAND"
    ps auxw | grep -v grep | grep $* ;;
  bsd)
    echo "USER       PID %CPU %MEM   VSZ  RSS  TT  STAT STARTED       TIME COMMAND"
    ps -auxww | grep -v grep | grep $* ;;
  *)
    ps auxw | grep $* ;;
  }
}

#====================================================================
# pskill - kill processes by name
#====================================================================
pskill () {
  local pid
  pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
  echo -n "killing $1 (process $pid)...\n"
  kill -9 $=pid
}

#====================================================================
# Zsh's Book Mark Function
#
# Usage:
# % bmadd	#add directory to bookmark list
# % bmls	#show list of bookmark list
# % bmvi	#edit bookmark list
# % bm $NUMBER	#change directory to $NUMBER bookmark
#====================================================================
BMRC=~/.bmrc
touch $BMRC
bmls() { cat $BMRC | sort -n}
bmvi() { vi $BMRC }
bmadd() {
  local bmdir=`pwd`
  local newid=$1
  local bmname=''
  for bmname in `bm_path_list`
  do
    if [ "$bmname" = "$bmdir" ]; then
      echo "$bmdir is already in bm list"
      return
    fi
  done
  if [ -z $newid ]; then
    maxid=`cat $BMRC | cut -f 1 | sort -n -r | head -n 1`
    if [ "$maxid" -ge 1 ]; then
      newid=`expr 0$maxid + 1`
    else
      newid=1
    fi
  fi
  echo "$newid\t$bmdir" >> $BMRC
}
bm() {
  local num=$1
  local bmdir=`bm_get $num`
  if [ -z "$bmdir" ]; then
    bmls
    [ -z "$num" ] || echo "$num is not in bm list"
    return
  fi
  cd "$bmdir"
}

bm_get() {
  local bmdir=`cat $BMRC | egrep "^${1}[[:space:]]" | cut -f 2`
  echo $bmdir
}

bm_path_list() {
  cut -f 2 < $BMRC
}

#====================================================================
#Search File
#No as good as slocate !
# http://aquahill.net/zsh/functions
#====================================================================
function search_file() {
	regex=$1
	case $# in
		1) dir='.' ;;
		2) dir=$2 ;;
		*) echo "usage: $0 <pattern> <dir>" >& 2
			return ;;
	esac

	find ${dir} -type f | perl -lne "print if /${regex}/" 2>/dev/null
}

#====================================================================

#====================================================================
# extract
#====================================================================
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2)  tar -jxvf $1        ;;
      *.tar.gz)   tar -zxvf $1        ;;
      *.bz2)      bunzip2 $1          ;;
      *.rar)      unrar x $1    ;;
      *.gz)       gunzip $1           ;;
      *.tar)      tar -xvf $1         ;;
      *.tbz2)     tar -jxvf $1        ;;
      *.tgz)      tar -zxvf $1        ;;
      *.zip)      unzip $1            ;;
      *.Z)        uncompress $1       ;;
      *)          echo "'$1' cannot be extracted via smartextract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Key Bindings
# You can use:
# % autoload -U zkbd
# % zkbd
# to discover your Ke"ys.
# Pretty menu!
zstyle ':completion:*' menu select=1

# Tetris
#autoload -U tetris
#zle -N tetris
#bindkey Keys tetris

# Completion options
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:::::' completer _complete _approximate
zstyle -e ':completion:*:approximate:::' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/4 )) numeric )'

# Completion for yafc bookmarks (only the ones with an alias !)
function yafc_bookmarks { reply=(`cat ~/.yafc/bookmarks | grep alias | cut -d'  ' -f4 | tr -d \'`); }
# This will complete only the yafc command
compctl -K yafc_bookmarks yafc

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

#zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#lost+found'

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# Include non-hidden directories in globbed file completions
# for certain commands
zstyle ':completion::complete:*' '\'

# Use menuselection for pid completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always

#  tag-order 'globbed-files directories' all-files
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

# Separate matches into groups
zstyle ':completion:*:matches' group 'yes'

# With commands like rm, it's annoying if you keep getting offered the same
# file multiple times. This fixes it. Also good for cp, et cetera..
zstyle ':completion:*:rm:*' ignore-line yes
zstyle ':completion:*:cp:*' ignore-line yes

# Describe each match group.
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'

 # Describe options in full
 zstyle ':completion:*:options' description 'yes'
 zstyle ':completion:*:options' auto-description '%d'

 # Simulate spider's old abbrev-expand 3.0.5 patch
 zstyle ':completion:*:history-words' stop verbose
 zstyle ':completion:*:history-words' remove-all-dups yes
 zstyle ':completion:*:history-words' list false



###################################
# TERMINAL SETTINGS AND COMPAT
###################################

#case $TERM in (xterm*)
#  bindkey '\e[H' beginning-of-line
#  bindkey '\e[F' end-of-line ;;
#esac

#case $TERM in
#	*xterm*|rxvt|(u|dt|k|E)term|screen)
#		bindkey '\e[7~' beginning-of-line
#		bindkey '\e[3~' delete-char
#		bindkey '\e[8~' end-of-line
#		bindkey '\177' backward-delete-char
#		bindkey '\e[2~' overwrite-mode
#		bindkey "\e[5~" history-search-backward
#		bindkey "\e[6~" history-search-forward
#	;;
#esac

#function title {
#case $TERM in
#	    *screen*)
	      	# Use these two for GNU Screen:
#    	  	print -nR $'\033k'$1$'\033'\\
#      	  	print -nR $'\033]0;'$2$'\a'
#;;
#		*xterm*|rxvt|(dt|k|E)term|*screen*)
#			# Use this one instead for XTerms:
#			print -nR $'\033]0;'$*$'\a';
#;;
#esac
#}

# Completion

compdef _pkglist ecd
compdef _useflaglist explainuseflag
compdef _category list_cat
compdef -a _portage emerge

compdef _nothing etc-update dispatch-conf fixpackages

# From oberyno
_category() {
  categories=(/usr/portage/metadata/cache/*-*)
  category=${(M)${${categories##*/}}}
  _tags -s category && { compadd "$@" ${(kv)=category} }
}

_pkglist() {
  local portdir portage_pkglist
  portdir=$(eportdir)
  portage_pkglist=( ${=portdir}/*-*/* )
  portage_pkglist=(${portage_pkglist##*/})
  _tags -s portage_pkglist && { compadd "$@" ${(kv)=portage_pkglist} }
}

_useflaglist() {
  local flag localf
  flag=${${${(M)${(f)"$(</usr/portage/profiles/use.desc)"}##* - *}/ - *}}
  localf=${${${(M)${(f)"$(</usr/portage/profiles/use.local.desc)"}##* - *}/ - *}#*:}
  _tags flag && { compadd "$@" ${(kv)=flag} }
  _tags localf && { compadd "$@" ${(kv)=localf} }
}

# History things
#HISTFILE=$HOME/.zshist
#SAVEHIST=1000
#HISTSIZE=1600
#TMPPREFIX=$HOME/tmp

#key bindings

case $TERM in
    linux)
    bindkey "^[[2~" yank
    bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history
    bindkey "^[[6~" down-line-or-history
    bindkey "^[[1~" beginning-of-line
    bindkey "^[[4~" end-of-line
    bindkey "^[e" expand-cmd-path
    bindkey "^[[A" up-line-or-search
    bindkey "^[[B" down-line-or-search
    bindkey " " magic-space
    ;;
    xterm*|*rxvt*|(u|dt|k|E)term|screen)
    bindkey "^[[2~" yank
    bindkey "^[[3~" delete-char
    bindkey "^[[5~" up-line-or-history
    bindkey "^[[6~" down-line-or-history
    bindkey "^[[7~" beginning-of-line
    bindkey "^[[8~" end-of-line
    bindkey "^[e" expand-cmd-path
    bindkey "^[[A" up-line-or-search
    bindkey "^[[B" down-line-or-search
    bindkey " " magic-space
    ;;
esac

bindkey -s "^e" 'eject\n'


# zsh Options

setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
     NO_auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
     NO_beep                 \
        brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     correct                 \
     NO_correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
        hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
	inc_append_history   \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
        nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
     NO_sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle
