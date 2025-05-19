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
    ln ~/.config/emacs/init.el ~/.emacs
    mkdir -p ~/.emacs.d
    ln ~/.config/emacs/early-init.el ~/.emacs.d/early-init.el
}

_init()
{
	_init_zshrc
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
