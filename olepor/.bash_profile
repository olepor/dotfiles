# The keybinds are set through Karabiner and seil.
# In order to remap caps-lock. Disable it in system-preferences.
# Then symlink dotfiles karabiner/private.xml into ~/Library/Applicatioin\ Support/Karabiner/private.xml
# Then reload xml from karabinercopy
export ALTERNATE_EDITOR=""
export EDITOR=emacsclient
export PATH=/usr/local/bin:$PATH
export USER="olepor"
export PATH=${PATH}:/Applications/MATLAB_R2015b.app/bin
PATH=$PATH:~/bash_scripts
export PATH
export PATH=${PATH}:/Library/TeX/texbin/
export PATH=${PATH}:/usr/local/gnat/bin

which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    # https://github.com/mxcl/homebrew/wiki/installation
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# Tap the Homebrew/bundle repo
brew tap Homebrew/bundle

brew_up_to_date=$(brew bundle check --file=~/dotfiles/brewfiles/Brewfile)
if [ ! "${brew_up_to_date}" = "The Brewfile's dependencies are satisfied." ]
then
	brew bundle —file=~/dotfiles/brewfiles/Brewfile
fi

# run the linking from dot files at every login
# Keep a copy of the brewfile in home
brew bundle dump --path=~/dotfiles/brewfiles/Brewfile --force

# download the dot files directory if it does not exist
if [ ! -d ~/dotfiles ]
then
	git clone git@github.com:olepor/dotfiles.git
fi

# Pull and update all files
git -C ~/dotfiles pull origin master

# If .spacemacs is non-existent, symlink all dot files from dotfiles
# into ~/ (home)
if [ ! -h ~/.spacemacs ]
then
	bash ~/dotfiles/bash_scripts/symlink_dotfiles 
fi

# if spacemacs is not installed. Clone the repo
if [ ! -d ~/.emacs.d/private ]
then
    rm -rf  ~/.emacs.d
    git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
fi

# make vi-binding the standard -- also enabled in .inputrc
set -o vi

# A daemon is set to launch in /Libary/LaunchAgents.*emacs.plist
# So that it is always loaded on logins
alias emacs='emacsclient -c --no-wait'

alias vim='mvim'

# Navigation aliases alias ..="cd .."

alias ..2="cd ../.."

alias ..3="cd ../../.."

test -r /sw/bin/init.sh && . /sw/bin/init.sh
CDPATH=~/.paths

# Everytime a new terminal is loaded, update the brew_installs file
# now migrated to a brewfile. Check out https://github.com/Homebrew/homebrew-bundle
eval "$(pyenv init -)"
