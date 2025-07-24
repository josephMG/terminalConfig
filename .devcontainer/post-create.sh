## Install neovim configuration

mkdir -p $HOME/.config/
bash -i -c 'nvm install --lts'

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

npm install -g pyright

uv sync --locked
echo alias vim=nvim >> ~/.bashrc
