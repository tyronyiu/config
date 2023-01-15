local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'eslint',
    'sumneko_lua',
    'graphql',
})

-- Fix Undefined global 'vim'
lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
})

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = "Organised Imports"
  }
  vim.lsp.buf.execute_command(params)
end

local function fix_all()
  local params = {
    command = "_typescript.FixAll",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = "Fixed All"
  }
  vim.lsp.buf.execute_command(params)
end

local function add_missing_imports()
  local params = {
    command = "_typescript.AddMissingImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = "Added missing imports"
  }
  vim.lsp.buf.execute_command(params)
end

local function remove_unused()
  local params = {
    command = "_typescript.RemoveUnused",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = "Removed unused"
  }
  vim.lsp.buf.execute_command(params)
end

lsp.configure('eslint', {
     on_attach = function(client)
    local group = vim.api.nvim_create_augroup("Eslint", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group,
      pattern = "<buffer>",
      command = "EslintFixAll",
      desc = "Run eslint when saving buffer.",
    })
  end,
})

lsp.configure("tsserver", {
    on_attach = function(client, bufnr)
        print('hello tsserver')
         vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "<buffer>",
            command = "OganizeImports",
            desc = "Run eslint when saving buffer.",
        })
    end,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
        },
        FixAll = {
            fix_all,
            description = "Fix All"
        },
        AddMissingImports = {
            add_missing_imports,
            description = "Add missing imports"
        },
        RemoveUnused = {
            remove_unused,
            description = "Remove unused"
        }
    },
    settings = {
        completions = {
            completeFunctionCalls = true
        },
    },
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
})


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

-- disable completion with tab
-- this helps with copilot setup
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    --local group = vim.api.nvim_create_augroup("Eslint", {})
    --vim.api.nvim_create_autocmd("BufWritePre", {
    --    group = group,
    --    pattern = "<buffer>",
    --    command = "EslintFixAll",
    --    desc = "Run eslint when saving buffer.",
    --})

   -- if client.name == "eslint" then
   --     vim.cmd.LspStop('eslint')
   --     return
   -- end

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)

    --nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    --nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    --nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    --nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    --nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    --nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')

    --    vim.keymap.set("n", 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    --vim.keymap.set("n", 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    --   vim.keymap.set("n", 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    --   vim.keymap.set("n", '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
end)

lsp.setup()

vim.diagnostic.config({
    virtual_text = true,
})
