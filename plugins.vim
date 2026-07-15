" Autoistall Vim-Plug
" if empty(glob('~/.vim/autoload/plug.vim'))
"   silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

"=====================================================
" Vim-Plug settings
"=====================================================
" let g:plug_window='tabnew'
let g:plug_window='enew'
call plug#begin('~/.vim/plugged')

" COMMON
Plug 'scrooloose/nerdtree'
" Plug 'scrooloose/nerdtree', {'on': ['NERDTreeToggle', 'NERDTreeFind']}
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
Plug 'terryma/vim-multiple-cursors'
Plug 'thinca/vim-quickrun'
Plug 'neomake/neomake'                "Syntastic alternative
" Plug 'tpope/vim-eunuch' " Vim sugar for the UNIX shell commands that need it the most.
Plug 'tpope/vim-fugitive' " Git wrapper
" Plug 'w0rp/ale'                "Syntastic alternative
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
Plug 'mhinz/vim-startify'             " Nice start screen
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'justinmk/vim-sneak' " motions
" Plug 'junegunn/vim-easy-align'
Plug 'ctrlpvim/ctrlp.vim'
" Plug 'junegunn/vim-peekaboo'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'edkolev/tmuxline.vim'
" PYTHON
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
" HTML
Plug 'othree/html5.vim', { 'for': ['html', 'htmldjango'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'htmldjango'] }
" SYNTAX
Plug 'chr4/nginx.vim', {'for': 'nginx'}
Plug 'dzeban/vim-log-syntax', { 'for': 'log' }
Plug 'pearofducks/ansible-vim'
" MISC
" Plug 'junegunn/goyo.vim', { 'on': 'Goyo' } " Distraction-free writing in Vim
Plug 'tpope/vim-unimpaired'
" JavaScript
Plug 'yuezk/vim-js'

" GO
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }


call plug#end()

let SELF_DIR = expand("<sfile>:p:h")

" NerdTreee
" ширина окна с деревом файлов
let NERDTreeWinSize=40
" автоматически обновлять буфер после переименовывания файла
let NERDTreeAutoDeleteBuffer = 1
" Disable bookmarks label, and hint about '?'
let NERDTreeMinimalUI=1
"игноррируемые файлы с расширениями
let NERDTreeIgnore=['^\.git$', '\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$']
" показывать скрытые файлы
let NERDTreeShowHidden=1
" Закрывать после открытия файла
let NERDTreeQuitOnOpen=1
" to make the current directory match the root of the displayed tree
let g:NERDTreeChDirMode=2
" закрываем вместе с последним окном
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nmap <C-\> :NERDTreeFind<CR>
function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    else
        :NERDTreeFind
    endif
endfunction

nnoremap <C-\> :call MyNerdToggle()<CR>

" nmap <silent> <C-D> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw = 1

" TagBar
let g:tagbar_autofocus = 1 " автофокус на Tagbar при открытии
" сортировать в том порядке, в котором тег появляется в коде, а не по имени
let g:tagbar_sort = 0
" If you set this option the Tagbar window will automatically close when you jump to a tag.
let g:tagbar_autoclose = 1
" Setting this option will result in Tagbar omitting the short help at the
" top of the window and the blank lines in between top-level scopes in order to
" save screen real estate.
let g:tagbar_compact = 1


" QuickRun
let g:quickrun_config = {
            \   '*' : {
            \       'outputter/buffer/close_on_empty' : 1,
            \       'outputter/buffer/opener' : ':rightbelow 70vsplit',
            \   },
            \   'yaml': {
            \      'command': 'ansible-playbook'
            \   }
            \}
map <silent> <leader>r  :QuickRun<CR>


" Srartify
map <silent> <leader>s  :Startify<CR>
let g:startify_bookmarks = ['~/Makefile', '~/.bashrc', '~/.vimrc', '~/.vim/plugins.vim', '~/scripts/']
let g:startify_change_to_vcs_root = 1
let g:startify_custom_header = []
let g:startify_list_order = [
            \ ['   Recent Files'],
            \ 'files',
            \ ['   Sessions'],
            \ 'sessions',
            \ ['   Bookmarks'],
            \ 'bookmarks',
            \ ]
let g:startify_files_number           = 100
let g:startify_enable_special         = 0
let g:startify_relative_path          = 1
let g:startify_change_to_dir          = 1
let g:startify_session_autoload       = 1
let g:startify_session_persistence    = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_dir = '~/.vim/session'

" Vim-Commentary
autocmd FileType nginx setlocal commentstring=#\ %s
autocmd FileType php setlocal commentstring=//\ %s
autocmd FileType htmldjango setlocal commentstring={#\ %s\ #}

" SuperTab
" let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

"" CTRLP
" По умолчанию, CtrlP ищет файлы по их полному пути, что мне показалось странным, поскольку на запрос "repo", имея следующую структуру файлов:
" project/src/Repository/Repository.php
" project/src/Repository/Foo.php
" CtrlP может придать больший вес файлу Foo.php. К счастью, CtrlP, как и многие другие плагины для vim'a, имеет гибкую настройку. Для решения проблемы нужно прописать
let g:ctrlp_by_filename = 1
" откуда начинать поиск. w - ближайшая директория, которая содержит признаки наличия CVS (.git, .svn). r - текущая директория (pwd).
let g:ctrlp_working_path_mode = 'wr'
let g:ctrlp_map = '<c-p>'          " открываем нажатием Ctrl+P
let g:ctrlp_cmd = 'CtrlPBuffer'    " показывать список буферов по-умолчанию

" AIRLINE
set laststatus=2
set linespace=0
set noshowmode
let g:airline_theme = 'jellybeans'
" Set custom left separator
" let g:airline_left_sep = '▶'
let g:airline_left_sep = '☰'
" Set custom right separator
" let g:airline_right_sep = '◀'
let g:airline_right_sep = '☰'
" Enable airline for tab-bar
let g:airline#extensions#tabline#enabled = 1
" Don't display buffers in tab-bar with single tab
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#keymap#enabled = 0
" Display only filename in tab
let g:airline#extensions#tabline#fnamemod = ':t'
" Hide labels for tabs/buffers
let airline#extensions#tabline#tabs_label = ''
let airline#extensions#tabline#show_splits = 0
" Don't display encoding
let g:airline_section_y = ''
" Don't display filetype
let g:airline_section_x = ''
let g:airline#extensions#tabline#left_sep = '▶'
let g:airline#extensions#tabline#left_alt_sep = ''
" let g:airline#extensions#tabline#left_alt_sep = '☰'
" если файл с уникальным именем - показывается только имя, если встречается файл с таким же именем, отображается также и директория
let g:airline#extensions#tabline#formatter = 'unique_tail'
" убираем "X" для закрытия вкладки мышью (мышью!?)
let g:airline#extensions#tabline#show_close_button = 0
" отключаем tagbar
" let g:airline#extensions#tagbar#enabled = 0
" показывать номер вкладки
let g:airline#extensions#tabline#show_tab_nr = 1
" показывать только номер вкладки
let g:airline#extensions#tabline#tab_nr_type = 1
" symbols
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'

" PHP
" PHP-DOCUMENTOR
" au FileType php nnoremap <leader><leader>d :call PhpDoc()<CR>
" let g:pdv_cfg_Author = 'Dalay <dalay@pythonway.ru>'
" let g:pdv_cfg_ClassTags = ["author"]

" ANSIBLE
" let g:ansible_options = {'ignore_blank_lines': 0}
au BufRead,BufNewFile inventory* set filetype=ansible_hosts

" PYTHON
" JEDI-VIM
let g:jedi#completions_enabled = 0
let g:jedi#rename_command = ''
let g:jedi#goto_stubs_command = ''
" Jedi automatically starts the completion, if you type a dot, e.g. str., if you don't want this:
let g:jedi#popup_on_dot = 0
" Jedi selects the first line of the completion menu: for a better typing-flow and usually saves one keypress.
let g:jedi#popup_select_first = 0
" make jedi-vim use tabs when going to a definition
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = 0
" JEDI NEW
" let g:jedi#use_tabs_not_buffers = 0  " use buffers instead of tabs
" let g:jedi#show_call_signatures = "1"
" let g:jedi#documentation_command = "K"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#environment_path = ".venv"
let g:jedi#goto_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>gd"
let g:jedi#goto_assignments_command = "<leader>ga"
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "<leader><leader>r"

" AUTOFORMAT
let g_autoformat_verbosemode=1
let g:formatters_javascript = []

let g:formatdef_json_with_python = "'python -m json.tool --no-ensure-ascii --indent 2'"
let g:formatters_json = ['json_with_python']

let g:formatdef_black = '"black --skip-string-normalization -q ".(&textwidth ? "-l".&textwidth : "")." -"'
let g:formatdef_autopep8 = '"autopep8 -".(g:DoesRangeEqualBuffer(a:firstline, a:lastline) ? " --range ".a:firstline." ".a:lastline : "")." ".(&textwidth ? "--max-line-length=".&textwidth : "")'

" let g:formatdef_xml_with_python = "'import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())'"
" let g:formatters_xml = ['xml_with_python']

" VIM-PEEKABOO
let g:peekaboo_compact = 1

"  VIM-EASY-ALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" VIM-SNEAK
" let g:sneak#label = 1
let g:sneak#streak = 1
map <leader>f <Plug>Sneak_s
map <leader>b <Plug>Sneak_S

" 0 : Always case-sensitive
" 1 : Case sensitivity is determined by 'ignorecase' and 'smartcase'.
let g:sneak#use_ic_scs = 1

" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map f <Plug>Sneak_s
" map F <Plug>Sneak_S
" map f <Plug>Sneak_f
" map F <Plug>Sneak_F
" map t <Plug>Sneak_t
" map T <Plug>Sneak_T

"EMMET
let g:user_emmet_settings = {
            \  'php' : {
            \    'extends' : 'tpl.php',
            \    'filters' : 'c',
            \  },
            \  'python' : {
            \    'extends' : 'html',
            \  },
            \}

"GOYO
" let g:goyo_width = 100
" let g:goyo_height = 90
" let g:goyo_linenr  "(default: 0)
" let g:AutoPairsShortcutFastWrap = '<C-a>'
"


" VIM-GO
" disable all linters as that is taken care of by coc.nvim
" let g:go_diagnostics_enabled = 0
" let g:go_metalinter_enabled = []
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_generate_tags = 1
" don't jump to errors after metalinter is invoked
" let g:go_jump_to_error = 0
" run go imports on file save
" let g:go_fmt_command = "goimports"
" automatically highlight variable your cursor is on
" let g:go_auto_sameids = 0

" Импортируем настройки ALE
" source $HOME/.vim/misc/ale.vim
" exec 'source' . SELF_DIR . '/misc/ale.vim'
" Импортируем настройки NEOMAKE
" source $HOME/.vim/misc/neomake.vim
exec 'source' . SELF_DIR . '/misc/neomake.vim'
