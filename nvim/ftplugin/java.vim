" indent
setlocal expandtab
setlocal shiftwidth=4
setlocal tabstop=4
setlocal softtabstop=4

" maven test
if executable('mvn')
  function! s:run_mvn_test(...) abort
    let l:file_path = expand('%:p')
    let l:dirs = split(l:file_path, '/')

    let l:is_test = v:false
    let l:module = ''
    let l:class = ''

    for i in range(len(l:dirs) - 1, 0, -1)
      if l:dirs[i] == 'test'
        let l:is_test = v:true
        let l:class = join(slice(l:dirs, i + 2, len(l:dirs)), '.')
        let l:class = substitute(l:class, '\.java$', '', '')
      endif

      if l:dirs[i] == 'src' && i - 1 >= 0
        let l:module = l:dirs[i - 1]
        break
      endif
    endfor

    if !l:is_test
      echo 'not a test file!'
      return
    endif

    if a:0 > 0
      let l:class .= '\#' . substitute(a:1, '\s', '', 'g')
    endif

    execute 'terminal mvn test -T 1C -pl :' . l:module . ' -Dtest=' . l:class . ' -DskipTests=false -Dgroups=small,medium'
  endfunction

  command! -nargs=? MvnTest call <sid>run_mvn_test(<f-args>)
endif

" lsp
lua << eof
local data_home = os.getenv('XDG_DATA_HOME')
local workspace_dir = data_home .. '/jdtls/workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls = data_home .. '/nvim/mason/packages/jdtls'
local config = require('lsp').make_cfg()

config['name'] = 'jdtls'
config['cmd'] = {
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
}
config['root_dir'] = vim.fn.getcwd() -- or vim.fs.root(0, {'pom.xml', '.git', 'mvnw', 'gradlew'}),
config['settings'] = {
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
  }
require('jdtls').start_or_attach(config)
eof
