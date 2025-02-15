" indent
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2

" lsp
lua << eof
local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())

   config['name'] = 'clangd'
   config['cmd'] = { 'clangd' }
   config['root_dir'] = vim.fs.root(0, { 'CMakeLists.txt', '.clangd', '.clang-format' }) or vim.fn.getcwd()

   vim.lsp.start(config)
   coroutine.yield()
end)
eof
