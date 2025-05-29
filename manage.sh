#!/usr/bin/env bash

### Sources `.config/zsh/.zshrc` in `~/.zshrc`
_init_zshrc()
{
	local file="$HOME/.zshrc"

	# Create a config file if it doesn't exist
	[[ ! -f $file ]] && touch $file

	# Check if a config file is already referenced
	(grep -q '.config/zsh/.zshrc' $file) && return 0

	# Backup the file
	local bakfile="$file~"
	cp $file $bakfile

	# Prepend file sourcing to a config using a temporary file
	local str='source "$HOME/.config/zsh/.zshrc"'
	tmpfile=$(mktemp)
	echo $str > $tmpfile
	echo >> $tmpfile
	cat $file >> $tmpfile
	cat $tmpfile > $file
	rm $tmpfile
}

_init_emacs()
{
    # Both standalone and terminal apps can read configs from symlinked dir
    ln -s ~/.config/emacs ~/.emacs.d
}

_init()
{
	# Enable key repeat on MacOS
	defaults write -g ApplePressAndHoldEnabled -bool false

    _init_zshrc
    _init_emacs
}

_install()
{
	echo "install called"
}

_help()
{
	echo "./manage.sh init    -- creates and links configs into \$HOME"
	echo "./manage.sh install -- install apps from brew"
}

main()
{
	case $1 in
		"init")    _init    ;;
		"install") _install ;;
		*)         _help    ;;
	esac
}

main $1
