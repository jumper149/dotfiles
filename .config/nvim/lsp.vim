set completeopt=menuone,noselect
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<Tab>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' }, -- For vsnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  -- TODO: This is not part of LSP
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- TODO: This is not part of LSP
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  require('lspconfig')['bashls'].setup { capabilities = capabilities }
  require('lspconfig')['cssls'].setup { capabilities = capabilities }
  require('lspconfig')['dhall_lsp_server'].setup { capabilities = capabilities }
  require('lspconfig')['hls'].setup { capabilities = capabilities }
  require('lspconfig')['html'].setup { capabilities = capabilities }
  require('lspconfig')['jsonls'].setup { capabilities = capabilities }
  require('lspconfig')['pyright'].setup { capabilities = capabilities }
  require('lspconfig')['rnix'].setup { capabilities = capabilities }
  require('lspconfig')['vimls'].setup { capabilities = capabilities }
  require('lspconfig')['yamlls'].setup { capabilities = capabilities }
EOF
set signcolumn=no " Don't show Hints, Warnings and Errors on the left of line numbers (line numbers are recolored instead)
sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=W texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint text=W texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'mla', '<CMD>lua vim.lsp.buf.code_action()<CR>'    , opts)
    buf_set_keymap('n', 'mld', '<CMD>lua vim.lsp.buf.declaration()<CR>'    , opts)
    buf_set_keymap('n', 'mlg', '<CMD>lua vim.lsp.buf.definition()<CR>'     , opts)
    buf_set_keymap('n', 'mlG', '<CMD>lua require(\'telescope.builtin\').lsp_definitions( { jump_type = "tab" } )<CR>', opts)
    buf_set_keymap('n', 'mlf', '<CMD>lua vim.lsp.buf.formatting()<CR>'     , opts)
    buf_set_keymap('n', 'mlk', '<CMD>lua vim.lsp.buf.hover()<CR>'          , opts)
    buf_set_keymap('n', 'mli', '<CMD>lua vim.lsp.buf.implementation()<CR>' , opts)
    buf_set_keymap('n', 'mlr', '<CMD>lua vim.lsp.buf.references()<CR>'     , opts)
    buf_set_keymap('n', 'mlc', '<CMD>lua vim.lsp.buf.rename()<CR>'         , opts)
    buf_set_keymap('n', 'mlh', '<CMD>lua vim.lsp.buf.signature_help()<CR>' , opts)
    buf_set_keymap('n', 'mlt', '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'mlwa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>'   , opts)
    buf_set_keymap('n', 'mlwr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', 'mlwl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'ml<SPACE><SPACE>', '<CMD>lua vim.diagnostic.open_float()<CR>'                 , opts)
    buf_set_keymap('n', 'ml<SPACE>p', '<CMD>lua vim.diagnostic.goto_prev()<CR>'                        , opts)
    buf_set_keymap('n', 'ml<SPACE>n', '<CMD>lua vim.diagnostic.goto_next()<CR>'                        , opts)
    buf_set_keymap('n', 'ml<SPACE>q', '<CMD>lua vim.diagnostic.set_loclist()<CR>'                      , opts)
  end
  nvim_lsp.bashls.setup { on_attach=on_attach }
  nvim_lsp.cssls.setup { on_attach=on_attach, cmd={ "css-languageserver", "--stdio" } }
  nvim_lsp.dhall_lsp_server.setup { on_attach=on_attach }
  nvim_lsp.elmls.setup { on_attach=on_attach }
  nvim_lsp.hls.setup { on_attach=on_attach }
  nvim_lsp.html.setup { on_attach=on_attach, cmd={ "html-languageserver", "--stdio" } }
  require('idris2').setup { server = { on_attach=on_attach } }
  nvim_lsp.jsonls.setup { on_attach=on_attach, cmd={ "json-languageserver", "--stdio" } }
  nvim_lsp.pyright.setup { on_attach=on_attach }
  nvim_lsp.rnix.setup { on_attach=on_attach }
  nvim_lsp.vimls.setup { on_attach=on_attach }
  nvim_lsp.yamlls.setup { on_attach=on_attach }
EOF
