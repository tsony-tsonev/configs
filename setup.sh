#/bin/sh
# FIRST manually install vim 8 with lua support
# install and change to zsh
sudo apt-get -y install zsh
chsh -s $(which zsh)
# zsh plugin manager
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
# install tmux
sudo apt-get -y install tmux
# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# vim plugin manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

