# vimrc

## Installation
On Windows:
```shell
git clone https://github.com/chelxom/vimrc %USERPROFILE%/.vim
git clone https://github.com/VundleVim/Vundle.vim.git %USERPROFILE%/.vim/bundle/Vundle.vim
mklink /d %USERPROFILE%\vimfiles %USERPROFILE%\.vim
vim +PluginInstall +qall
```

On Unix-like:
```shell
git clone https://github.com/chelxom/vimrc ~/.vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
```

On Windows, Vim doesn't treats `~/.vim/` as `'runtimepath'`/`'rtp'` by default, but `~/vimfiles/`.
However it's ok to clone Vundle into `~/.vim/` since Vundle is setup consistently using `set rtp+=~/.vim/bundle/Vundle.vim/`. 
And dependencies it installs will be put under `~/.vim/` and well recognized by Vim (Vundle adds their path to `'rtp'` too).

## Optional dependencies
Font mononoki: <https://github.com/madmalik/mononoki/>
