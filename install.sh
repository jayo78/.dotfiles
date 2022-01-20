#!/bin/bash

# ========================================================= INSTALL GIT AND ZSH ======================================================

if command -v zsh &> /dev/null && command -v git &> /dev/null && command -v wget &> /dev/null; then
    echo -e "ZSH and Git are already installed\n"
else
    if sudo apt install -y zsh git wget || sudo pacman -S zsh git wget || sudo dnf install -y zsh git wget || sudo yum install -y zsh git wget || sudo brew install git zsh wget || pkg install git zsh wget ; then
        echo -e "zsh wget and git Installed\n"
    else
        echo -e "Please install the following packages first, then try again: zsh git wget \n" && exit
    fi
fi


if mv -n ~/.zshrc ~/.zshrc-backup-$(date +"%Y-%m-%d"); then # backup .zshrc
    echo -e "Backed up the current .zshrc to .zshrc-backup-date\n"
fi


echo -e "Installing oh-my-zsh\n"
if [ -d ~/.config/oh-my-zsh ]; then
    echo -e "oh-my-zsh is already installed\n"
elif [ -d ~/.oh-my-zsh ]; then
     echo -e "oh-my-zsh is already installed at '~/.oh-my-zsh'. Moving it to '~/.config/oh-my-zsh'"
     export ZSH="$HOME/.config/oh-my-zsh"
     mv ~/.oh-my-zsh ~/.config/oh-my-zsh
else
    git clone --depth=1 git://github.com/robbyrussell/oh-my-zsh.git ~/.config/oh-my-zsh
fi

if [ -f ~/.zcompdump ]; then
    mv ~/.zcompdump* ~/.cache/zsh/
fi

if [ -d ~/.config/oh-my-zsh/plugins/zsh-autosuggestions ]; then
    cd ~/.config/oh-my-zsh/plugins/zsh-autosuggestions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions ~/.config/oh-my-zsh/plugins/zsh-autosuggestions
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/oh-my-zsh/custom/plugins/zsh-syntax-highlighting
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-completions ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-completions && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-completions ~/.config/oh-my-zsh/custom/plugins/zsh-completions
fi

if [ -d ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search ]; then
    cd ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search && git pull
else
    git clone --depth=1 https://github.com/zsh-users/zsh-history-substring-search ~/.config/oh-my-zsh/custom/plugins/zsh-history-substring-search
fi

# ========================================================= INSTALL NODE ============================================================

if command -v node &> /dev/null; then
    echo -e "Node already installed\n"
else
    if sudo apt install -y node || sudo pacman -S node || sudo dnf install -y node || sudo yum install -y node || sudo brew install node || pkg install node; then
        echo -e "Node Installed\n"
    else
        echo -e "Couldn't install Node" && exit
    fi
fi

# ========================================================= INSTALL NEOVIM ==========================================================

if command -v nvim &> /dev/null; then
    echo -e "Neovim already installed\n"
else
    if sudo apt install -y neovim || sudo pacman -S neovim || sudo dnf install -y neovim || sudo yum install -y neovim || sudo brew install neovim || pkg install neovim; then
        echo -e "Neovim Installed\n"
    else
        echo -e "Couldn't install Neovim" && exit
    fi
fi

if [ -s "$HOME/.config/nvim/init.vim" ]; then
    echo -e "Neovim init.vim found - creating backup and replacing" 
    cp $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.old
fi

cp -f init.vim $HOME/.config/nvim/init.vim


# ========================================================= INSTALL PLUGGED =========================================================
# Also installs plugins defined in .vimrc

if [ -s "$HOME/.vim/autoload/plug.vim" ]; then
    echo "vim-plug is already installed, skipping installation step."
else
    echo "installing vim-plug..."
    curl -fsSLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    yes | vim +PlugInstall +qall        
fi

# ========================================================= INSTALL EXTENSIONS ======================================================

if [ ! -d "$HOME/.config/coc/extensions" ]; then
    echo "Creating $HOME/.config/coc/extensions"
    mkdir $HOME/.config/coc/extensions

cp package.json $HOME/.config/coc/extensions/
cd $HOME/.config/coc/extensions && npm install

# ========================================================= COC SETTINGS ======================================================

if [ -s "$HOME/.config/nvim/coc-settings.json" ]; then
    echo "Already have coc-settings.json setup ... skipping"
else
    cp coc-settings.json $HOME/.config/nvim/
fi


