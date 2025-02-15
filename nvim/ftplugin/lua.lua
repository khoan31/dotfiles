local common = require('utils.common')
local config = require('utils.lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())
   vim.opt.expandtab = true
   vim.opt.shiftwidth = 3
   vim.opt.tabstop = 3
   vim.opt.softtabstop = 3

   config['name'] = 'luals'
   config['cmd'] = { 'lua-language-server' }
   config['root_dir'] = vim.fs.root(0, { '.luarc.json', '.luacheckrc', '.stylua.toml' }) or vim.fn.getcwd() .. '/nvim'

   vim.lsp.start(config)
   coroutine.yield()
end)
