if [ -z "$TMUX" -a -z "$STY" ]; then
if type tmuxx >/dev/null 2>&1; then
tmuxx
elif type tmux >/dev/null 2>&1; then
if tmux has-session && tmux list-sessions | /usr/bin/grep -qE '.*]$'; then
tmux attach && echo "tmux attached session "
else
tmux new-session && echo "tmux created new session"
fi
elif type screen >/dev/null 2>&1; then
screen -rx || screen -D -RR
fi
fi

# Prompt
autoload -U colors
colors

setopt prompt_subst

if [ "$SSH_CLIENT" ]; then
	PROMPT="%B%{$fg[black]%}%T %{$fg[green]%}%m %~ %{%(?.$fg[cyan].$fg[red])%}%(?.(▰╹◡╹%).ヾ(｡>﹏<｡%)ﾉﾞ)%{$reset_color%}%b "
else
	PROMPT="%B%{$fg[black]%}%T %{$fg[green]%}%~ %{%(?.$fg[cyan].$fg[red])%}%(?.(▰╹◡╹%).ヾ(｡>﹏<｡%)ﾉﾞ)%{$reset_color%}%b "
fi

#---------------------------------------------------------------------------
# History
#---------------------------------------------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# 重複したコマンドラインはヒストリに追加しない
setopt hist_ignore_dups
# 履歴の共有
setopt share_history
# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store
# 余分なスペースを削除してヒストリに記録する
setopt hist_reduce_blanks

functionsd="$ZSH_CONFIG/functions.d"
if [[ -d "$functionsd" ]] {
    fpath=( $functionsd $fpath )
        autoload -U $functionsd/*(:t)
	}

	# load completions system
	zmodload -i zsh/complist

	# auto rehash commands
	# http://www.zsh.org/mla/users/2011/msg00531.html
	zstyle ':completion:*' rehash true

	# for all completions: menuselection
	zstyle ':completion:*' menu select=1

	# for all completions: grouping the output
	zstyle ':completion:*' group-name ''

	# for all completions: color
	zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

	# for all completions: selected item
	#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;47

	# completion of .. directories
	zstyle ':completion:*' special-dirs true

	# fault tolerance
	zstyle ':completion:*' completer _complete _correct _approximate
	# (1 error on 3 characters)
	zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

	# case insensitivity
	#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
	zstyle ":completion:*" matcher-list 'm:{A-Zöäüa-zÖÄÜ}={a-zÖÄÜA-Zöäü}'

	# for all completions: grouping / headline / ...
	zstyle ':completion:*:messages' format $'\e[01;35m -- %d -- \e[00;00m'
	zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found -- \e[00;00m'
	zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d -- \e[00;00m'
	zstyle ':completion:*:corrections' format $'\e[01;33m -- %d -- \e[00;00m'

	# statusline for many hits
	zstyle ':completion:*:default' select-prompt $'\e[01;35m -- Match %M    %P -- \e[00;00m'

	# for all completions: show comments when present
	zstyle ':completion:*' verbose yes

	# in menu selection strg+space to go to subdirectories
	bindkey -M menuselect '^@' accept-and-infer-next-history

	# case-insensitive -> partial-word (cs) -> substring completion:
	zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'  

	# caching of completion stuff
	zstyle ':completion:*' use-cache on
	zstyle ':completion:*' cache-path "$ZSH_CACHE"


	# ~dirs: reorder output sorting: named dirs over userdirs
	zstyle ':completion::*:-tilde-:*:*' group-order named-directories users

	# ssh: reorder output sorting: user over hosts
	zstyle ':completion::*:ssh:*:*' tag-order "users hosts"

	# kill: advanced kill completion
	zstyle ':completion::*:kill:*:*' command 'ps xf -U $USER -o pid,%cpu,cmd'
	zstyle ':completion::*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'

	# rm: advanced completion (e.g. bak files first)
	zstyle ':completion::*:rm:*:*' file-patterns '*.o:object-files:object\ file *(~|.(old|bak|BAK)):backup-files:backup\ files *~*(~|.(o|old|bak|BAK)):all-files:all\ files'

	# vi: advanced completion (e.g. tex and rc files first)
	zstyle ':completion::*:vi:*:*' file-patterns 'Makefile|*(rc|log)|*.(php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3):vi-files:vim\ likes\ these\ files *~(Makefile|*(rc|log)|*.(log|rc|php|tex|bib|sql|zsh|ini|sh|vim|rb|sh|js|tpl|csv|rdf|txt|phtml|tex|py|n3)):all-files:other\ files'

	zstyle :compinstall filename '~/.zshrc'

	autoload -Uz compinit && compinit
