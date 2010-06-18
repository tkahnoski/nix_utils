" to load new doc files:
" :helptags ~/.vim/doc

" for detection of file type
filetype plugin on



"""""""""""""""""""""""""""""""""""""""""
" SCRIPTING
"""""""""""""""""""""""""""""""""""""""""

" run the current script file
function RunThis()
  let arguments=input('args: ')
  let filePath = expand("%:p")
  execute ':!echo;echo "==============================================================================";' . filePath . ' ' . arguments
endfunction

map <Leader>r :call RunThis()<CR>

" compile and view the current tex file
function LatexThis()
  let filePath = expand("%:p")
  execute ':!echo;echo "=============================================================================="; /home/vincent/bin/lv ' . filePath
endfunction

map <Leader>lv :call LatexThis()<CR>



"""""""""""""""""""""""""""""""""""""""""
" SVN
"""""""""""""""""""""""""""""""""""""""""
" diff with a revision
function SVNDiffToRev()
  execute 'vert diffsplit'
  let revisionNumber=input('Revision:  ')
  execute "SVNReview" revisionNumber
  execute 'diffthis'
endfunction

" automatically delete temporary svn buffers when we're done with them
let SVNCommandDeleteOnHide=1
map <Leader>sc :SVNCommit<cr>
map <Leader>sl :SVNLog<cr>
map <Leader>sd :SVNVimDiff<cr>
map <Leader>sr :call SVNDiffToRev()<cr>
map <Leader>ss :!svn st -u > /tmp/svn.st; echo >> /tmp/svn.st; echo "Current directory:" >> /tmp/svn.st; pwd >> /tmp/svn.st<cr><cr>:sp /tmp/svn.st<cr>:set syntax=svn<cr>

"""""""""""""""""""""""""""""""""""""""""
" DIFF
"""""""""""""""""""""""""""""""""""""""""
" turn off diffing on the current buffer
map <Leader>nd :set nodiff<cr>

" built-in:
" ]c go to the next change
" [c go to the previous change

"""""""""""""""""""""""""""""""""""""""""
" MAKE
"""""""""""""""""""""""""""""""""""""""""
function PressEnterToContinue(msg)
  let blah=input(a:msg . ' Press enter to continue. ')
endfunction
map <Leader>mc :!echo 'starting make clean...'<cr>:make! clean<cr>:cwin<cr>:call PressEnterToContinue('Finished make clean.')<cr>
map <Leader>md :!echo 'starting make COPTIMIZE="-O0 -DDEBUG"...'<cr>:make! COPTIMIZE="-O0 -DDEBUG"<cr>:cwin<cr>:call PressEnterToContinue('Finished make debug.')<cr>
map <Leader>mcd :!echo 'starting make clean; make COPTIMIZE="-O0 -DDEBUG"...'<cr>:make! clean ; make COPTIMIZE="-O0 -DDEBUG"<cr>:cwin<cr>:call PressEnterToContinue('Finished make clean debug.')<cr>
map <Leader>ma :!echo 'starting make all...'<cr>:make! quick<cr>:cwin<cr>:call PressEnterToContinue('Finished make all.')<cr>
map <Leader>mca :!echo 'starting make clean all...'<cr>:make! clean ; make quick<cr>:cwin<cr>:call PressEnterToContinue('Finished make clean all.')<cr>
map <Leader>mr :!echo 'starting make relink...'<cr>:make! relink<cr>:cwin<cr>:call PressEnterToContinue('Finished make relink.')<cr>

"""""""""""""""""""""""""""""""""""""""""
" CONTROL
"""""""""""""""""""""""""""""""""""""""""
map n nzz
map N Nzz
set backupdir=./.bak,.,/tmp     " where to put backup files
set directory=./.bak,.,/tmp     " where to put .swp files
" open the vim file explorer
map <Leader>fe :topleft 30vs .<cr>:set nonumber<cr>

set nocompatible                 " use vim settings instead of vi settings
set mouse=a                      " enable mouse
set incsearch                    " incremental searches
set hlsearch                     " highlight searches
set viminfo='20,\\"50,h,%        " specify what to save between sessions
set noerrorbells                 " no annoying beeps!!
set visualbell                   " no annoying beeps!!

"set ignorecase

"""""""""""""""""""""""""""""""""""""""""
" DISPLAY
"""""""""""""""""""""""""""""""""""""""""
":colorscheme vincent
" set number                       " show line numbers
" quick way to resize the window to 80 columns
map `` :vertical resize 30<cr>
set splitbelow                   " split below when doing :split
set splitright                   " split to the right when doing :vsplit
" resize window 2 shorter
map - <C-w>-
" resize window 2 taller
map + <C-w>+
set guioptions=agim              " do :help guioptions to see what this does
set showcmd                      " display incomplete commands
set ruler                        " always show cursor position
set laststatus=2                 " always show the status line
set statusline=
set statusline+=%-3.3n\                      " buffer number
set statusline+=%f\                          " filename
set statusline+=%h%m%r%w                     " status flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}] " file type
set statusline+=%=                           " right align remainder
set statusline+=0x%-8B                       " character value
set statusline+=%-14(%l,%c%V%)               " line, character
set statusline+=%<%P                         " file position

"""""""""""""""""""""""""""""""""""""""""
" FORMATTING/EDITING
"""""""""""""""""""""""""""""""""""""""""
syn on                           " syntax
set expandtab                    " use spaces instead of tabs
set backspace=indent,eol,start   " backspace over everything
set autoindent                   " autoindent
"set cindent                      " c style indentation
set smartindent                  " some c-like auto formatting, like tab after {
" don't shift # comments to the beginning of line
inoremap # X#
set shiftwidth=2                 " this is what smartindent uses for tab
set tabstop=2                    " make tabs equal to two spaces
set formatoptions=croql          " autoformats comments, etc.
                                 " determines what gets formatted as comments
set comments=s1:/*,mb:*,ex:*/,b:#
set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-120-*-*-m-*-iso10646-1

set printoptions=syntax:n        " don't print colors

"""""""""""""""""""""""""""""""""""""""""
" LONG LINES
"""""""""""""""""""""""""""""""""""""""""
set nowrap                       " don't wrap long lines
set linebreak                    " don't wrap in the middle of a word
set display+=lastline            " show lines even when they wrap offscreen
set listchars=eol:$,precedes:^,extends:$  " special characters to display
set sidescroll=1                 " when cursor goes off screen, scroll this much
set textwidth=0                  " auto-insert line breaks to make lines <= 80
" set sidescrolloff=10             " scroll when cursor gets x chars from edge
" scroll screen right
map <C-l> 2zl
" scroll screen left
map <C-h> 2zh
map <C-j> <C-e>
map <C-k> <C-y>
map <Up> gk
map <Down> gj

" function Publish()
"   execute 'source /home/vincent/.vim/syntax/2html.vim'
"   execute 'sav! /home/vincent/public_html/roadmap.html'
"   execute '%s/^last updated:.*/last updated: /'
"   ggnV
"   execute '!date +"\%m/\%d/\%y \%l:\%M\%P"'
"   0ilast updated: <esc>:s/ \+/ /g<CR>:w<CR>:noh<CR>
" endfunction


map <Leader>h :source /home/vincent/.vim/syntax/2html.vim<CR>:sav! /home/vincent/public_html/roadmap.html<CR>:%s/^last updated:.*/last updated: /<CR>ggnV!date +'\%m/\%d/\%y \%l:\%M\%P'<CR>0ilast updated: <esc>:s/ \+/ /g<CR>:w<CR>:noh<CR>


"set wrap
":vsp



"if has("gui_gtk2")
"    set guifont=MiscFixed\ 11
"else
"    set guifont=-misc-fixed-medium-r-normal--11-100-75-75-c-60-iso8859-1
"endif

set nu
set wrap
