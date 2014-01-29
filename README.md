dotfiles
========

My dotfiles

Installation
---

Assuming you cloned the git repo under $HOME/src/

cd $HOME
for dir in $(ls $HOME/src/dotfiles/); do ln -sv $HOME/src/dotfiles/$dir .$dir; done
