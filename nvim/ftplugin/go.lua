local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())
   vim.opt.expandtab = false
   vim.opt.shiftwidth = 4
   vim.opt.tabstop = 4
   vim.opt.softtabstop = 4

   config['name'] = 'gopls'
   config['cmd'] = { 'gopls' }
   config['root_dir'] = vim.fs.root(0, { 'go.mod', 'go.work' }) or vim.fn.getcwd()

   vim.lsp.start(config)
   coroutine.yield()
end)
