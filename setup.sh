#/bin/sh
# install vim
sudo apt-get -y remove vim vim-runtime gvim
# install deps for manually building vim
sudo apt-get -y install liblua5.1-dev luajit libluajit-5.1 python-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev python2.7 python-pip
git clone https://github.com/vim/vim.git
cd vim
sudo make uninstall # remove previous custom builds if any
./configure --with-features=huge \
            --enable-rubyinterp \
            --enable-largefile \
            --disable-netbeans \
            --enable-pythoninterp \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
            --enable-fail-if-missing \
            --with-lua-prefix=/usr/include/lua5.1 \
            --enable-cscope
sudo make install
cd ..
rm -rf vim
# install and change to zsh
sudo apt-get -y install zsh
chsh -s $(which zsh)
# zsh plugin manager
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# install tmux
sudo apt-get -y install tmux curl
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# install tmux nord theme
git clone https://github.com/arcticicestudio/nord-tmux ~/.tmux/themes/nord-tmux
# vim plugin manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
# install vim fonts
mkdir ~/.local/share/fonts && cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
# install vim-tagbar deps
sudo apt-get -y install exuberant-ctags
# simlink and proper files
ln -s `pwd`/vim-plugins ~/vim-plugins
ln -s `pwd`/.vimrc ~/.vimrc
ln -s `pwd`/.tmux.conf ~/.tmux.conf
cp .zshrc ~/.zshrc

