#!/bin/bash
#
# Update submodules and symlink the dotfiles into place.

# Directory that contains this file (dotfile root).
DOTROOT=$(dirname "$0")
DOTROOT=$(realpath "$DOTROOT")

BKROOT=~/.dotfiles-backup
mkdir -p "$BKROOT"

# Back up $1 in $BKROOT.
function backup {
    BK_SOURCE="$1"
    BK_TNAME=$(basename "$BK_SOURCE")
    BK_TARGET="$BKROOT/$BK_TNAME"
    if [ -e "$BK_TARGET" ]; then
        BK_TS=$(date '+%Y%m%d-%H%M.%s')
        BK_TBACKUP="$BK_TARGET-$BK_TS"
        mv "$BK_TARGET" "$BK_TBACKUP"
    fi
    mv "$BK_SOURCE" "$BK_TARGET"
}

# Symlink $1 -> $2 backing up $2 unless it's a symlink.
function link {
    LK_SOURCE="$DOTROOT/$1"
    LK_TARGET="$2"
    if [ -e "$LK_TARGET" ]; then
        if [ -L "$LK_TARGET" ]; then
            rm "$LK_TARGET"
        else
            backup "$LK_TARGET"
        fi
    fi
    ln -s "$LK_SOURCE" "$LK_TARGET"
}

# Initialize and update git submodules.
git submodule update --init --recursive

# Symlink stuff into place.
link alacritty.yml ~/.config/alacritty/alacritty.yml
link .bashrc ~/.bashrc
link .gitconfig ~/.gitconfig
link .tmux.conf ~/.tmux.conf
link .vim ~/.vim
link .vim ~/.config/nvim
