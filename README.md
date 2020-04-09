# vimrc

## Installation
On Windows:
```shell
git clone https://github.com/chelxom/vimrc %USERPROFILE%/.vim
curl -fLo %USERPROFILE%/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
mklink /d %USERPROFILE%\vimfiles %USERPROFILE%\.vim
vim +PlugInstall
```

On Unix-like:
```shell
git clone https://github.com/chelxom/vimrc ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall
```

On Windows, Vim doesn't treats `~/.vim/` as `'runtimepath'`/`'rtp'` by default, but `~/vimfiles/`.
However it's ok to clone Vundle into `~/.vim/` since Vundle is setup consistently using `set rtp+=~/.vim/bundle/Vundle.vim/`. 
And dependencies it installs will be put under `~/.vim/` and well recognized by Vim (Vundle adds their path to `'rtp'` too).

## Optional dependencies

### Font
-   mononoki: <https://github.com/madmalik/mononoki/>

### TeX
-   MiKTeX: <https://miktex.org/>

-   On Windows:
    -   SumatraPDF (portable): <https://www.sumatrapdfreader.org/free-pdf-reader.html>

        Rename the exe to `SumatraPDF.exe` and add its folder to `PATH`.

    -   Perl (portable): <http://strawberryperl.com/>

        `INSTALL/perl/bin` must be in `PATH`.

-   On MacOS:
    -   Skim

    TODO
