"=============================================================================
" 显示相关
"=============================================================================
"设定行号
set number
"定义tab所等同的空格长度
set tabstop=4
"设为真，使用tab的时候就会自动转成空格
set expandtab
"用于程序中自动缩进所使用的空白长度指示
set shiftwidth=4
"语法高亮
syntax enable
"开启256色
set t_Co=256
colorscheme molokai

"height ligth cusor
set background=dark                 "or set bg=dark
"水平线
set cursorline
"竖线
set cursorcolumn
"行最大长度提示线
set colorcolumn=100                 "or cc
"支持term(黑白终端), cterm(彩色终端), gui(gvim窗口), 可定义为: bold,
"underline, reverse, italic, standout
highlight CursorLine   cterm=none ctermbg=236
highlight CursorColumn cterm=none ctermbg=236
highlight ColorColumn  cterm=none ctermbg=238

set hlsearch


"=============================================================================
" 其他
"=============================================================================
"vim编辑模式下粘贴代码
set pastetoggle=<F9>
"Python PEP8
autocmd FileType python noremap <buffer> <F8> :call Autopep8()<CR>
"Vim 内部使用的字符编码方式，包括 Vim 的 buffer (缓冲区)、菜单文本、消息文本等
set encoding=utf-8
"leader setting
let g:mapleader = ","
"打开文件类型检测
"允许vim加载文件类型插件
"允许vim为不同类型的文件定义不同的缩进格式
filetype plugin indent on
" 按 F5 执行当前 Python 代码"
map <F5> :call RunFile()<CR>
func! RunFile()
    exec "w" 
    if &filetype == 'python'
        exec "!time python %"
    endif
endfunc

"去掉有关vi一致性模式，避免以前版本的一些bug和局限
set nocompatible
"indent: 如果用了:set indent,:set ai
"等自动缩进，想用退格键将字段缩进的删掉，必须设置这个选项。否则不响应。
"eol:如果插入模式下在行开头，想通过退格键合并两行，需要设置eol。
"start：要想删除此次插入前的输入，需设置这个。
set backspace=indent,eol,start


"=============================================================================
" plug插件管理
"=============================================================================
call plug#begin('~/.vim/plugged')
Plug 'tell-k/vim-autopep8'
Plug 'nvie/vim-flake8'
Plug 'Valloric/YouCompleteMe'
"Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'flazz/vim-colorschemes'
Plug 'Raimondi/delimitMate'
Plug 'kien/rainbow_parentheses.vim'
Plug 'guns/xterm-color-table.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()


"以下为各个插件的配置
"=============================================================================
" YouCompteteMe
"=============================================================================
"语义补全, 参考https://zhuanlan.zhihu.com/p/33046090
let g:ycm_semantic_triggers =  {
			\ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
			\ 'cs,lua,javascript': ['re!\w{2}'],
			\ }
"白名单
let g:ycm_filetype_whitelist = { 
            \ "c":1,
            \ "cpp":1, 
            \ "objc":1,
            \ "python": 1,
            \ "sh":1,
            \ "zsh":1,
            \ }
"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
set completeopt=longest,menu
"离开插入模式后自动关闭预览窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
"切换补全内容
let g:ycm_key_list_select_completion=['<TAB>', '<Down>']
"let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

let g:ycm_server_log_level = 'info'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
"关闭加载.ycm_extra_conf.py提示
let g:ycm_confirm_extra_conf=0

" 开启 YCM 基于标签引擎, 不是很懂
let g:ycm_collect_identifiers_from_tags_files=1
" 从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

"注释、字符串补全
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1

"跳转
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR> 
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR> 
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR> 


"=============================================================================
" NERDTree
"=============================================================================
map <C-t> :NERDTreeToggle<CR>
"关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!
autocmd bufenter * 
    \ if (winnr("$") == 1 && exists("b:NERDTreeType") &&
    \b:NERDTreeType == "primary") | q | endif
"autocmd VimEnter * NERDTree
"显示行号
"let NERDTreeShowLineNumbers=1
"let NERDTreeAutoCenter=1
"是否显示隐藏文件
let NERDTreeShowHidden=1
"设置宽度
let NERDTreeWinSize=32
"在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1
"忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
"显示书签列表
let NERDTreeShowBookmarks=1
"文件树位置
let NERDTreeWinPos="left"


"=============================================================================
" nerdcommenter, the following settings come from github page
"=============================================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 0
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left
" instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1


"=============================================================================
" nerdtree-git-plugin
"=============================================================================
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }


"=============================================================================
" rainbow_parenthsis settings
"=============================================================================
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
"不知道表示什么，应该是插件内部参数
let g:rbpt_loadcmd_toggle = 0
"au: autocmd
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

