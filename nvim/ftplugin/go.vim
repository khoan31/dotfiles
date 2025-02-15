" indent
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" lsp
lua << eof
local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())

   config['name'] = 'gopls'
   config['cmd'] = { 'gopls' }
   config['root_dir'] = vim.fs.root(0, { 'go.mod', 'go.work' }) or vim.fn.getcwd()

   vim.lsp.start(config)
   coroutine.yield()
end)
eof
