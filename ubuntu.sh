sudo apt-get update
# basic
sudo apt-get install emacs zsh tmux git

# develop
sudo apt-get install g++ libopeblas-dev
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
curl https://dlang.org/install.sh | bash -s
~/dlang/install.sh ldc
