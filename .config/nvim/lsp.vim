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
EOF
set signcolumn=no " Don't show Hints, Warnings and Errors on the left of line numbers (line numbers are recolored instead)
sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=W texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint text=W texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
lua << EOF
  local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'mla', '<CMD>lua vim.lsp.buf.code_action()<CR>'    , opts)
    buf_set_keymap('n', 'mld', '<CMD>lua vim.lsp.buf.declaration()<CR>'    , opts)
    buf_set_keymap('n', 'mlg', '<CMD>lua vim.lsp.buf.definition()<CR>'     , opts)
    buf_set_keymap('n', 'mlG', '<CMD>lua require(\'telescope.builtin\').lsp_definitions( { jump_type = "tab" } )<CR>', opts)
    buf_set_keymap('n', 'mlf', '<CMD>lua vim.lsp.buf.format()<CR>'         , opts)
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
  vim.lsp.config("bashls", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("cssls", { on_attach=on_attach, capabilities = capabilities, cmd={ "css-languageserver", "--stdio" } })
  vim.lsp.config("dhall_lsp_server", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("elmls", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("hls", { on_attach=on_attach, capabilities = capabilities, settings={ haskell={ formattingProvider="fourmolu" } } })
  vim.lsp.config("html", { on_attach=on_attach, capabilities = capabilities, cmd={ "html-languageserver", "--stdio" } })
  require('idris2').setup({ server = { on_attach=on_attach, capabilities = capabilities } })
  vim.lsp.config("jsonls", { on_attach=on_attach, capabilities = capabilities, cmd={ "json-languageserver", "--stdio" } })
  vim.lsp.config("pyright", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("nil_ls", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("vimls", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.config("yamlls", { on_attach=on_attach, capabilities = capabilities })
  vim.lsp.enable({
    "bashls",
    "cssls",
    "dhall_lsp_server",
    "elmls",
    "hls",
    "html",
    "jsonls",
    "pyright",
    "nil_ls",
    "cimls",
    "yamlls",
  })
EOF
