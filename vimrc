colorscheme molokai
syntax on
set number
filetype plugin indent on

" Sets .netrwhist file to zero so it doesn't track 
" modified directory history
let g:netrw_dirhistmax = 0

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
