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

## Mandatory dependencies

### Python3

1.  Check the exact version of Python3 which VIM is compiled against.

    In VIM, run `:version` and check the compilation option `-DDYNAMIC_PYTHON3_DLL`, it's the exact version of Python3 to install.
    Assump it's `python36.dll`.

    > Not mandatory, but to avoid warnings.

1.  If the VIM is 32-bit, the Python3 must be 32-bit too.

    Create a new Conda environment and install 32-bit Python3 [(ref)](https://stackoverflow.com/a/58014896):

    ```shell
    conda create -n py3_x86_vim
    conda activate py3_x86_vim
    conda config --env --set subdir win-32
    conda install python=3.6
    ```

    > Keep the environment name `py3_x86_vim` exactly the same to save configuring the path on new machines.

    > Use Tsinghua's mirror of Anaconda: <https://mirrors.tuna.tsinghua.edu.cn/help/anaconda/>

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
