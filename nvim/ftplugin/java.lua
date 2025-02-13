vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

local data_home = os.getenv('XDG_DATA_HOME')
local workspace_dir = data_home .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls = data_home .. '/nvim/mason/packages/jdtls'

require('jdtls').start_or_attach({
   name = 'jdtls',
   cmd = {
      os.getenv('JDK21') .. '/bin/java',
      '-Declipse.application=org.eclipse.jdt.ls.core.id1',
      '-Dosgi.bundles.defaultStartLevel=4',
      '-Declipse.product=org.eclipse.jdt.ls.core.product',
      '-Dlog.protocol=true',
      '-Dlog.level=ALL',
      '-Xmx2g',
      '--add-modules=ALL-SYSTEM',
      '--add-opens', 'java.base/java.util=ALL-UNNAMED',
      '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
      '-jar', vim.fn.glob(jdtls .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
      '-configuration', jdtls .. '/config_mac_arm',
      '-data', workspace_dir,
   },
   -- root_dir = vim.fs.root(0, {'pom.xml', '.git', 'mvnw', 'gradlew'}),
   root_dir = vim.fn.getcwd(),
   settings = {
      java = {
         references = {
            includeDecompiledSources = true,
         },
         eclipse = {
            downloadSources = true,
         },
         maven = {
            downloadSources = true,
         },
         signatureHelp = { enabled = true },
         sources = {
            organizeImports = {
               starThreshold = 9999,
               staticStarThreshold = 9999,
            },
         },
      }
   },
   on_attach = require('utils.lsp').make_cfg().on_attach
})

-- Maven test
if vim.fn.executable('mvn') > 0 then
   vim.api.nvim_create_user_command('MvnTest', function(opts)
      local file_path = vim.fn.expand('%:p')
      local dirs = vim.split(file_path, '/')

      local is_test = false
      local module = ''
      local class = ''

      for i = #dirs, 1, -1 do
         if dirs[i] == 'test' then
            is_test = true
            class = table.concat(vim.list_slice(dirs, i + 2, #dirs), '.')
            class = class:gsub('%.java$', '')
         end

         if dirs[i] == 'src' and i - 1 >= 1 then
            module = dirs[i - 1]
         end
      end

      if not is_test then
         print('Not a test file!')
         return
      end

      if opts.args and not opts.args:match('^%s*$') then
         class = string.format('%s\\#%s', class, opts.args:gsub('%s+', ''))
      end

      vim.cmd(string.format('terminal mvn test -T 1C -pl :%s -Dtest=%s -DskipTests=false -Dgroups=small,medium', module,
         class))
   end, { nargs = '?' })
end
