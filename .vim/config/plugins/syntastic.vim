let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_perl_checkers = ['perl -c', 'perlcritic']
let g:syntastic_perl_perlcritic_thres = 3
