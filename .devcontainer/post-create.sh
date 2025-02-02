## Install neovim configuration

mkdir -p $HOME/.config/
bash -i -c 'nvm install --lts'

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

npm install -g pyright
pip install -r requirements.txt
poetry install
