SHELL := /bin/bash
VIMRC=`pwd`/.vimrc
VIMRC_DEST=$(HOME)/.vimrc
VIMDIR_DEST=$(HOME)/.vim/


preinstall:
	# @if [ -z $(which ctags) ]; then sudo apt install ctags -y; fi
	@if [ -z $(which tmux) ]; then \
		git clone https://github.com/dalay/dottmux $(HOME)/.tmux; fi && \
		cd $(HOME)/.tmux && make install

install: preinstall
	@ln -s $(VIMRC) $(VIMRC_DEST)
	@vim -c ':PlugInstall --sync | :qa!'
	@if sudo true && [[ $(USER) != 'root' ]]; then \
		sudo ln -s ~$(USER)/.vim /root/.vim && sudo ln -s /root/.vim/.vimrc /root/.vimrc ; fi

install-simple:
	@ln -s $(VIMRC) $(VIMRC_DEST)
	@vim -c ':PlugInstall --sync | :qa!'

update: plug-upgrade
	@vim -c ':PlugUpdate | :qa!'

upgrade: plug-clean plug-install update

plug-upgrade:
	@vim -c ':PlugUpgrade | :qa!'

plug-clean:
	@vim -c ':PlugClean | :qa!'

plug-install:
	@vim -c ':PlugInstall | :qa!'

.PHONY: install update upgrade plug-upgrade plug-clean plug-install
