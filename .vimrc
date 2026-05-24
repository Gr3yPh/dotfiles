" --- 缩进设置 ---
set tabstop=4        " 一个 Tab 显示为 4 个空格的宽度
set softtabstop=4    " 在编辑模式下按退格键时，退格 4 个空格
set shiftwidth=4     " 每一级自动缩进的空格数
set expandtab        " 把输入的 Tab 自动转换成空格（推荐，防止跨平台排版错乱）

" --- 行号设置 ---
set number           " 显示绝对行号（配合相对行号，当前行会显示真实行号）
set relativenumber   " 开启相对行号

syntax on

" --- 自动缩进 ---
set autoindent    " 开启自动缩进（换行时自动对齐上一行）
set cindent   " 开启智能缩进（识别 C/C++、Java、Python 等语言的语法结构自动缩进）
filetype plugin indent on

" --- 现代 IDE 级别的括号/引号体验 ---

" 1. 自动补全左括号，但如果紧接着输入右括号，则直接跳出（不重复输入）
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

" 智能跳出右括号/引号
inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ')' ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == ']' ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == '}' ? "\<Right>" : "}"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "'"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : "\""

" 2. 核心痛点：在花括号内按回车，自动实现 IDE 格式化换行
inoremap <expr> <CR> getline('.')[col('.')-2:col('.')-1] == '{}' ? "\<CR>\<ESC>O" : "\<CR>"
