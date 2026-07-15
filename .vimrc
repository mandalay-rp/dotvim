" Включить подсветку синтаксиса и задаем цветовую схему по-умолчанию
syntax on
colorscheme jellybeans
set background=dark
" Включаем несовместимость настроек с Vi
set nocompatible

" enable all Python syntax highlighting features
let python_highlight_all = 1

" Use 256 colors in vim 
" some plugins not work without it 
set t_Co=256
" Кодировка текста по умолчанию utf8
set termencoding=utf8
set fileencodings=utf-8,cp1251,koi8-r,cp866

"  Показывать номера строк
set number

" Поиск в процессе набора
set incsearch

" Подсвечивание результатов поиска
set hlsearch

" умная зависимость от регистра. Детали `:h smartcase`
set ignorecase
set smartcase

" автоматически обновлять файл при его изменении
set autoread

" Показывать положение курсора всё время.
set ruler

" Показывать незавершённые команды в статусбаре
set showcmd

"=============НАСТРОЙКИ СВОРАЧИВАНИЯ БЛОКОВ КОДА (фолдинг)=============
" set foldenable " отклключить фолдинг по умолчанию
" set foldmethod=syntax " определять блоки на основе синтаксиса файла
" set foldmethod=indent " определять блоки на основе отступов
" set foldnestmax=3       "deepest fold is 3 levels
" set foldcolumn=10 " показать полосу для управления сворачиванием
" set foldlevel=1 " Первый уровень вложенности открыт, остальные закрыты
" set foldopen=all " автоматическое открытие сверток при заходе в них

" Выключаем звуковое оповещение о достижении конца буффера, невозможности действия и т.д.
set noerrorbells visualbell t_vb=

" Сделать строку команд высотой в одну строку
set ch=1

" Включить автоотступы
set autoindent

" Размер табуляции по умолчанию
set shiftwidth=4
set softtabstop=4
set tabstop=4
" Преобразование Таба в пробелы
set expandtab

" Формат строки состояния. Альтернативные варианты настройки `:h statusline`
" set laststatus=2
" set statusline=
" Broken down into easily includeable segments
" set statusline+=%<%f\ " Filename
" set statusline+=%w%h%m%r " Options
" set statusline+=\ [%{&ff}/%Y] " filetype
" set statusline+=\ [%{getcwd()}] " current dir
" set statusline+=[%{FugitiveStatusline()}]

" Включаем "умные" отступы, например, авто отступ после `{`
set smartindent

" Отображение парных символов
set showmatch

" Навигация с учетом русских символов, учитывается командами следующее/предыдущее слово и т.п.
set iskeyword=@,48-57,_,-,192-255

" Подсвечивать линию текста, на которой находится курсор
set cursorline

" Увеличение размера истории
set history=200

" Дополнительная информация в строке состояния
set wildmenu
" set wildmode=list,full

" Настройка отображения специальных символов
set list listchars=tab:→\ ,trail:·

"  при переходе за границу в 80 символов в PHP/Python/js/ подсвечиваем на темном фоне текст
 augroup vimrc_autocmds
     autocmd!
     autocmd FileType python,javascript,php highlight Excess ctermbg=DarkGrey guibg=Black
     autocmd FileType python,javascript,php match Excess /\%80v.*/
 augroup END

" Spell-Checker
set spelllang=ru
highlight clear SpellBad
highlight SpellBad ctermfg=Red
highlight clear SpellCap
highlight SpellCap ctermfg=Blue
highlight clear SpellLocal
highlight SpellLocal ctermfg=Green
" Check on write for a text
" autocmd BufWritePost *.txt :setlocal spell

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
" highlight lCursor guifg=NONE guibg=Cyan

" Автоматически перечитывать конфигурацию VIM после сохранения
autocmd! bufwritepost .vimrc,plugins.vim source %

set scrolloff=3     " keep 3 lines when scrolling

" Omnicomplete
set completeopt-=preview
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete


" Включаем перенос строк (set nowrap отключает перенос строк)
set wrap
" Перенос строк по словам, а не по буквам
set linebreak

" Шаблоны для разных типов файлов
autocmd BufNewFile  *.py   0r ~/.vim/templates/python3 | 4
autocmd BufNewFile  *.php     0r ~/.vim/templates/php | 3

" Переход в папку файла
set browsedir=current

" Фикс для использования русской раскладки в командном режиме
set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

" При редактировании файла всегда переходить на последнюю известную
"позицию курсора. Если позиция ошибочная - не переходим.
autocmd BufReadPost *
 \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" обнуление задержки для клавиши Esc
set ttimeout ttimeoutlen=0 notimeout

" например, при переходе к тегу, vim может ругаться, что текущий буфер не сохранен, hidden решает эту проблему
set hidden

" nice wrapping for long lines with respect of
" starging indent
" set breakindent

" отключение перерисовки при выполнении макросов, повышает производительность
set lazyredraw

" YAML filetype
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
" HTMLDJANGO filetype
autocmd BufNewFile,BufRead *.html call DetectTemplate()
fun! DetectTemplate()
  let n = 1
  while n < line("$")
    if getline(n) =~ '{%' || getline(n) =~ '{{'
      set ft=htmldjango
      return
    endif
    let n = n + 1
  endwhile
  set ft=html "default html
endfun
" Less compile (with lessc)
autocmd FileWritePost,BufWritePost *.less :call LessCSSCompile()
function! LessCSSCompile()
  let cwd = expand('<afile>:p:h')
  let name = expand('<afile>:t:r')
  if (executable('lessc'))
    cal system('lessc '.cwd.'/'.name.'.less > '.cwd.'/'.name.'.css &')
  elseif (executable('lesscpy'))
    cal system('lesscpy '.cwd.'/'.name.'.less > '.cwd.'/'.name.'.css &')
  endif
endfunction

" Включаем проверку правописания при сохранении текстового файла.
" au BufWrite *.txt set spell spelllang=ru

" Автоматически включаем режим ввода, если файл пуст. Функция описана в functions.vim
" au VimEnter * call InsertIfEmpty()

" KEYMAPS
nnoremap Q <Nop>
" set leaser key
let mapleader=","
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
" Открыть файл в Fierefox.
" nnoremap <C-F12> :exe ':silent !firefox %'<CR>
nnoremap <F12>f :exe ':silent !firefox %:p &'<CR>
" Открыть файл в Chromium
nnoremap <F12>c :exe ':silent !chromium %:p &'<CR>
" nnoremap <leader><F5> :update<Bar>silent !xdg-open %:p &<CR>
" nnoremap <leader><F8> :silent !xdg-open <cfile> &<CR>
" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" убираем выделение найденного по нажатию на пробел.
nnoremap <silent> <Space> :nohl<Bar>:echo<CR>
" Map ctrl-movement keys to window switching
" map <C-k> <C-w><Up>
" map <C-j> <C-w><Down>
" map <C-l> <C-w><Right>
" map <C-h> <C-w><Left>
" Allow to copy/paste between VIM instances
" "copy the current visual selection to /tmp/.vim_buffer
vmap <Leader>y :w! /tmp/.vim_buffer<CR>
" "copy the current line to the buffer file if no visual selection
nmap <Leader>y :.w! /tmp/.vim_buffer<CR>
" "paste the contents of the buffer file
nmap <Leader>p :r /tmp/.vim_buffer<CR>
" move among buffers with gb and gB, like tab gt and gT
map gb :bnext<CR>
map gB :bprev<CR>
" Новая вкладка
nmap <leader>t :tabnew<CR>:Startify<CR>
" Закрыть вкладку
nmap <C-x> :tabclose<CR>
" This will remap the "+y (copy) and "+p (paste) commands to use xclip.
" vmap "+y :!xclip -f -sel clip<CR>
" map "+p :r!xclip -o -sel clip<CR>
" Открыть окно с терминалом
nmap <leader><leader>t :term<CR>

" Поиск выделенного текста.
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

" no jump on start (with ``)
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>``
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>``

" no jump on start (with ``)
nnoremap * *``
nnoremap # #``

" Форматирование для XML-документов
com! FormatXML %!python -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" Форматирование для JSON-кода
com! FormatJSON %!python -m json.tool --no-ensure-ascii --indent 2


" copy to the system clipboard in vim with xclip
vmap <Leader><Leader>y y:call system("xclip -i -selection clipboard", getreg("\""))<cr>:call system("xclip -i", getreg("\""))<cr>
nmap <Leader><Leader>p :call setreg("\"",system("xclip -o -selection clipboard"))<cr>p")")")"))

" Abbreviations
cnoreabbrev <expr> W ((getcmdtype() is# ':' && getcmdline() is# 'W')?('w'):('W'))
cnoreabbrev <expr> ц ((getcmdtype() is# ':' && getcmdline() is# 'ц')?('w'):('ц'))
cnoreabbrev <expr> й ((getcmdtype() is# ':' && getcmdline() is# 'й')?('q'):('й'))
cnoreabbrev <expr> йф ((getcmdtype() is# ':' && getcmdline() is# 'йф')?('qa'):('йa'))

" Nwetrw file explorer settings
let g:netrw_banner = 0 " hide banner above files
let g:netrw_liststyle = 3 " tree instead of plain view
let g:netrw_browse_split = 3 " lpen file in new tab


" PLUGINS 
source $HOME/.vim/plugins.vim
" F KEYS
source $HOME/.vim/f-keys.vim
