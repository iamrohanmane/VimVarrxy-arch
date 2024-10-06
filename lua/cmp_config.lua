local cmp = require('cmp')

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Use your snippet engine here
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Down
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- Up
    ['<C-Space>'] = cmp.mapping.complete(),      -- Trigger completion
    ['<C-e>'] = cmp.mapping.close(),             -- Close completion
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' }, -- If you're using LuaSnip
  },
})

-- LSP configuration for clangd
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['clangd'].setup {
  capabilities = capabilities
}

-- Setup for cmdline completion
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'path' },
    { name = 'cmdline' },
  },
})
