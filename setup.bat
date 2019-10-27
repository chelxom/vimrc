curl -fLo %USERPROFILE%/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mklink /d %USERPROFILE%\vimfiles %USERPROFILE%\.vim
vim +PlugInstall
