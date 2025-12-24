
Install with Curl from https://github.com/ohmyzsh/ohmyzsh: 

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

install custom plugins:

```
export ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
git clone https://github.com/marlonrichert/zsh-autocomplete.git \
  $ZSH_CUSTOM/plugins/zsh-autocomplete

```

Use this zshrc lines:

```

export ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
ZSH_THEME="robbyrussell"

...

plugins=(
  git
  aws
  kubectl
  terraform
  zsh-autocomplete
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

if command -v aws_completer >/dev/null 2>&1; then
  # enable bash-style completion layer once
  autoload -U +X bashcompinit
  bashcompinit

  # register aws completion
  complete -o nospace -C aws_completer aws
fi

...

alias di="aws sts get-caller-identity --no-cli-pager"
alias k="kubectl"

source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

```


Update Ghostly config:

```
# ghostty +list-themes
theme = Catppuccin Mocha

```
