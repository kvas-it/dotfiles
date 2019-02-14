# Dotfiles of Vasily Kuznetsov.

This directory contains my configuration files for commonly used applications.
To install clone this repo and run `setup.sh` inside of it -- it will symlink
everything into your home directory (any existing files will be backed up into
`~/.dotfiles-backup`.

## What's contained here?

### alacritty.yml

Configuration for Alactritty terminal. Will be symlinked to
~/.config/alacritty/alacritty.yml

### .bashrc

Configuration for Bash. Will be symlinked to `~/.bashrc`.

### .tmux.conf

Configuration for TMux. Will be symlinked to `~/.tmux.conf`.

### .vim

Configuration for Vim or Neovim. It will be symlinked to `~/.vim` and
`~/.config/nvim`. After that `~/.vim/init.vim` will be symlinked into
`~/.vimrc`. Finally `https://github.com/gmarik/Vundle.vim` will be cloned to
`.vim/bundle/Vundle.vim` via git submodule mechanism and then all Vundle
modules will be installed alongside it using Vim/Neovim and Vundle.
