
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-fugitive' " Git plugin
Plug 'scrooloose/nerdtree' " NERD file explorer
Plug 'PhilRunninger/nerdtree-buffer-ops' " Highlighter for NERD
" Plug 'ycm-core/YouCompleteMe' " Super handy code completion for a shit load of languages
Plug 'Nopik/vim-nerdtree-direnter' " Fix issue in which opening a directory in NERDTree opens a new tab
Plug 'szw/vim-g' " Search Google inside vim!
Plug 'hienvd/vim-stackoverflow' " Search Stack Overflow inside vim!
Plug 'vim-airline/vim-airline' " Cool status bar
Plug 'cespare/vim-toml' " TOML syntax
Plug 'tikhomirov/vim-glsl' " GLSL syntax
Plug 'beyondmarc/hlsl.vim' " HLSL syntax
Plug 'lambdalisue/battery.vim' " Battery
Plug 'mox-mox/vim-localsearch' " Local searching
Plug 'mhinz/vim-signify' " Handy git diff stuff
" Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}

Plug 'neovim/nvim-lspconfig' " Nvim LSP
Plug 'kabouzeid/nvim-lspinstall' " Autoinstall LSP servers
Plug 'hrsh7th/nvim-compe' " Completion engine
Plug 'onsails/lspkind-nvim' " Pictograms
Plug 'SirVer/ultisnips' " Quick large autocompletes
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'neovim/nvim-lspconfig'
Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'morhetz/gruvbox' " Gruvbox theme
Plug 'wakatime/vim-wakatime' " How much time I spend
Plug 'codota/tabnine-vim' " Tabnine AI autocomplete
Plug 'glepnir/dashboard-nvim' " Neat dashboard!
Plug 'liuchengxu/vim-clap' " Fuzzy search

call plug#end()

" Quite literally the best look and feel every
let g:material_theme_style = 'gruvbox'
colorscheme gruvbox

let g:dashboard_default_executive ='clap'

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>

" Dashboard (Home screen) Settings
let g:dashboard_footer_icon = ' ' "  neovim loaded x plugins
" Add custom neovim logo at top of dashboard
let g:dashboard_preview_command = 'cat'
let g:dashboard_preview_pipeline = 'lolcat'
let g:dashboard_preview_file = '~/.config/nvim/ascii/planetDash.txt'
" Size of area where dashboard logo goes
let g:dashboard_preview_file_height = 9 
let g:dashboard_preview_file_width = 80

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Line numbers
set nu

" Configure local searching
nmap <leader>/ <Plug>localsearch_toggle

" Setup tabing shortcuts
nnoremap <leader>n :tabnew<CR>
nnoremap <S-Left> :-tabnext<CR>
nnoremap <S-Right> :+tabnext<CR>

" Setup NERDTree shortcuts
nnoremap <leader>g :NERDTreeFocus<CR>
nnoremap <leader>f :NERDTreeToggle<CR>

" Start the dashboard when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | :Dashboard | endif

" Open all files selected in NERDTree in new tabs.
let NERDTreeMapOpenInTab='<ENTER>'

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Exit Vim if terminal in the only tab left
autocmd TabEnter * if stridx(@%, '/bin/zsh') != -1 | quit | endif 

" Setup YouCompleteMe goto shortcuts
nnoremap <leader>ji :YcmCompleter GoTo<CR>

" Setup YouCompleteMe semantic information shortcuts
nnoremap <leader>gt :YcmCompleter GetType<CR>

" Setup YouCompleteMe refactoring shortcuts
nnoremap <leader>rr :YcmCompleter FixIt<CR>
nnoremap <leader>rn :YcmCompleter RefactorName<CR>
nnoremap <leader>rf :YcmCompleter Format<CR>

" Setup random YouCompleteMe shortcuts
nnoremap <leader>e :YcmShowDetailedDiagnostic<CR>

" Move back to file that is wanted
autocmd BufReadPost * tabfirst

" Setup our cool tab line.
let g:airline#extensions#tabline#enabled = 1 " Display all buffers when only one tab is open.
" let g:airline#extensions#tabline#formatter = 'unique_tail' " Get better tab names

" Show all the errors
let g:ycm_max_diagnostics_to_display = 1000

" Enable Rust for YCM
let g:ycm_global_ycm_extra_conf = '~/.config/nvim/global_extra_conf.py'

" Use 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Setup character encoding
set encoding=UTF-8

" Set two semicolons to be escape
imap ;; <Esc>

" Auto change directory
set autochdir

" Mouse support
set mouse=a

lua << EOF
require'lspconfig'.rust_analyzer.setup{}

require('rust-tools').setup({})

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
  };
}

require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' (requires nerd-fonts font) or
    -- 'codicons' for codicon preset (requires vscode-codicons font)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
      Text = "!",
      Method = "𝑓",
      Function = "𝑓",
      Constructor = "𝑓⁺",
      Field = "𝑣⁺",
      Variable = "𝑣",
      Class = "𝑐",
      Interface = "⚣",
      Module = "⚢",
      Property = "p",
      Unit = "𐄷",
      Value = "𝑓",
      Enum = "༕",
      Keyword = "⎇",
      Snippet = "ℇ",
      Color = "⾊",
      File = "⌮",
      Reference = "※",
      Folder = "❅",
      EnumMember = "e⁺",
      Constant = "ℎ",
      Struct = "䷦",
      Event = "༕",
      Operator = "⨕",
      TypeParameter = ""
    },
})
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })

nnoremap <silent><nowait> <C-x> :Clap files<CR>
nnoremap <silent><nowait> <C-s> :Clap grep2<CR>
nnoremap <silent><nowait> <C-space> :Clap<CR>

finish

