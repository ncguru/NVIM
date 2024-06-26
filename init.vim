if exists('g:vscode')
    " VSCode extension
else
    " ordinary Neovim

set enc=utf-8
set fenc=utf-8
set fencs=sjis,cp949,utf-8,ucs-bom,latin1,sjis
set nobomb
set langmenu=en_US.UTF-8 

"set guifont=Consolas_NF:h11
"set guifontwide=MS\ Mincho:h11
"set guifont=Fira\ Code:h12
set guifont=Fira\ Code\ Nerd\ Font:h12
set guifontwide=PlemolJP_Console_NF:h12
"set guifont=PlemolJP_Console_NF:h12

" Python configurations
"let g:python3_host_prog = '%USERPROFILE%\AppData\Local\Programs\Python\Python310\python'

"========= neovide==================================================================
if exists("g:neovide")
	" Put anything you want to happen only in Neovide here
	augroup ime_input
		autocmd!
		autocmd InsertLeave * execute "let g:neovide_input_ime=v:false"
		autocmd InsertEnter * execute "let g:neovide_input_ime=v:true"
		autocmd CmdlineEnter [/\?] execute "let g:neovide_input_ime=v:false"
		autocmd CmdlineLeave [/\?] execute "let g:neovide_input_ime=v:true"
	augroup END

	let g:neovide_scale_factor=1.0
	function! ChangeScaleFactor(delta)
		let g:neovide_scale_factor = g:neovide_scale_factor * a:delta
	endfunction
	nnoremap <expr><C-=> ChangeScaleFactor(1.25)
	nnoremap <expr><C--> ChangeScaleFactor(1/1.25)

endif



if has('autocmd')
	filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
	syntax enable
endif

" Map the leader key to ,
let mapleader="\<SPACE>"

" General {
set smarttab

"  set noautoindent        " I indent my code myself.
"  set nocindent           " I indent my code myself.
set smartindent        " Or I let the smartindent take care of it.

set nrformats-=octal

set ttimeout
set ttimeoutlen=100
set wrap!               "NO wrap
" }

" Search {
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.

"   set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif
" }

" Formatting {
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set number              " Show the line numbers on the left side.
"set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them. // set this to 80~120 if required
"  set expandtab           " Insert spaces when TAB is pressed.
set noexpandtab
set tabstop=4           " Render TABs using this many spaces.
set shiftwidth=4        " Indentation amount for < and > commands.

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
"set esckeys             " Cursor keys in insert mode.
set linespace=0         " Set line-spacing to minimum.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
	set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
	set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.


" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
	set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

"set list                " Show problematic characters.
"Indentline For Tab
"set list lcs=tab:\|\ 



" Also highlight all tabs and trailing whitespace characters.
"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+$\|\t/

" }

" Configuration {
if has('path_extra')
	setglobal tags-=./tags tags^=./tags;
endif

set autochdir           " Switch to current file's parent directory.

" Remove special characters for filename
set isfname-=:
set isfname-==
set isfname-=+

" Map ; to :
nnoremap ; :

if &history < 1000
	set history=200      " Number of lines in command history.
endif
if &tabpagemax < 50
	set tabpagemax=50     " Maximum tab pages.
endif

if &undolevels < 200
	set undolevels=200    " Number of undo levels.
endif

" Path/file expansion in colon-mode.
set wildmenu
set wildmode=list:longest
set wildchar=<TAB>

"set viminfo='100,<50,s10,h,rA:,rB:
"if !empty(&viminfo)
"	set viminfo^=!        " Write a viminfo file with registers.
"endif
set sessionoptions-=options

set nobackup            " no backup files
set noswapfile          " no swap files
set wildignore=*.swp,*.bak,*.pyc,*.class

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
	set t_Co=16
endif

" Remove trailing spaces before saving text files
" http://vim.wikia.com/wiki/Remove_trailing_spaces
" ----DISACTIVATED DUE TOO MUCH DIFF GIT DIFFERENCES -----
"autocmd BufWritePre * :call StripTrailingWhitespace()
function! StripTrailingWhitespace()
	if !&binary && &filetype != 'diff'
		normal mz
		normal Hmy
		if &filetype == 'mail'
			" Preserve space after e-mail signature separator
			%s/\(^--\)\@<!\s\+$//e
		else
			%s/\s\+$//e
		endif
		normal 'yz<Enter>
		normal `z
	endif
endfunction

" Diff options
set diffopt+=iwhite

"Enter to go to EOF and backspace to go to start
nnoremap <CR> G
nnoremap <BS> gg
" Stop cursor from jumping over wrapped lines
nnoremap j gj
nnoremap k gk
" Make HOME and END behave like shell
"inoremap <C-E> <End>
"inoremap <C-A> <Home>

" Enable mouse support (move cursor with mouse)
set mouse=a




" 'gelguy/wilder.nvim',
function! UpdateRemotePlugins(...)
	" Needed to refresh runtime files
	let &rtp=&rtp
	UpdateRemotePlugins
endfunction

"==== PlugIn manager==========================================
call plug#begin('~/AppData/Local/nvim/plugged')
" Typing Game
Plug 'NStefan002/speedtyper.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'rcarriga/nvim-notify'
" AI gemini
"Plug 'kiddos/gemini.nvim'

"Plug 'sharkdp/fd'
"Plug 'nixprime/cpsm'

" A more adventurous wildmenu Cammand Line
Plug 'gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }

"indent guide line
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'echasnovski/mini.nvim', { 'branch': 'stable' }

"nerd font
Plug 'lambdalisue/nerdfont.vim'

"Session, Start up
Plug 'mhinz/vim-startify'
Plug 'csch0/vim-startify-renderer-nerdfont'
"Plug 'nvimdev/dashboard-nvim', {'event':'VimEnter'}

" airline is a better status line and a tab-bar for nvim.
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" gruvbox colorscheme. Seems to work the best for me.
Plug 'ellisonleao/gruvbox.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

"taglist
Plug 'yegappan/taglist'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/AppData/Local/nvim/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.7' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'

"Plug 'prabirshrestha/vim-lsp'
"Plug 'mattn/vim-lsp-settings'
"Plug 'prabirshrestha/asyncomplete.vim'
"Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim' "Toggle ALL diagnostics on/off

" ==== Auto Complete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'


"==== IME 입력 모드에서 명령모드 변경시 IME 영문으로 자동 변경============
Plug 'pepo-le/win-ime-con.nvim'

" devicons
Plug 'nvim-tree/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'

" File Explore
Plug 'nvim-tree/nvim-tree.lua'

" Syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" C and C++ syntax
"Plug 'bfrg/vim-cpp-modern'

" 20220305 - javascript syntax highlight
"Plug 'jelera/vim-javascript-syntax'

" syntax python
"Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }

" syntax Color"
"Plug 'frazrepo/vim-rainbow'
Plug 'HiPhish/nvim-ts-rainbow2'  " Treesitter Rainbow 

" Git 
Plug 'tpope/vim-fugitive'

" Auto Rooter directory
Plug 'airblade/vim-rooter'
"Plug 'notjedi/nvim-rooter.lua'
"oldfiles
"Plug 'gpanders/vim-oldfiles'

" Functionalities - Python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'heavenshell/vim-pydocstring'

"Auto Pair"
"Plug 'windwp/nvim-autopairs'

call plug#end()


" 'gelguy/wilder.nvim',
"call wilder#setup({'modes': [':', '/', '?']})
call wilder#setup({'modes': [':', '?']})


" 'border'            : 'single', 'double', 'rounded' or 'solid'
"                     : can also be a list of 8 characters,
"                     : see :h wilder#popupmenu_border_theme() for more details
" 'highlights.border' : highlight to use for the border`
call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_border_theme({
			\ 'highlights': {
			\   'border': 'Normal',
			\ },
			\ 'border': 'rounded',
			\ 'highlighter': wilder#basic_highlighter(),
			\ 'left': [
			\   ' ', wilder#popupmenu_devicons(),
			\ ],
			\ 'right': [
			\   ' ', wilder#popupmenu_scrollbar(),
			\ ],
			\ })))

call wilder#set_option('pipeline', [
			\   wilder#branch(
			\     wilder#cmdline_pipeline(),
			\     wilder#search_pipeline(),
			\   ),
			\ ])


:command Ex NvimTreeFindFile
:command EX NvimTreeFindFileToggle

" }

" Keybindings {
"
nnoremap * *N
nnoremap gd gd<cr><C-o>
nnoremap <silent> <Leader>rg :Rg <C-R><C-W><CR>
" Save file
nnoremap <Leader>w :w<CR>
"Copy and paste from system clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

vmap <C-C> "+y
" Terminal Exit
tnoremap <Esc> <C-\><C-n>

" Move between buffers
nmap <Leader>l :bnext<CR>
nmap <Leader>h :bprevious<CR>

" }

" Experimental {
" Search and Replace
nmap <Leader>s :%s//g<Left><Left>
" }

"----Plug In Option ----------------------------------------
"Indent Guides
let g:indentLine_enabled = 1

" Plugin Settings {

  " Airline {
    if !exists('g:airline_symbols')
      let g:airline_symbols = {}
    endif

    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#buffer_idx_mode = 1
	let g:airline#extensions#tabline#buffer_nr_show = 1
	let g:airline_powerline_fonts = 1 " 별도 폰트 설정 할 필요가 없음
 
"    let g:airline#extensions#tabline#fnamemod = ':t'
"    let g:airline#extensions#tabline#left_sep = ''
"    let g:airline#extensions#tabline#left_alt_sep = ''
"    let g:airline#extensions#tabline#right_sep = ''
"    let g:airline#extensions#tabline#right_alt_sep = ''
"    let g:airline#extensions#tabline#formatter = 'default'
"
"    " unicode symbols
"    let g:airline_left_sep = '»'
"    let g:airline_left_sep = '' 
"    let g:airline_right_sep = '«'
"    let g:airline_right_sep = ''
"    let g:airline_symbols.crypt = ''
"    let g:airline_symbols.linenr = '␊'
"    let g:airline_symbols.linenr = '␤'
"    let g:airline_symbols.linenr = '¶'
"    let g:airline_symbols.maxlinenr = ''
"    let g:airline_symbols.maxlinenr = ''
"    let g:airline_symbols.branch =''
"    let g:airline_symbols.paste = 'ρ'
"    let g:airline_symbols.paste = 'Þ'
"    let g:airline_symbols.paste = '∥'
"    let g:airline_symbols.spell = 'Ꞩ'
"    let g:airline_symbols.notexists = '∄'
"    let g:airline_symbols.whitespace = 'Ξ'

   " Theme ( github.com/vim-airline/vim-airline-themes
    "let g:airline_theme= 'molokai'
    "let g:airline_theme= 'gruvbox'
  " }

  " CtrlP {
    " Open file menu
    nnoremap <Leader>o :CtrlP<CR>
    " Open buffer menu
    nnoremap <Leader>b :CtrlPBuffer<CR>
    " Open most recently used files
    nnoremap <Leader>f :CtrlPMRUFiles<CR>
  " }
  " deoplete {
  "  " Use deoplete
  "  let g:deoplete#enable_at_startup = 1
  " }
  " deoplete-clang {
  "  " Set default paths [REQURIED]
  "  let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
  "  let g:deoplete#sources#clang#clang_header  = '/usr/lib/clang'
  "  " Some CFLAGS/CPPFLAGS [OPTIONAL]
  "  let g:deoplete#souces#clang#std            = {'c': 'c11', 'cpp': 'c++11', 'objc': 'c11', 'objcpp': 'c++1z'}
  " }
" }

" vim:set ft=vim sw=2 ts=2:

"======LSP===================================================================
"let g:lsp_settings_root_markers = [
"\   '.repo',
"\   '.gitignore',
"\   '.thisRoot',
"\ ]

"let g:lsp_settings_root_markers = [
"\   'cscope.out',
"\   '.git',
"\   '.git/',
"\   '.svn',
"\   '.hg',
"\   '.bzr',
"\   '.mxproject', 
"\   '.thisRoot',
"\ ]
"


"let g:lsp_diagnostics_enabled = 0



if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
       \ })
endif


if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif


if executable("deno")
  augroup LspTypeScript
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
    \ "name": "deno lsp",
    \ "cmd": {server_info -> ["deno", "lsp"]},
    \ "root_uri": {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), "tsconfig.json", ".gitignore"))},
    \ "allowlist": ["typescript", "typescript.tsx"],
    \ "initialization_options": {
    \     "enable": v:true,
    \     "lint": v:true,
    \     "unstable": v:true,
    \   },
    \ })
  augroup END
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END" -------------------- LSP ---------------------------------


lua <<EOF

----NvimTree-----------------------------------------------
 vim.g.loaded_netrw = 1 -- netrw Disable
 vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
-- export DISABLE_GEMINI_INLINE=1

--require('gemini').setup({
--  menu_key = '<S-o>',
--  insert_result_key = '<S-Tab>',
--  hints_delay = 3000,
--  instruction_delay = 2000,
--  menu_prompts = {
--    {
--      name = 'Unit Test Generation',
--      command_name = 'GeminiUnitTest',
--      menu = 'Unit Test 🚀',
--      prompt = 'Write unit tests for the following code\n',
--    },
--    {
--      name = 'Code Review',
--      command_name = 'GeminiCodeReview',
--      menu = 'Code Review 📜',
--      prompt = 'Do a thorough code review for the following code.\nProvide detail explaination and sincere comments.\n',
--    },
--    {
--      name = 'Code Explain',
--      command_name = 'GeminiCodeExplain',
--      menu = 'Code Explain 👻',
--      prompt = 'Explain the following code\nprovide the answer in Markdown\n',
--    },
--  },
--  hints_prompt = [[
--Instruction: Use 1 or 2 sentences to describe what the following {filetype} function does:
--
--\`\`\`{filetype}
--{code_block}
--\`\`\`
--  ]],
--  instruction_prompt = [[
--Context: filename: \`{filename}\`
--
--Instruction: ***{instruction}***
--
--  ]],
--}) 
--
-- empty setup using defaults
require("nvim-tree").setup()

require("speedtyper").setup({
        })
----LSP-----------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup()
require'toggle_lsp_diagnostics'.init({start_on = false})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['pylsp'].setup {
	capabilities = capabilities,
}

require('lspconfig')['clangd'].setup {
	capabilities = capabilities,
}

require('lspconfig')['denols' ].setup {
	capabilities = capabilities,
}

local nvim_lsp = require'lspconfig'
nvim_lsp.pylsp.setup{
  root_dir = nvim_lsp.util.root_pattern('.gitignore');
}
local nvim_lsp = require'lspconfig'
nvim_lsp.clangd.setup{
  root_dir = nvim_lsp.util.root_pattern('.gitignore');
}
local nvim_lsp = require'lspconfig'
nvim_lsp.denols.setup{
  root_dir = nvim_lsp.util.root_pattern('.gitignore');
}
----nvim-treesitter-----------------------------------------------
require'nvim-treesitter.install'.compilers = { "gcc" }
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {"c", "lua", "vim", "vimdoc", "query", "javascript", "python", "ini"   },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = false,
	-- Enable Rainbow Parentheses
	rainbow = {
		enable = false,
	}, 
	-- Enable Treesitter Playground
	playground = { enable = false},
	-- List of parsers to ignore installing (or "all")
	ignore_install = { },

	---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
	-- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

	highlight = {
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		disable = { },
		-- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
		disable = function(lang, buf)
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
			end
			end,

			-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
			-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
			-- Using this option may slow down your editor, and you may see some duplicate highlights.
			-- Instead of true it can also be a list of languages
			additional_vim_regex_highlighting = false,
	},
}
  
-- ===== nvim-cmp ==========================================

-- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
  	snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
      end,
    },
    window = {
       completion = cmp.config.window.bordered(),
       documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

--======= indent-blankline =================
require("ibl").setup {
	indent = {
		char = "│",
		tab_char = "│",
	},
	scope = { enabled = false },
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"startify",
			"neo-tree",
			"NvimTree",
			"Trouble",
			"trouble",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
			"lazyterm",
		},
	},
}
--======= mini.indentscopei =================
require('mini.indentscope').setup{
  -- symbol = "▏",
  symbol = "│",
  options = { try_as_border = true },

}

-- ====== telescope-fzf-native ===================
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

require('mini.pairs').setup()

-- Default options:
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = false,
    emphasis = true,
    comments = false,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {
	  ["String"] = {fg = "#A9D08E"},
	  --["String"] = {fg = "#FFC000"},
  },
  dim_inactive = false,
  transparent_mode = true,
})
vim.cmd("colorscheme gruvbox")


------------------------EOF------------------------------------------
EOF

" UI Options {
o
" Colorsheme gruvbox   --------------------------------------------------
"let g:gruvbox_italic_comment = 0 
"
"let g:gruvbox_italic = 0
"
"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_bold = 0
"let g:gruvbox_improved_strings=0
"colorscheme gruvbox
"



"======Plug 'nagy135/typebreak.nvim'
nnoremap <leader>tb :lua require("typebreak").start()<CR>


" Fuzzy finder telescope

" telescope remap 
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fs <cmd>Telescope grep_string<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>
nnoremap <leader>fr <cmd>Telescope lsp_references<cr>
nnoremap <leader>fd <cmd>Telescope lsp_definitions<cr>



"======================CSCOPE Auto load====================================================
"au  BufRead *
"	\if has("cscope")
"		\add any database in current dir
"		\if filereadable("cscope.out")
"			\cs add cscope.out
"		\endif
"	\endif
""
"
"=======Plug airblade/vim-roooter'================================
let g:rooter_patterns = ['.repo','.gitignore', '.thisRoot' ]
"let g:rooter_patterns = ['.thisroot','.git','.git/', '.vbproj', '.mxproject', '.svn']

"====== For FZF ==================================================
let $PATH = "C:\\Program Files\\Git\\bin;" . $PATH
"let g:fzf_layout = { 'down': '50%' }
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
"let g:fzf_preview_window = [] " disable
"let g:fzf_preview_window = ['down:hidden', 'ctrl-/']


""-------- file type "syntax---------------------------------------------------------------------------
au BufRead,BufNewFile *.xaml setfiletype xml
au BufRead,BufNewFile *.hta setfiletype html
au BufRead,BufNewFile *.pyw setfiletype python

"========= rainbow Plugin Setting =========================================
"au FileType c,cpp,objc,objcpp,python,Javascript,html,txt,hta,js call rainbow#load()
let g:rainbow_active = 1


" ordinary Neovim
endif 

