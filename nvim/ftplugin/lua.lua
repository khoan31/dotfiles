local common = require('common')
local config = require('lsp').make_cfg()

common.run_async(function()
   assert(coroutine.running())
   vim.opt.expandtab = true
   vim.opt.shiftwidth = 3
   vim.opt.tabstop = 3
   vim.opt.softtabstop = 3

   config['name'] = 'luals'
   config['cmd'] = { 'lua-language-server' }
   config['root_dir'] = vim.fs.root(0, { '.luarc.json', '.luacheckrc', '.stylua.toml' }) or vim.fn.getcwd()
   config['settings'] = {
      Lua = {
         workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file('', true),
         },
         telemetry = {
            enable = false,
         },
      },
   }

   vim.lsp.start(config)
   coroutine.yield()
end)
