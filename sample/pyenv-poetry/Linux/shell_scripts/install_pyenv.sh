#!/bin/sh

echo ""
echo "### Install pyenv ###"
echo ""

echo "[pwd]"
echo pwd

確認する


git clone https://github.com/pyenv/pyenv.git ~/.pyenv

# スタートアップ時から pyenv を適用する場合に有効化する（メインで pyenv を使用しない場合は不要）
# echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
# echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(pyenv init -)"' >> ~/.bashrc