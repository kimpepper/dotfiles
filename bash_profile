# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you donÃ¢ÂÂt want to commit.
for file in ~/.{path,exports,aliases,functions,extra,secrets}; do
	[ -r "$file" ] && source "$file"
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall

[ -r .path ] && source .path

[ -f `brew --prefix bash-completion`/etc/bash_completion ] && source `brew --prefix bash-completion`/etc/bash_completion

# Add support for PS1 git info
[ -f `brew --prefix git`/share/git-core/contrib/completion/git-prompt.sh ] && source `brew --prefix git`/share/git-core/contrib/completion/git-prompt.sh

# initialise rbenv
eval "$(rbenv init -)"

# initialise hub
eval "$(hub alias -s)"

# Composer autocomplete
eval "$(symfony-autocomplete)"

# initialise drupal console
#source "$HOME/.console/console.rc" 2>/dev/null

# Initialise scaffold
# eval $(scaffold _completion --generate-hook)

#export NVM_DIR="/Users/kim/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
#. $HOME/Library/Python/2.7/lib/python/site-packages/powerline/bindings/bash/powerline.sh

# Include Drush bash customizations.
if [ -f "/Users/kim/.drush/drush.bashrc" ] ; then
  source /Users/kim/.drush/drush.bashrc
fi


# Include Drush completion.
if [ -f "/Users/kim/.drush/drush.complete.sh" ] ; then
  source /Users/kim/.drush/drush.complete.sh
fi


# Include Drush prompt customizations.
#if [ -f "/Users/kim/.drush/drush.prompt.sh" ] ; then
#  source /Users/kim/.drush/drush.prompt.sh
#fi

#if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
#    source ~/.gnupg/.gpg-agent-info
#    export GPG_AGENT_INFO
#else
#    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
#fi
