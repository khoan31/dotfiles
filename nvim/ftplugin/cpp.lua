local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())
   vim.opt.expandtab = true
   vim.opt.shiftwidth = 2
   vim.opt.tabstop = 2
   vim.opt.softtabstop = 2

   config['name'] = 'clangd'
   config['cmd'] = { 'clangd' }
   config['root_dir'] = vim.fs.root(0, { 'CMakeLists.txt', '.clangd', '.clang-format' }) or vim.fn.getcwd()

   vim.lsp.start(config)
   coroutine.yield()
end)
