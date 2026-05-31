set tabstop=4        
set softtabstop=4   
set shiftwidth=4    
set expandtab       

set number          
set relativenumber 

syntax on

set autoindent   
set cindent  
filetype plugin indent on

inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ')' ? "\<Right>" : ")"
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == ']' ? "\<Right>" : "]"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == '}' ? "\<Right>" : "}"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "'"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == '"' ? "\<Right>" : "\""

inoremap <expr> <CR> getline('.')[col('.')-2:col('.')-1] == '{}' ? "\<CR>\<ESC>O" : "\<CR>"

noremap <F3> :Autoformat<CR>

nnoremap <F6> :below terminal<CR>
