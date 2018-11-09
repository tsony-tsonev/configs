#/bin/sh
# install vim
sudo apt-get -y remove vim vim-runtime gvim
# install deps for manually building vim
sudo apt-get -y install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev
libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev python2.7 python3.6 python-pip python3-pip
sudo mkdir /usr/include/lua5.1/include
sudo cp /usr/include/lua5.1/* /usr/include/lua5.1/include
git clone https://github.com/vim/vim.git
cd vim
sudo make uninstall # remove previous custom builds if any
make distclean
./configure --with-features=huge \
            --enable-multibyte \
	    	--enable-rubyinterp=yes \
	    	--enable-pythoninterp=yes \
	    	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \ # pay attention here check directory correct
	    	--enable-python3interp=yes \
	    	--with-python3-config-dir=/usr/lib/python3.6/config-3.6m-x86_64-linux-gnu \ # pay attention here check directory correct
	    	--enable-perlinterp=yes \
	    	--enable-luainterp=yes \
            --with-luajit \
            --with-lua-prefix=/usr/include/lua5.1 \
            --enable-gui=gtk2 \
            --enable-largefile \
            --enable-fail-if-missing \
            --enable-cscope \
            --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install
cd ..
sudo rm -rf vim
#install neovim-bridge for the autocomplete
pip3 install neovim
go get -u github.com/mdempsky/gocode
# install and change to zsh
sudo apt-get -y install zsh
chsh -s $(which zsh)
# zsh plugin manager
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
git clone git://github.com/zsh-users/zaw.git ~/.oh-my-zsh/custom/plugins/zaw
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/JamesKovacs/zsh_completions_mongodb.git ~/.oh-my-zsh/custom/plugins/mongodb
# install tmux
sudo apt-get -y install curl xclip python-pygments
TMUX_VERSION=2.5
sudo apt-get -y remove tmux
sudo apt-get -y install wget tar libevent-dev libncurses-dev
wget https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz
tar xf tmux-${TMUX_VERSION}.tar.gz
rm -f tmux-${TMUX_VERSION}.tar.gz
cd tmux-${TMUX_VERSION}
sudo make uninstall
./configure
make
sudo make install
cd -
sudo rm -rf /usr/local/src/tmux-*
sudo mv tmux-${TMUX_VERSION} /usr/local/src
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tmux-sensible ~/.tmux/plugins/tmux-sensible
# install tmux nord theme
git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/plugins/nord-tmux
# vim plugin manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# install vim fonts
# note: do not forget to set terminal emulator font to DroidSansMono
mkdir ~/.local/share/fonts && cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# install vim-tagbar deps
sudo apt-get -y install exuberant-ctags
# simlink and proper files
rm ~/.vimrc
rm ~/.tmux.conf
rm ~/.zshrc
rm ~/vim-plugins
ln -s `pwd`/vim-plugins ~/vim-plugins
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.tmux.conf ~/.tmux.conf
ln -s `pwd`/.zshrc ~/.zshrc
touch .zsh_private
# needed for the vim 8+ persistent undo history
mkdir ~/.vim/undo
