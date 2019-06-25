# vimrc

```shell
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

On Windows, Vim doesn't treats `~/.vim/` as `'runtimepath'`/`'rtp'` by default, but `~/vimfiles/`.
However it's ok to clone Vundle into `~/.vim/` since Vundle is setup consistently using `set rtp+=~/.vim/bundle/Vundle.vim/`. 
And dependencies it installs will be put under `~/.vim/` and well recognized by Vim (Vundle adds their path to `'rtp'` too).
