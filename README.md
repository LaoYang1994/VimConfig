# VimConfig
My own vim configuration.

## Usage
+ git this repo
```bash
git clone https://github.com/LaoYang1994/VimConfig.git
```
After that, move this repo to the $HOME directory and rename the repo ".vim".

+ config
Just run the following scripts.
```bash
sh init_vim_config.sh
```
+ modify the path in the vimrc file
+ compile YouCompleteMe
 1. go to YCM repo,
```bash
cd $HOME/.vim/plugged/YouCompleteMe
```
 2. compile
  + python + C/C++
```bash
python install.py
```
  + python only
```bash
python install.py --clang-completer
```
