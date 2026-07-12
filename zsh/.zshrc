export ZSH="$HOME/.oh-my-zsh"

# plugins
# plugins standards : $ZSH/plugins/
# plugins custom : $ZSH_CUSTOM/plugins/
plugins=(
	git
	nvm
	zsh-autosuggestions
	zsh-syntax-highlighting # doit être placé en dernier
)

# nvm
zstyle ':omz:plugins:nvm' lazy yes
zstyle ':omz:plugins:nvm' autoload yes

# zsh-completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

# oh my zsh
source "$ZSH/oh-my-zsh.sh"

# thème starship (doit être placé en dernier)
eval "$(starship init zsh)"
