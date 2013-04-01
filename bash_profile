# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{bash_prompt,exports,aliases,functions,extra}; do
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

# If a boxen machine, source boxen env
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

[ -r .path ] && source .path

[ -f `brew --prefix bash-completion`/etc/bash_completion ] && source `brew --prefix bash-completion`/etc/bash_completion

# Add support for PS1 git info
[ -f `brew --prefix git`/share/git-core/contrib/completion/git-prompt.sh ] && source `brew --prefix git`/share/git-core/contrib/completion/git-prompt.sh

# initialise rbenv
eval "$(rbenv init -)"

# Invoke java with the $DYLD_LIBRARY_PATH set with the homebrew lib dir.
# This allows java to load native libraries installed via homebrew.
# export DYLD_FALLBACK_LIBRARY_PATH="$BOXEN_HOME/homebrew/lib:$DYLD_FALLBACK_LIBRARY_PATH"

if [ -x /usr/libexec/java_home ]; then
  export JAVA_HOME=`/usr/libexec/java_home`
fi
