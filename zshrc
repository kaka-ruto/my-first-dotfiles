# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*~*.zwc(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/(pre|post)/*|*.zwc)
          :
          ;;
        *)
          . $config
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*~*.zwc(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases
export GOPATH=$HOME/go
export PATH=$PATH:$(go env GOPATH)/bin

# Ruby and rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# oh-my-zsh
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=243'
source $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZSH_CUSTOM/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Plugins
plugins=(
  common-aliases
  docker
  dotenv
  git
  golang
  heroku
  rails
  ruby
  zsh-autosuggestions
)

source ~/.oh-my-zsh/plugins/git/git.plugin.zsh

# Themes
ZSH_THEME=agnoster

# Enable vi mode on the command line
bindkey -v
