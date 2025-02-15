local M = {}

function M.make_cfg()
   return {
      on_attach = function(client, bufnr)
         -- enalbe inlay hint and autocompletion
         vim.lsp.inlay_hint.enable(true)
         vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = false })

         -- mappings.
         -- see `:help vim.lsp.*` for documentation on any of the below functions

         -- lsp navigation keymaps
         vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end,
            { desc = '[g]o to [d]efinition', buffer = bufnr })
         vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end,
            { desc = '[g]o to [D]eclaration', buffer = bufnr })
         vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end,
            { desc = '[g]o to [i]mplementation', buffer = bufnr })
         vim.keymap.set('n', 'gy', function() vim.lsp.buf.type_definition() end,
            { desc = '[g]o to t[y]pe definition', buffer = bufnr })
         vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end,
            { desc = '[g]o to [r]eferences', buffer = bufnr })

         -- lsp actions
         vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et lsp code [a]ction', buffer = bufnr })
         vim.keymap.set('v', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et lsp code [a]ction', buffer = bufnr })
         vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end,
            { desc = '[g]o [R]ename symbols', buffer = bufnr })
         vim.keymap.set('n', 'gq', function() vim.lsp.buf.format() end,
            { desc = '[g]o [q]uick format current buffer', buffer = bufnr })
         vim.keymap.set('v', 'gq', function() vim.lsp.buf.format() end,
            { desc = '[g]o [q]uick format current buffer', buffer = bufnr })

         -- lsp info
         vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'hover [K]eyword', buffer = bufnr })
         vim.keymap.set('n', '<c-s>', function() vim.lsp.buf.signature_help() end,
            { desc = 'show [s]ignature help', buffer = bufnr })

         -- diagnostic keymaps
         vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float, { desc = 'open [k]eyword diagnostic float' })
         vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = 1, float = false }) end,
            { desc = 'prev [d]iagnostic' })
         vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = -1, float = false }) end,
            { desc = 'next [d]iagnostic' })
         vim.keymap.set('n', '<leader>d', function()
            local diagnostics = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.WARN } })
            vim.diagnostic.setloclist(vim.diagnostic.toqflist(diagnostics))
         end, { desc = 'add buffer [d]iagnostics to location list' })

         -- diagnostic signs
         vim.diagnostic.config({
            virtual_text = true,
            underline = false,
            float = false,
            signs = {
               text = {
                  [vim.diagnostic.severity.ERROR] = '↯',
                  [vim.diagnostic.severity.WARN] = '↺',
                  [vim.diagnostic.severity.INFO] = '⇌',
                  [vim.diagnostic.severity.HINT] = '↝',
               }
            },
         })
      end,
      detached = true,
   }
end

return M
