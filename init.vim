" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @theniceboy
" vim-esearch
" fmoralesc/worldslice
" SidOfc/mkdx


" ===
" === Auto load for first time uses
" ===
" 这里的$MYVIMRC是/Users/glimmer/.config/nvim/init.vim 而非vimrc
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" 智能选择括号内容，如果不存在该文件则安装同步跟新
if empty(glob('~/.config/nvim/plugged/wildfire.vim/autoload/wildfire.vim'))
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
	let has_machine_specific_file = 0
	silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
"source $XDG_CONFIG_HOME/nvim/_machine_specific.vim
source ~/.config/nvim/_machine_specific.vim


" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
"阻止不正确的背景渲染，某些终端配色可能不对需要这个调整
let &t_ut=''
"自动切换当前目录为当前文件所在的目录
set autochdir

" ===
" === Editor behavior
" ===
"假如我们要对每一个不同的目录进行不同的设置,一个办法就是在每一个目录中放入.vimrc或是.gvimrc文件.然而这样做还是不够的,因为默认的Vim会忽略这些文件.要使得Vim读入这些文件,我们必须执行下面的命令::set exrc 进行这样的设置却存在着安全问题.毕竟一些不成功的命令是很容易加入到这些文件中的,即使我们是在其他的目录中进行我们的编辑工作,这样的设置也会影响我们的.为了避免安全问题,我们可以用下面的命令来设置安全选项:set secure 这个选项会阻止当前目录下的初始文件中的:autocommand,:write,:shell命令的执行.
set exrc
set secure
"设置行号
set number
"设置相对行号
set relativenumber 
"进入编辑模式时使用绝对行号，退出编辑模式进入normal模式时使用相对行号
augroup relative_numbser
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END


"设置当前行下划线提示
set cursorline
set whichwrap+=<,>,h,l,[,]  " 设置光标键跨行 normal和insert模式均可使用
" 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存,即文件未保存时由vim保存
" 允许没有保存文件即可以跳转到别的文件中去，通过vim的缓冲区实现。
set hidden


"设置 expandtab 选项后，在插入模式下，会把按 Tab 键所插入的 tab
"字符替换为合适数目的空格。如果确实要插入 tab 字符，需要按 CTRL-V
"键，再按tab，设置 expandtab 选项只能把新插入的 tab 字符替换成特定数目的空格，不影响文件中已有的 tab 字符。即，文件已有的 tab 字符会保持不变。
"set expandtab
set noexpandtab
"tab的距离,tabstop 选项设置 tab 字符的显示宽度为多少个空格，默认值是 8
set tabstop=2
"自动缩进时,缩进长度为2
set shiftwidth=2
"softtabstop 选项影响 vim 在插入模式下按 Tab 键所实际得到的字符，不改变 vim 中 tab 字符的显示宽度，tab 字符始终显示为 tabstop 指定的宽度。
set softtabstop=2
"在此之后，如果在一行的开头输入空格或制表符，那么后续的新行将会缩进到相同的位置。
"在命令模式下，可以使用 >> 命令让现有的一行增加一级缩进，使用 << 命令减少一级缩进。在这些命令前面加上一个整数，即可让多行增加或减少一级缩进。例如，把游标放在第 6 行的开头，进入命令模式之后，输入 5>> 就会让下面五行增加一级缩进。
set autoindent
"让空格和tab字符可见
set list
"设置tab和当前行尾为特殊字符
set listchars=tab:\|\ ,trail:▫
"(滚动偏移量)选项确定您希望在光标上方和下方看到的上下文行的数量。将其设置为5，使其在移动/滚动时始终在光标上方和下方可见5行。scrolloff"设置为较大的值会使光标在可能的情况下停留在中间行比如999
set scrolloff=8
" set scrolloff=999
"键码或映射码的超时时间，单位为毫秒，一般设置成非0要开启set timeout，并且设置timeoutlen时间
set ttimeoutlen=0
"键盘输入等待，比如sl映射了，按了s后等待一秒看是否有l输入
set notimeout
"更改:mkview命令的效果 mkview用于代码折叠
set viewoptions=cursor,folds,slash,unix
"你打开了一个文件，做了很多折叠然后关闭文件，再次打开之后这些折叠信息都不见了。在关闭之前用:mkview保存当前的view即可，下次打开文件之后用:loadview即可恢复你之前做过的折叠记录。在每次文件关闭的时候都会自动执行:mkview，而每次文件打开的时候都会自动执行:loadview。
"下方的设置可能与set foldenable（所有折叠都打开）冲突
"au BufWinLeave * silent mkview
"au BufWinEnter * silent loadview
"让行不超过当前窗口而自动换行，自动折行，即太长的行分成几行显示
set wrap
"取消长行自动分成多行，避免复制或者写长行的时候vim自动分行，全名为textwidth
set tw=0
"设置缩进函数
set indentexpr=
"折叠方式 indent 更多的缩进表示更高级别的折叠,启用缩进折叠。所有文本将按照（选项shiftwidth 定义的）缩进层次自动折叠。可以设置显示折叠的级别
set foldmethod=indent
"使用高级别折叠
set foldlevel=99
"所有折叠都打开
set foldenable
set display=lastline     " 避免折行后某一行不见
"标签添加时考虑兼容性选项
set formatoptions-=tc
"默认设置右侧分屏
set splitright
"默认设置下方分屏
set splitbelow
"不在左下角显示如“—INSERT--”之类的状态栏，因为用插件显示
set noshowmode
"将会在输入命令时，在屏幕底部显示出部分命令
set showcmd
" 在状态行上显示光标所在位置的行号和列号
set wildmenu
set wildmode=full        " zsh补全菜单
" 补全方式不要显示过多内容
set shortmess+=c
"关闭输入匹配错误提示，比如说按了一个特殊的字符但没映射，一般会有提示说未找到模式等。
set inccommand=split
"completeopt是用来设置补全模式
set completeopt=longest,noinsert,menuone,noselect,preview
"加快终端重新绘制窗口，特别是针对鼠标等滚动
set ttyfast "should make scrolling faster
set lazyredraw "same as above
"使用可视铃而不是哔哔声
set visualbell
"出错发声被彻底被禁止了
"set vb t_vb=
" 关闭错误的提示
"set noeb
"静默执行，如果目录不存在（上下级目录）则创建（上下级目录），如果存在则不操作
"创建undo历史文件夹和backup备份历史文件夹
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
" undo 持久化 配合undotree使用，即使文件重新打开亦可以查看到历史记录
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

"设置第多少个字符后显示一条竖线以让用户知道这一行写了多少个字体
"set colorcolumn=100
"如果100毫秒没有输入任何内容,交换文件将写入到磁盘中。
set updatetime=100
"允许在可视块模式下进行虚拟编辑，虚拟编辑意味着光标可以定位在没有实际字符的地方。这可以位于选项卡的中间或者行尾。用于在可视模式下选择矩形或者编辑表哥。
" 允许光标出现在最后一个字符的后面
set virtualedit=block,onemore

"vim自动跳到上次打开的光标位置,自动保存光标位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" ===
" === Terminal Behaviors
" ===
"neoterm是neovim下的一款terminal终端管理插件，通过它可以很方便地执行命令和调试
"触发方式为 <leader> /  
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
" neoterm 终端模式下的快捷键 
" 在neoterm按ctrl+N(或者ctrl+n) 进入到vim编辑模式，在该模式下可以使用vim的上下左右，复制黏贴等命令，按i等命令可以重新回到term正常的输入模式中，按：q可以退出。
tnoremap <C-N> <C-\><C-N>
" 打开一个和之前的标签页一样内容的标签页
" 如果原来页面在vim中则打开一个一样页面的vim
tnoremap <C-O> <C-\><C-N><C-O>


" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
noremap ; :

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap S :w<CR>
noremap <LEADER>rr :r! sed -n '1,2p' < xxxx.xxx
"也可以通过在想导入内容文件中 :1,2w >> xxxx.xxxx
"即追加当前文本中的1，2行到xxx文件中
"已经用于窗口管理
"map <LEADER>w :w !
map <LEADER>sr :%s/
" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>
"noremap <LEADER>rv :e .nvimrc<CR>

" Undo operations
"noremap l u

" Insert Key
"noremap k i
"noremap K I

" make Y to copy till the end of the line
"让Y等同于复制到行尾
nnoremap Y y$

"视图模式下Y复制到黏贴版
" Copy to system clipboard
vnoremap Y "+y

"mac linux均可以设置。允许p黏贴黏贴版版内容到vim，允许y复制黏贴板内容
set clipboard=unnamed
"把内容复制到系统粘贴板+
map <LEADER>c "+y
"将系统粘贴板+的内容复制到vim中
map <LEADER>v "+p
"linux  复制到系统黏贴版,macos则使用pbpaste pbcopy
"vnoremap Y :w !xclip -i -sel c<CR>

"缩进快捷键映射
" Indentation
nnoremap < <<
nnoremap > >>

"删除一对括号内的内容包括括号  先f) 然后dy
" Delete find pair
nnoremap dy d%

" Search
"noremap <LEADER><CR> :nohlsearch<CR>
"设置让查找内容高亮
set hlsearch
"启动vim时取消查找内容高亮
exec "nohlsearch"
"边输入边高亮显示
set incsearch
"查询的时候忽略大小写
set ignorecase
"开启查询的时候智能大小写匹配
set smartcase
"按2次esc按键后取消查询的高亮显示
noremap <Esc><Esc> :nohlsearch<CR>

" Adjacent duplicate words
"dw 貌似有问题要排查
"noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1
noremap <LEADER>fd /\(\<\w\+\>\)\_s*\1

" Space to Tab
" 添加markdown表格符号
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g

" Folding
" o映射za，打开所有折叠 需要扩展学习下代码折叠的命令
noremap <silent> <LEADER>o za


" nnoremap <c-n> :tabe<CR>:-tabmove<CR>:term lazynpm<CR>


" ===
" === Cursor Movement
" ===
" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     u
" < n   i >
"     e
"     v
"noremap <silent> u k
"noremap <silent> n h
"noremap <silent> e j
"noremap <silent> i l
"gk 2gk 3gk 表示往上移动多少行，gj 2gj 3gj表示往下移动多少行
"noremap <silent> gu gk
"noremap <silent> ge gj
"选择从光标到行尾内容
" noremap <silent> \v v$

" U/E keys for 5 times u/e (faster navigation)
"noremap <silent> U 5k
"noremap <silent> E 5j
"让大写kjhl表示上下移动5个字符和左右移动7个字符，加快左右移动速度
noremap K 5k
noremap J 5j
noremap H 7h
noremap L 7l


" N key: go to the start of the line
"noremap <silent> N 0
" I key: go to the end of the line
"noremap <silent> I $
" 让leader;, leader'. 表示行首行尾
noremap <silent> <leader>; 0
noremap <silent> <leader>' $
" Faster in-line navigation
" W等于下5个单词词头，B等于上5个单词词头，e表示下一个单词词尾，ge表示上一个单词词尾
noremap W 5w
noremap B 5b
noremap E ge

" set h (same as n, cursor left) to 'end of word'
"noremap h e

" Ctrl + U or E will move up/down the view port without moving the cursor
" 很少用到，为了避免冲突，去除
" noremap <C-E> 5<C-e>
" noremap <C-U> 5<C-y>



"source $XDG_CONFIG_HOME/nvim/cursor.vim

"If you use Qwerty keyboard, uncomment the next line.
"source $XDG_CONFIG_HOME/nvim/cursor_for_qwerty.vim
"刷新curosr_for_querty键盘，neovim支持让asdfghjkl;（表示1234567890）配合上[和‘表示上移多少行或者下移多少行
"实际没什么用
"source ~/.config/nvim/cursor_for_qwerty.vim

" ===
" === Insert Mode Cursor Movement
" ===
" <ESC>A 表示行尾插入
"inoremap <C-a> <ESC>A


" ===
" === Command Mode Cursor Movement
" ===
" 没什么用，因为我已经在系统上映射了alt+hjkl表示上下左右
"cnoremap <C-a> <Home>
"cnoremap <C-e> <End>
"cnoremap <C-p> <Up>
"cnoremap <C-n> <Down>
"cnoremap <C-b> <Left>
"cnoremap <C-f> <Right>
"cnoremap <M-b> <S-Left>
"cnoremap <M-w> <S-Right>


" ===
" === Searching
" ===
"noremap - N
"noremap = n


" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
" 多窗口的定位
"在多窗口间切换到下一个窗口
noremap <LEADER>sw <C-w>w
"方向键在不同窗口间移动
noremap <LEADER>k <C-w>k
noremap <LEADER>j <C-w>j
noremap <LEADER>h <C-w>h
noremap <LEADER>l <C-w>l
"关闭其他窗口只保留一个
noremap qf <C-w>o

" Disable the default s key
" 去除s按键的默认功能
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
" 分窗口管理
noremap sk :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sj :set splitbelow<CR>:split<CR>
"noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
" 窗口大小的控制
noremap <down> :res +5<CR>
noremap <up> :res -5<CR>
noremap <right> :vertical resize-5<CR>
noremap <left> :vertical resize+5<CR>

" Place the two screens up and down
"noremap sh <C-w>t<C-w>K
" Place the two screens side by side
"noremap sv <C-w>t<C-w>H
"分屏模式切换，sv水平分屏，shh垂直分屏
" side by side : side by l (left)
map <silent> sbl <C-w>t<C-w>H  
" up and down  : side by j (down)
map <silent> sbj <C-w>t<C-w>K  

" Rotate screens
" 跟上边切换分屏 水平分屏和垂直分屏一个样子
"noremap srh <C-w>b<C-w>K
"noremap srv <C-w>b<C-w>H

" Press <SPACE> + q to close the window below the current window
"需要改键，已经被我利用了
"noremap <LEADER>q <C-w>j:q<CR>


" ===
" === Tab management
" ===
" Create a new tab with tu
" 标签管理
" tn是新建一个空白标签
noremap tn :tabe<CR>
" tN是新建一个跟当前标签一样的标签
noremap tN :tab split<CR>
" Move around tabs with tn and ti
" 移动到上一个标签和下一个标签
noremap th :-tabnext<CR>
noremap tl :+tabnext<CR>
" Move the tabs with tmn and tmi
" 将标签往前移动或者往后移动
noremap tmh :-tabmove<CR>
noremap tml :+tabmove<CR>


" ===
" === Markdown Settings
" ===
" Snippets
" markdown 快捷按键方式
source ~/.config/nvim/md-snippets.vim


" auto spell
autocmd BufRead,BufNewFile *.md setlocal spell
" Spelling Check with <space>sc
"开启或者关闭拼写
map <LEADER>sc :set spell!<CR>
" 快捷键 z=  查看拼写建议。此为系统自带


" ===
" === Other useful stuff
" ===
" Open a new instance of st with the cwd
" st不知道是什么命令
"nnoremap \t :tabe<CR>:-tabmove<CR>:term sh -c 'st'<CR><C-\><C-N>:q<CR>

" Opening a terminal window
"从nvim中打开一个终端窗口
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
"noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l
" ,f找到锚点<++>
noremap ,f <Esc>/<++><CR>:nohlsearch<CR>c4l


" Press ` to change case (instead of ~)
" 不知道为什么没生效
noremap ` ~
" zz 当前位置滚动到屏幕中央 
"noremap <C-c> zz

" Auto change directory to current dir
" 将终端目录调动到当前打开文件的目录中去
autocmd BufEnter * silent! lcd %:p:h

" Call figlet
" 需要先安装figlet来输入figlet一样的大字体
noremap tx :r !figlet 

" find and replace
" 发现并且替换
noremap \s :%s///g<left><left>

" set wrap
" 设置换行
"让行不超过当前窗口而自动换行，自动折行，即太长的行分成几行显示
"noremap <LEADER>sw :set wrap<CR>

" press f10 to show hlgroup
" vim-spector 代码调试插件 f10 完成步骤 finish
function! SynGroup()
	let l:s = synID(line('.'), col('.'), 1)
	echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun
map <F10> :call SynGroup()<CR>

" Compile function
" r 表示编译/运行当前文件
noremap r :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		set splitbelow
		:sp
		:res -5
		term javac % && time java %<
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device." ".g:flutter_run_args
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.config/nvim/plugged')

" Plug 'LoricAndre/fzterm.nvim'

" Testing my own plugin
" Plug 'theniceboy/vim-calc'

" Treesitter
" 要github查看具体用法
" nvim-treesitter 设置语法高亮显示
Plug 'nvim-treesitter/nvim-treesitter'
" 直接在nvim中查看treesitter信息 增强treesitter
Plug 'nvim-treesitter/playground'

" Pretty Dress
" 配色方案
Plug 'theniceboy/nvim-deus'
"Plug 'arzg/vim-colors-xcode'

" Status line
"显示vim状态和文件等信息
Plug 'vim-airline/vim-airline'
" 设置状态条样式
"Plug 'theniceboy/eleline.vim'
" 状态条滚动显示所在位置在文章中的区域
"Plug 'ojroques/vim-scrollstatus'

" General Highlighter
"即时显示所设置的颜色
" rgb(255,140,0)
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
" 用于突出显示光标下当前单词的其他用途
Plug 'RRethy/vim-illuminate'

" File navigation
"Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'Xuyuanp/nerdtree-git-plugin'
" fzf.vim插件 模糊文件查找器 需要安装fzf
Plug 'junegunn/fzf.vim'
" fzf增强插件
" 让<leader>f作为fzf的默认按键
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" Rnvimr 是一个 NeoVim 插件，它允许您在浮动窗口中使用 Ranger。
" 需要通过pip3安装ranger才能支持
" shift+r 激活ranger
Plug 'kevinhwang91/rnvimr'
" rooter 当你打开文件或者目录时，rooter会将工作目录更改为项目根目录,没有匹配的则设置为home
Plug 'airblade/vim-rooter'
" vim 变成ide，用于查找类型定义 声明等 ，编程相关
" <leader>jj 激活
Plug 'pechorin/any-jump.vim'

" Taglist 编程标签相关
" <LEADER>v 打开所有函数与变量列表
" ctrl-t 通过coc打开函数与变量列表并显示内容
Plug 'liuchengxu/vista.vim'

" Debugger
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

" Auto Complete
" 代码补全功能 需要添加lsp语言服务支持
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'tag': 'v0.0.79'}

" c-x c-u 同时按
" ctrl+x ctrl+u 触发在其他终端有的内容可以提示到当前neovim输入模式中
" 使用方法，比如你在当前neovim中打开了一个文件，然后在别的终端下查找一个内容
" history |grep go install
" 输出了go install golang.org/x/tools/cmd/godoc
" 那么你在neovim中进入编辑模式，同时按ctrl x ctrl u
" 则会给出在该终端中的提示，避免切换到该终端下复制内容
Plug 'wellle/tmux-complete.vim'

" Snippets
" 代码片段替换，代码片段放在UltiSnips中，貌似只需要有该文件vim-snippets亦可以替换了
" Plug 'SirVer/ultisnips'
" 编程语言片段代码 通过tab来补全
" vim-snippets 只需要他的ultisnips代码片段，其他用coc.snippets实现了
" 但是还是要装的，因为cos.snippets貌似需要它，注释掉的话需要在runtimepath中写上他的路径
Plug 'theniceboy/vim-snippets'

" Undo Tree
" 用于查看文件历史修改记录
Plug 'mbbill/undotree'

" Git
" 为 .gitignore 文件提供语法高亮和最新的代码片段。
" 会跟coc-snippets冲突，报错
" Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
" 通过fzf来创建gitignore文件
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"Plug 'mhinz/vim-signify'
" 在符号列中显示 git diff 的 Vim 插件。它显示已添加、修改或删除了哪些行
Plug 'airblade/vim-gitgutter'
" 一个类似gitk风格的repository查看器
Plug 'cohama/agit.vim'
" neovim的lazygit插件，通过它在neovim中调用lazygit
" git的插件
" 暂时注释
" Plug 'kdheepak/lazygit.nvim'

" Autoformat
" vimscript插件 vim-codefmt格式化工具会用到它
Plug 'google/vim-maktaba'
" 使用 :FormatLines 格式化一系列行或使用 :FormatCode 格式化整个缓冲区。使用 :NoAutoFormatBuffer 禁用当前缓冲区格式。一般不用执行，执行保存命令就会自动执行这。
Plug 'google/vim-codefmt'

" Tex
" Plug 'lervag/vimtex'

" CSharp
" csharp 插件
"Plug 'OmniSharp/omnisharp-vim'
" 上一个插件的依赖插件
"Plug 'ctrlpvim/ctrlp.vim' , { 'for': ['cs', 'vim-plug'] } " omnisharp-vim dependency

" HTML, CSS, JavaScript, Typescript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'neoclide/jsonc.vim'
Plug 'othree/html5.vim'
Plug 'alvan/vim-closetag'
" Plug 'hail2u/vim-css3-syntax' " , { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
" Plug 'pangloss/vim-javascript', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'MaxMEllon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
" Plug 'jelera/vim-javascript-syntax', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
"Plug 'jaxbot/browserlink.vim'
Plug 'HerringtonDarkholme/yats.vim'
" Plug 'posva/vim-vue'
" Plug 'evanleck/vim-svelte', {'branch': 'main'}
" Plug 'leafOfTree/vim-svelte-plugin'
" Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'pantharshit00/vim-prisma'

" Go
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Python
" Plug 'tmhedberg/SimpylFold', { 'for' :['python', 'vim-plug'] }
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'vim-plug'] }
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }
"Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
"Plug 'plytophogy/vim-virtualenv', { 'for' :['python', 'vim-plug'] }
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Flutter架构
" Plug 'dart-lang/dart-vim-plugin'
" Plug 'f-person/pubspec-assist-nvim', { 'for' : ['pubspec.yaml'] }

" Swift
"Plug 'keith/swift.vim'
"Plug 'arzg/vim-swift'

" Markdown
" 用于通过网页打开markdown文件，使用命令：InstantMarkdownPreview
" 打开网页查看markdown文件
" 打开代理或者小飞机后不可用
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
" 一个很棒的自动表格创建器和格式化程序，允许您在键入时创建整洁的表格
" 按空格tm进入vim-table-mode 可以在markdown快速创建表格
" 有更多的快捷键可以查看wiki，如｜｜等
" https://github.com/dhruvasagar/vim-table-mode
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['text', 'markdown', 'vim-plug'] }
" 为markdown文件生成目录
" 生成目录命令:GenTocGFM
" 关闭自动更新markdown 目录，:UpdateToc 手动更新目录
" 去除目录:RemoveToc
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown', 'vim-plug'] }
" 用于markdown列表的生成，或者checkbox的生成
" https://github.com/dkarter/bullets.vim
Plug 'dkarter/bullets.vim'

" Other filetypes
" Plug 'jceb/vim-orgmode', {'for': ['vim-plug', 'org']}

" Editor Enhancement
"Plug 'Raimondi/delimitMate'
" Insert or delete brackets, parens, quotes in pair. 因为我的alt按键用软件映射了，所以可能有问题？
Plug 'jiangmiao/auto-pairs'
" 与视觉块类似，但该插件主要在正常模式下工作
Plug 'mg979/vim-visual-multi'
" 空格+cn快速注释
Plug 'tomtom/tcomment_vim' " in <space>cn to comment a line
" 光标下的单词反义次的循环切换 normal 模式下gs切换
Plug 'theniceboy/antovim' " gs to switch
"解决vim的括号 引号等快捷输入问题
Plug 'tpope/vim-surround' " type ysiw' to wrap the word with '' or type cs'` to change 'word' to `word`  ds' 删除词组两边的‘号
" 输入enter可以选择单词外的括号，再次输入则往外阔括号，backspace则往内扩
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip,it (ip it 针对html xml中的标签)
" 在visual 视觉模式下，按 a= 表示对象等于号后边的内容，按多一次则为下一个内容.如果是test: 'testvalue' 则按a:
Plug 'junegunn/vim-after-object' " da= to delete what's after =
" 用于文本对齐
Plug 'godlygeek/tabular' " ga, or :Tabularize <regex> to align
" 在插入模式下按 <C-G>c 切换临时软件大写锁定，或在正常模式下按 gC 切换稍微更永久的锁定。
Plug 'tpope/vim-capslock'	" Ctrl+G+c (insert) to toggle capslock ,或者normal模式下gC触发
" <leader><leader>w 表示为段开头的字符打上标签如abc等，如果要去到该字符串开头的词，则按该标签字符，或者<leader><leader>f  表示查找某个字母开头的词,然后给词打上标签a b c d 等，如果需要跳到该词，则按标签字母则可,<leader><leader>l 表示为行打上标签如abcd等，要跳转到该行则按上该标签字符
" <leader><leader>s表示双字母查找
Plug 'easymotion/vim-easymotion'

" Plug 'Konfekt/FastFold'
"Plug 'junegunn/vim-peekaboo'
"Plug 'wellle/context.vim'
" vim替换增强
Plug 'svermeulen/vim-subversive'
" 用于快速删除或者修改或者选择函数内的参数，快捷键 daa 删除参数 cka 修改参数 vka选择参数 vka会跳转到下一个参数 
Plug 'theniceboy/argtextobj.vim'
" 为了更方便，扩展 f、F、t 和 T 映射。 使得可以在按f跳到下一个查找到的字母中去
Plug 'rhysd/clever-f.vim'
" 编程时将多行变成单行，或者单行变成多行
Plug 'AndrewRadev/splitjoin.vim'
" 未明确使用方式
"Plug 'theniceboy/pair-maker.vim'
" 在visual模式中上下移动一行或者多行 ctrl+j ctrl+k
" 上下移动整行，上移一行，或者下移一行 c-j c-k
" visual 模式移动整块 c-j c-k 移动整块
Plug 'theniceboy/vim-move'
" Plug 'jeffkreeftmeijer/vim-numbertoggle'
" 编程的时候显示缩进线
Plug 'Yggdroot/indentLine'
" For general writing
" 用于专心工作，没啥用
" Plug 'junegunn/goyo.vim'
"Plug 'reedes/vim-wordy'
"Plug 'ron89/thesaurus_query.vim'

" Bookmarks
" Plug 'MattesGroeger/vim-bookmarks'

" Find & Replace
" 快捷键  <leader>ff 激活，修改查找内容及要查找的文件
Plug 'brooth/far.vim', { 'on': ['F', 'Far', 'Fardo'] }

" Documentation
"Plug 'KabbAmine/zeavim.vim' " <LEADER>z to find doc

" Mini Vim-APP
"Plug 'jceb/vim-orgmode'
"Plug 'mhinz/vim-startify'
" 通过模仿vscode的任务系统来处理构建/运行/测试/部署任务的通用方法,暂时不用
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/asyncrun.vim'

" Vim Applications
" 不怎么用  
" Plug 'itchyny/calendar.vim'

" Other visual enhancement
" 通过将不同层次的括号高亮为不同的颜色, 帮助你阅读世界上最复杂的代码
Plug 'luochen1990/rainbow'
" 标签页增强工具 不怎么好用
" Plug 'mg979/vim-xtabline'
" 为插件及vim增强图标字形
Plug 'ryanoasis/vim-devicons'
" 用于区别normal 插入 修改模式的光标竖线的表示方式
Plug 'wincent/terminus'

" Other useful utilities
" 在vim中通过SudaRead SudaWrite 来实现sudo重新打开或保存文件的功能，模仿 :w !sudo tee % 或者 :w !sudo tee % > /dev/null
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite
" Plug 'makerj/vim-pdf'
"Plug 'xolox/vim-session'
"Plug 'xolox/vim-misc' " vim-session dep

" Dependencies
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'kana/vim-textobj-user'
" Plug 'roxma/nvim-yarp'


"vim-xkbswitch用来在退出插入模式后自动让输入法变成英文，减少进入normal模式的不便，减少中文输入法切换回英文的不便
Plug 'lyokha/vim-xkbswitch'

" vim按键冲突检查 报错
" Plug 'lukhio/vim-mapping-conflicts'

call plug#end()

" experimental
" 延迟重绘
set lazyredraw
"set regexpengine=1


" ===
" === Dress up my vim
" ===
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
"set background=dark
"let ayucolor="mirage"
"let g:oceanic_next_terminal_bold = 1
"let g:oceanic_next_terminal_italic = 1
"let g:one_allow_italics = 1

"color dracula
"color one
" 设置vim的配色方案
color deus
"color gruvbox
"let ayucolor="light"
"color ayu
"color xcodelighthc
"set background=light
"set cursorcolumn

hi NonText ctermfg=gray guifg=grey10
"hi SpecialKey ctermfg=blue guifg=grey70

" ===================== Start of Plugin Settings =====================


" ===
" === eleline.vim
" ===
" 显示状态栏状态
"let g:airline_powerline_fonts = 1

" ==
" == GitGutter
" ==
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
" 折叠所有未更改的行
nnoremap <LEADER>gf :GitGutterFold<CR>
"备注这个要重新设置一个按键映射 H被我加快速度用了, 所以使用默认的<leader>hp
"nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>


" ===
" === coc.nvim
" ===
" coc的设置统一在~/.config/nvim/coc-settings.json
let g:coc_global_extensions = [
	\ 'coc-css',
	\ 'coc-diagnostic',
	\ 'coc-docker',
	\ 'coc-eslint',
	\ 'coc-explorer',
	\ 'coc-flutter-tools',
	\ 'coc-gitignore',
	\ 'coc-html',
	\ 'coc-import-cost',
	\ 'coc-jest',
	\ 'coc-json',
	\ 'coc-lists',
	\ 'coc-prettier',
	\ 'coc-prisma',
	\ 'coc-pyright',
	\ 'coc-python',
	\ 'coc-snippets',
	\ 'coc-sourcekit',
	\ 'coc-stylelint',
	\ 'coc-syntax',
	\ 'coc-tailwindcss',
	\ 'coc-tasks',
	\ 'coc-translator',
	\ 'coc-tslint-plugin',
	\ 'coc-tsserver',
	\ 'coc-vetur',
	\ 'coc-vimlsp',
	\ 'coc-yaml',
	\ 'coc-yank',
	\ 'https://github.com/rodrigore/coc-tailwind-intellisense']
" 无法安装，需要单独git下载后放到放coc/extensions/node_modules然后再重新启动nvim即可以安装
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
"使用tab用户触发完成，完成确认，代码段扩展
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ coc#refresh()
" 这里不知道ctrl p有没冲突
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 让enter按键自动选择snippets中第一个
if exists('*complete_info')
	inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
	inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
endif

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
" 必须要修改 跟macos切换输入法重叠
" inoremap <silent><expr> <c-space> coc#refresh()
" 在插入模式中ctrl o用于显示补全提示
inoremap <silent><expr> <c-o> coc#refresh()


" 显示函数和类型提示信息
function! Show_documentation()
	call CocActionAsync('highlight')
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction
" Use space+sd to show documentation in preview window.
"  查看函数或者类型的定义信息
nnoremap <LEADER>sd :call Show_documentation()<CR>
" set runtimepath^=~/.config/nvim/coc-extensions/coc-flutter-tools/
" set runtimepath^=~/.config/nvim/plugged/coc.nvim
" set runtimepath+=~/.config/nvim/plugged/vim-snippets
" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
" let $NVIM_COC_LOG_LEVEL = 'debug'
" let $NVIM_COC_LOG_FILE = '/Users/david/Desktop/log.txt'

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
" coc的命令集合，按需要选择
nnoremap <c-c> :CocCommand<CR>

" Text Objects
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Useful commands
"
" coc-yank
" 用于补全自己复制过的内容，等同于黏贴版，另外利用机器学习搜索上下稳，筛选出你最可能想写的代码，为你提供候选补全项
nnoremap <silent> <space>y :<C-u>CocList -A --normal yank<cr>
" 
" GoTo code navigation.
" 跳转到函数定义的位置
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gD :tab sp<CR><Plug>(coc-definition)
" coc跳转到类的定义
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" 跳转到引用
nmap <silent> gr <Plug>(coc-references)
" 重命名
nmap <leader>rn <Plug>(coc-rename)

" coc-explorer 文件浏览器快捷方式
nmap tt :CocCommand explorer<CR>

" coc-translator
" ts 翻译当前单词
" coc.setting中设置了"translator.engines"=["bing","youdao"],
nmap ts <Plug>(coc-translator-p)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>aw  <Plug>(coc-codeaction-selected)w
" coctodolist
" nnoremap <leader>tn :CocCommand todolist.create<CR>
" nnoremap <leader>tl :CocList todolist<CR>
" nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
"
" coc-snippets
"
" 这里似乎好多冲突
" 因为我改键了，所以不需要通过这种模式来选择，只需要用我改键后的alt hjkl
" 表示上下左右就可以选择了
" imap <C-l> <Plug>(coc-snippets-expand)
" vmap <C-j> <Plug>(coc-snippets-select)
" " 在插入模式下，在snippets中，可以通过ctrl e 和 ctrl n 前后选择要修改的参数 函数也支持这样操作
" let g:coc_snippet_next = '<c-e>'
" let g:coc_snippet_prev = '<c-n>'
" " 在插入模式下，在snippets中，可以通过ctrl j 和 ctrl k 前后选择要修改的参数（只适用于首行） 函数也支持这样操作
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
" imap <C-e> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'Glimmer Pan'
"let g:snips_author = 'David Chen'
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc


" ===
" === vim-instant-markdown
" ===
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 1
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1


" ===
" === vim-table-mode
" ===
" 按空格tm进入vim-table-mode 可以在markdown快速创建表格
" 有更多的快捷键可以查看wiki，如｜｜等
noremap <LEADER>tm :TableModeToggle<CR>
"let g:table_mode_disable_mappings = 1
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" === FZF
" ===
"将该目录添加到vim的运行时库runtimepath中，因为fzf是通过其他方式安装的，而非vim-plug安装
set rtp+=/usr/local/opt/fzf
"set rtp+=/home/david/.linuxbrew/opt/fzf
" 默认<leader>f为打开fzf，将其改为ctrl p  但<leader>f仍可以打开
nnoremap <C-p> :Leaderf file<CR>
" noremap <silent> <C-p> :Files<CR>
"noremap <C-p> :FZF<CR>
"查找打开过的文件
noremap <LEADER>mr :MRU<CR>
" noremap <LEADER>m :MRU<CR>
" noremap <silent> <C-m> :MRU<CR>
"使用ripgrep（rg命令）作为页面内容查询命令
noremap <silent> <C-f> :Rg<CR>
"查找执行过的命令
" noremap q; :History:<CR>
noremap <silent> <C-h> :History:<CR>
" 行查找模式
" 注意这里是大写L
"noremap <C-t> :BTags<CR>
" noremap <silent> <C-L> :Lines<CR>
noremap <LEADER>ml :Lines<CR>
noremap <silent> <C-b> :Buffers<CR>
"备注，这个按键要重新改键，因为我用了来表示句首句尾
"noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))

"ctrl+d查看在vim终端中打开的文档，选中确认则关闭
noremap <c-d> :BD<CR>

" :MRU  的实现函数
command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())
" 设置fzf弹出框尺寸大小
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" ===
" === Leaderf
" ===
" 浮窗模式开启
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
" 改按键
"let g:Lf_CommandMap = {
"\   '<C-k>': ['<C-u>'],
"\   '<C-j>': ['<C-e>'],
"\   '<C-]>': ['<C-v>'],
" ctrl+p 是预览文档，不用打开
"\   '<C-p>': ['<C-n>'],
"\}
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WildIgnore = {
        \ 'dir': ['.git', 'vendor', 'node_modules'],
        \ 'file': ['__vim_project_root', 'class']
        \}
let g:Lf_UseMemoryCache = 0
let g:Lf_UseCache = 0


" ===
" === CTRLP (Dependency for omnisharp)
" ===
"let g:ctrlp_map = ''
"let g:ctrlp_cmd = 'CtrlP'


" ===
" === vim-bookmarks
" ===
" let g:bookmark_no_default_key_mappings = 1
" nmap mt <Plug>BookmarkToggle
" nmap ma <Plug>BookmarkAnnotate
" nmap ml <Plug>BookmarkShowAll
" nmap mi <Plug>BookmarkNext
" nmap mn <Plug>BookmarkPrev
" nmap mC <Plug>BookmarkClear
" nmap mX <Plug>BookmarkClearAll
" nmap mu <Plug>BookmarkMoveUp
" nmap me <Plug>BookmarkMoveDown
" nmap <Leader>g <Plug>BookmarkMoveToLine
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_auto_save = 1
" let g:bookmark_highlight_lines = 1
" let g:bookmark_manage_per_buffer = 1
" let g:bookmark_save_per_working_dir = 1
" let g:bookmark_center = 1
" let g:bookmark_auto_close = 1
" let g:bookmark_location_list = 1


" ===
" === Undotree
" ===
" 重新映射 空格+u
noremap <LEADER>u :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
" undotree查看历史记录
	nmap <buffer> l <plug>UndotreeNextState
	nmap <buffer> h <plug>UndotreePreviousState
	nmap <buffer> L 5<plug>UndotreeNextState
	nmap <buffer> H 5<plug>UndotreePreviousState
endfunc


" ==
" == vim-multiple-cursor
" 多重光标选择
" ==
"let g:multi_cursor_use_default_mapping = 0
"let g:multi_cursor_start_word_key = '<c-k>'
"let g:multi_cursor_select_all_word_key = '<a-k>'
"let g:multi_cursor_start_key = 'g<c-k>'
"let g:multi_cursor_select_all_key = 'g<a-k>'
"let g:multi_cursor_next_key = '<c-k>'
"let g:multi_cursor_prev_key = '<c-p>'
"let g:multi_cursor_skip_key = '<C-s>'
"let g:multi_cursor_quit_key = '<Esc>'


" ===
" === vim-visual-multi
" ===
"
" 按ctrl+n 进入多选的可视化模式，按tab退出多选的可视化模式进入多选的normal，按i进入多选的编辑模式
"let g:VM_theme             = 'iceblue'
"let g:VM_default_mappings = 0
"let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_leader = '\\'                        "使用默认<Leader>键。
let g:VM_mouse_mappings = 0                   "禁用鼠标操作。
let g:VM_default_mappings = 0                 "取消默认按键映射。
let g:VM_maps                       = {}
"let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
"let g:VM_maps['i']                  = 'k'
"let g:VM_maps['I']                  = 'K'
let g:VM_maps['Find Under']         = '<c-n>'
let g:VM_maps['Find Subword Under'] = '<c-n>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
" let g:VM_maps['Skip Region']        = 'q'
let g:VM_maps["Undo"]               = 'u'
let g:VM_maps["Redo"]               = '<C-r>'
let g:VM_maps['Select All']         = '\va'   "进入多光标模式并选中所有同光标下的字符串。
" let g:VM_maps['Add Cursor Up']      = '<C-k>'
" let g:VM_maps['Add Cursor Down']    = '<C-j>'
"let g:VM_maps['Select h']           = '<C-h>'
" let g:VM_maps['Select l']           = '<C-l>'

" ===
" === Far.vim
" ===
" <leader>ff 激活执行Far命令
" :Fardo 执行替换，等同于s
" 使用过一次Far命令后才能使用:Farr 或者:help far.vim
" 原因可能是由于没有自动载入的问题导致的
" i 选中需要修改替换的项目
" x 取消选中修改替换的项目
" s 执行修改替换
" u 取消刚才的替换
" :q 退出
noremap <LEADER>ff :F xx %<left><left>
"  允许使用u撤销
let g:far#enable_undo=1
" 将Farundo操作替换为u，即撤销替换
let g:far#mapping = {
		\ "replace_undo" : ["u"],
		\ }


" ===
" === vim-calc
" ===
"noremap <LEADER>a :call Calc()<CR>
" Testing
"if !empty(glob('~/Github/vim-calc/vim-calc.vim'))
"source ~/Github/vim-calc/vim-calc.vim
"endif


" ===
" === Bullets.vim
" ===
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
			\ 'markdown',
			\ 'text',
			\ 'gitcommit',
			\ 'scratch'
			\]


" ===
" === Vista.vim
" ===
" Taglist 编程标签相关
" <LEADER>v 打开所有函数与变量列表
" ctrl-t 通过coc打开函数与变量列表并显示内容
noremap <LEADER>v :Vista!!<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
" function! NearestMethodOrFunction() abort
" 	return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" 设置scrollstatus栏的字符大小为15
"let g:scrollstatus_size = 15

" ===
" === fzf-gitignore
" ===
noremap <LEADER>gi :FzfGitignore<CR>


" ===
" === Ultisnips
" ===
" 此段为原作者注释
" 已经切换到coc-snippets coc-setting中可以看到相关设置
" let g:tex_flavor = "latex"
" inoremap <c-n> <nop>
" let g:UltiSnipsExpandTrigger="<c-e>"
" let g:UltiSnipsJumpForwardTrigger="<c-e>"
" let g:UltiSnipsJumpBackwardTrigger="<c-n>"
" let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']
" silent! au BufEnter,BufRead,BufNewFile * silent! unmap <c-r>
" " Solve extreme insert-mode lag on macOS (by disabling autotrigger)
" augroup ultisnips_no_auto_expansion
"     au!
"     au VimEnter * au! UltiSnips_AutoTrigger
" augroup END



" ===
" === vimtex
" ===
"let g:vimtex_view_method = ''
let g:vimtex_view_general_viewer = 'llpp'
let g:vimtex_mappings_enabled = 0
let g:vimtex_text_obj_enabled = 0
let g:vimtex_motion_enabled = 0
let maplocalleader=' '


" ===
" === vim-calendar
" ===
"noremap \c :Calendar -position=here<CR>
" noremap \\ :Calendar -view=clock -position=here<CR>
" 太少用了配置被我注释
" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1
" augroup calendar-mappings
"   autocmd!
"   " diamond cursor
"   autocmd FileType calendar nmap <buffer> u <Plug>(calendar_up)
"   autocmd FileType calendar nmap <buffer> n <Plug>(calendar_left)
"   autocmd FileType calendar nmap <buffer> e <Plug>(calendar_down)
"   autocmd FileType calendar nmap <buffer> i <Plug>(calendar_right)
"   autocmd FileType calendar nmap <buffer> <c-u> <Plug>(calendar_move_up)
"   autocmd FileType calendar nmap <buffer> <c-n> <Plug>(calendar_move_left)
"   autocmd FileType calendar nmap <buffer> <c-e> <Plug>(calendar_move_down)
"   autocmd FileType calendar nmap <buffer> <c-i> <Plug>(calendar_move_right)
"   autocmd FileType calendar nmap <buffer> k <Plug>(calendar_start_insert)
"   autocmd FileType calendar nmap <buffer> K <Plug>(calendar_start_insert_head)
"   " unmap <C-n>, <C-p> for other plugins
"   autocmd FileType calendar nunmap <buffer> <C-n>
"   autocmd FileType calendar nunmap <buffer> <C-p>
" augroup END


" ===
" === vim-go
" ===
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0


" ===
" === AutoFormat
" ===
augroup autoformat_settings
	" autocmd FileType bzl AutoFormatBuffer buildifier
	" autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
	" autocmd FileType dart AutoFormatBuffer dartfmt
	" autocmd FileType go AutoFormatBuffer gofmt
	" autocmd FileType gn AutoFormatBuffer gn
	" autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
	autocmd FileType java AutoFormatBuffer google-java-format
	" autocmd FileType python AutoFormatBuffer yapf
	" Alternative: autocmd FileType python AutoFormatBuffer autopep8
	" autocmd FileType rust AutoFormatBuffer rustfmt
	" autocmd FileType vue AutoFormatBuffer prettier
augroup END


" ===
" === OmniSharp
" ===
"let g:OmniSharp_typeLookupInPreview = 1
"let g:omnicomplete_fetch_full_documentation = 1
"
"let g:OmniSharp_server_use_mono = 1
"let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_highlight_types = 2
"let g:OmniSharp_selector_ui = 'ctrlp'
"
"autocmd Filetype cs nnoremap <buffer> gd :OmniSharpPreviewDefinition<CR>
"autocmd Filetype cs nnoremap <buffer> gr :OmniSharpFindUsages<CR>
"autocmd Filetype cs nnoremap <buffer> gy :OmniSharpTypeLookup<CR>
"autocmd Filetype cs nnoremap <buffer> ga :OmniSharpGetCodeActions<CR>
"autocmd Filetype cs nnoremap <buffer> <LEADER>rn :OmniSharpRename<CR><C-N>:res +5<CR>
"
"sign define OmniSharpCodeActions text=💡
"
"augroup OSCountCodeActions
"	autocmd!
"	autocmd FileType cs set signcolumn=yes
"	autocmd CursorHold *.cs call OSCountCodeActions()
"augroup END
"
"function! OSCountCodeActions() abort
"	if bufname('%') ==# '' || OmniSharp#FugitiveCheck() | return | endif
"	if !OmniSharp#IsServerRunning() | return | endif
"	let opts = {
"				\ 'CallbackCount': function('s:CBReturnCount'),
"				\ 'CallbackCleanup': {-> execute('sign unplace 99')}
"				\}
"	call OmniSharp#CountCodeActions(opts)
"endfunction
"
"function! s:CBReturnCount(count) abort
"	if a:count
"		let l = getpos('.')[1]
"		let f = expand('%:p')
"		execute ':sign place 99 line='.l.' name=OmniSharpCodeActions file='.f
"	endif
"endfunction
"

" ===
" === vim-easymotion
" ===
" let g:EasyMotion_do_mapping = 0
" 是否在激活时增加阴影
let g:EasyMotion_do_shade = 0
" 智能大小写
let g:EasyMotion_smartcase = 1
" map ' <Plug>(easymotion-overwin-f2)
" nmap ' <Plug>(easymotion-overwin-f2)
"map E <Plug>(easymotion-j)
"map U <Plug>(easymotion-k)
"nmap f <Plug>(easymotion-overwin-f)
"map \; <Plug>(easymotion-prefix)
"nmap ' <Plug>(easymotion-overwin-f2)
map <LEADER><LEADER>l <Plug>(easymotion-bd-jk)
nmap <LEADER><LEADER>l <Plug>(easymotion-overwin-line)
" 双字母支持  
nmap <LEADER><LEADER>s <Plug>(easymotion-s2)
"map 'l <Plug>(easymotion-bd-jk)
"nmap 'l <Plug>(easymotion-overwin-line)
"map  'w <Plug>(easymotion-bd-w)
"nmap 'w <Plug>(easymotion-overwin-w)


" ===
" === goyo
" ===
" map <LEADER>gy :Goyo<CR>


" ===
" === jsx
" ===
let g:vim_jsx_pretty_colorful_config = 1


" ===
" === fastfold
" ===
" nmap zuz <Plug>(FastFoldUpdate)
" let g:fastfold_savehook = 1
" let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" let g:fastfold_fold_movement_commands = [']z', '[z', 'ze', 'zu']
" let g:markdown_folding = 1
" let g:tex_fold_enabled = 1
" let g:vimsyn_folding = 'af'
" let g:xml_syntax_folding = 1
" let g:javaScript_fold = 1
" let g:sh_fold_enabled= 7
" let g:ruby_fold = 1
" let g:perl_fold = 1
" let g:perl_fold_blocks = 1
" let g:r_syntax_folding = 1
" let g:rust_fold = 1
" let g:php_folding = 1


" ===
" === tabular
" ===
vmap ga :Tabularize /


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === rainbow
" ===
let g:rainbow_active = 1

" 效果不怎么好使
" " ===
" " === xtabline
" " ===
" let g:xtabline_settings = {}
" let g:xtabline_settings.enable_mappings = 0
" let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
" let g:xtabline_settings.enable_persistance = 0
" let g:xtabline_settings.last_open_first = 1
" " noremap to :XTabCycleMode<CR>
" noremap to :XTabMode<CR>
" noremap \p :echo expand('%:p')<CR>


" ===
" === vim-session
" ===
"let g:session_directory = $HOME."/.config/nvim/tmp/sessions"
"let g:session_autosave = 'no'
"let g:session_autoload = 'no'
"let g:session_command_aliases = 1
"set sessionoptions-=buffers
"set sessionoptions-=options
" 备注sl已经被使用
"noremap sl :OpenSession<CR>
"noremap sS :SaveSession<CR>
"noremap ss :SaveSession 
"noremap sc :SaveSession<CR>:CloseSession<CR>:q<CR>
"noremap so :OpenSession default<CR>
"noremap sD :DeleteSession<CR>
""noremap sA :AppendTabSession<CR>


" ===
" === context.vim
" ===
"let g:context_add_mappings = 0
"noremap <leader>ct :ContextToggle<CR>


" ===
" === suda.vim
" ===
" 自动地识别权限不足的文件，并且通过suda打开它
let g:suda_smart_edit = 1
" cnoreabbrev sudowrite w suda://%
" cnoreabbrev sw w suda://%


" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
	" has to be a function to avoid the extra space fzf#run insers otherwise
	execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
			\   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
			\   'down': 20,
			\   'sink': function('<sid>read_template_into_buffer')
			\ })
" noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ===
" === reply.vim
" ===
"noremap <LEADER>rp :w<CR>:Repl<CR><C-\><C-N><C-w><C-h>
"noremap <LEADER>rs :ReplSend<CR><C-w><C-l>a<CR><C-\><C-N><C-w><C-h>
"noremap <LEADER>rt :ReplStop<CR>


" ===
" === vim-markdown-toc
" ===
" 生成目录命令:GenTocGFM
" 关闭自动更新markdown 目录，:UpdateToc 手动更新目录
" 去除目录:RemoveToc
let g:vmt_auto_update_on_save = 0
" 关闭toc目录自动标饰标志，会导致:UpdateToc 和 :RemoveToc
" 无法使用,需要手动删除目录内容并重新执行生成目录命令
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
" toc的标识符设置，以下为默认值
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
"在 Ranger 中按 yw 将发出 Ranger 的 cwd 到 Neovim 的，gw 将跳转到 Neovim 的 cwd
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ===
" === vim-subversive
" ===
" 使用方法，先复制到想要替换的内容，然后定位到想要替换的文字上，执行siw替换当前内容
" 定位到多行上，执行si，替换多行内容
" 定位到执行行上，执行sl，替换当前行内容
" 定位到句子中部，执行se，替换当前位置到句末内容
" 定位到该段，执行sip替换整段内容
nmap s <plug>(SubversiveSubstitute)
xmap s <plug>(SubversiveSubstitute)
nmap sol <plug>(SubversiveSubstituteLine)
nmap se <plug>(SubversiveSubstituteToEndOfLine)


" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl


" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['__vim_project_root', '.git/']
let g:rooter_silent_chdir = 1
"没有项目的项目，设置根目录为home,即/Users/glimmer
" let g:rooter_change_directory_for_non_project_files = 'home'

" ===
" === AsyncRun
" ===
" noremap gp :AsyncRun git push<CR>


" ===
" === AsyncTasks
" ===
" let g:asyncrun_open = 6


" " ===
" " === dart-vim-plugin
" " ===
" let g:dart_style_guide = 2
" let g:dart_format_on_save = 1
" let g:dartfmt_options = ["-l 100"]


" ===
" === tcomment_vim
" ===
" 这个映射作用是什么
"nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
" 注释行
nmap <LEADER>cn g>c
" visual 视图模式注释
vmap <LEADER>cn g>
" 取消注释
nmap <LEADER>cu g<c
vmap <LEADER>cu g<


" ===
" === vim-move
" ===
" 控制键修改为ctrl
let g:move_key_modifier = 'C'


" ===
" === any-jump
" ===
" vim 变成ide，用于查找类型定义 声明等 ，编程相关
" 取消默认的<leader>j any-jump映射键
let g:any_jump_disable_default_keybindings = 1
nnoremap <LEADER>jj :AnyJump<CR>
" Visual mode: jump to selected text in visual mode
xnoremap <leader>jj :AnyJumpVisual<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


" ===
" === typescript-vim
" ===
let g:typescript_ignore_browserwords = 1


" ===
" === Agit
" ===
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1


" ===
" === nvim-treesitter
" ===
" nvim-treesitter 设置语法高亮显示，设置那些语言需要该插件支持
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"typescript", "dart", "java"},     -- one of "all", "language", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF


" ===
" === lazygit.nvim
" git插件暂时注释，避免c-g会导致冲突
" ===
" noremap <c-g> :LazyGit<CR>
" let g:lazygit_floating_window_winblend = 0 " transparency of floating window
" let g:lazygit_floating_window_scaling_factor = 1.0 " scaling factor for floating window
" let g:lazygit_floating_window_corner_chars = ['╭', '╮', '╰', '╯'] " customize lazygit popup window corner characters
" let g:lazygit_use_neovim_remote = 1 " for neovim-remote support


"lyokha/vim-xkbswitch
"
let g:XkbSwitchEnabled = 1

" ===================== End of Plugin Settings =====================

" ===
" === Terminal Colors
" ===

let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" ===
" === Necessary Commands to Execute
" ===


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
	exec "e ~/.config/nvim/_machine_specific.vim"
endif


