local M = {}

function M.make_cfg()
   return {
      on_attach = function(_, bufnr)
         -- Mappings.
         -- See `:help vim.lsp.*` for documentation on any of the below functions

         -- LSP navigation keymaps
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

         -- LSP actions
         vim.keymap.set('n', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et LSP code [a]ction', buffer = bufnr })
         vim.keymap.set('v', 'ga', function() vim.lsp.buf.code_action() end,
            { desc = '[g]et LSP code [a]ction', buffer = bufnr })
         vim.keymap.set('n', 'gR', function() vim.lsp.buf.rename() end,
            { desc = '[g]o [r]ename symbols', buffer = bufnr })
         vim.keymap.set('n', 'gq', function() vim.lsp.buf.format() end,
            { desc = '[g]o [q]uick format current buffer', buffer = bufnr })
         vim.keymap.set('v', 'gq', function() vim.lsp.buf.format() end,
            { desc = '[g]o [q]uick format current buffer', buffer = bufnr })

         -- LSP info
         vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, { desc = 'Hover [K]eyword', buffer = bufnr })
         vim.keymap.set('n', '<C-s>', function() vim.lsp.buf.signature_help() end,
            { desc = 'Show [s]ignature help', buffer = bufnr })

         -- Diagnostic keymaps
         vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open [d]iagnostic float' })
         vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev [d]iagnostic' })
         vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [d]iagnostic' })
         vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

         -- Diagnostic sign symbols
         vim.lsp.handlers['textDocument/publishDiagnostics'] =
             vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                underline = false,
                virtual_text = {
                   prefix = '†',
                   spacing = 2,
                },
                update_in_insert = false,
                severity_sort = true,
             })

         -- Diagnostic signs
         vim.diagnostic.config({
            signs = {
               text = {
                  [vim.diagnostic.severity.ERROR] = '■',
                  [vim.diagnostic.severity.WARN] = '▲',
                  [vim.diagnostic.severity.INFO] = '●',
                  [vim.diagnostic.severity.HINT] = '◆',
               }
            }
         })
      end,
      autostart = false,
      single_file_support = true,
   }
end

return M
