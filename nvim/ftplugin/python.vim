" indent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" lsp
lua << eof
local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())

   config['name'] = 'pyright'
   config['cmd'] = { 'pyright-langserver', '--stdio' }
   config['root_dir'] = vim.fn.getcwd()
   config['settings'] = {
      python = {
         analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'openFilesOnly',
         },
      },
   }

   vim.lsp.start(config)
   coroutine.yield()
end)
eof
