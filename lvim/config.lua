-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
--vim.opt.colorcolumn = "99999" -- fixes indentline for now
--vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0       -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
---vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
---vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
--vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
--vim.opt.hlsearch = true -- highlight all matches on previous search pattern
--vim.opt.ignorecase = true -- ignore case in search patterns
--vim.opt.mouse = "a" -- allow the mouse to be used in neovim
--vim.opt.pumheight = 10 -- pop up menu height
--vim.opt.showmode = false -- we don't need to see things like -- INSERT -- anymore
--vim.opt.showtabline = 2 -- always show tabs
--vim.opt.smartcase = true -- smart case
--vim.opt.smartindent = true -- make indenting smarter again
--vim.opt.splitbelow = true -- force all horizontal splits to go below current window
--vim.opt.splitright = true -- force all vertical splits to go to the right of current window
--vim.opt.swapfile = false -- creates a swapfile
--vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
--vim.opt.timeoutlen = 100 -- time to wait for a mapped sequence to complete (in milliseconds)
--vim.opt.title = true -- set the title of window to the value of the titlestring
--vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
--vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
--vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
--vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
--vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2    -- insert 2 spaces for a tab
--vim.opt.cursorline = true -- highlight the current line
--vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 4       -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"    -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false          -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8


-- general
--lvim.log.level = "info"
lvim.format_on_save.enabled = true
lvim.colorscheme = "lunar"
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

lvim.builtin.telescope.defaults.file_ignore_patterns = { "node_modules", "dist", ".next", ".git" }

-- lvim.builtin.which_key.mappings["x"] = {
--   ":bd<CR>", "close buffer"
-- }
lvim.lsp.buffer_mappings.normal_mode['gd'] = { vim.lsp.buf.definition, "[G]o to [d]efinition (LSP)" }
lvim.lsp.buffer_mappings.normal_mode['gi'] = { vim.lsp.buf.implementation, "[G]o to [i]mplementations (LSP)" }
lvim.lsp.buffer_mappings.normal_mode['gr'] = { vim.lsp.buf.references, "[G]o to [r]eferences (LSP)" }
lvim.lsp.buffer_mappings.normal_mode['cr'] = { vim.lsp.buf.rename, "[G]o to [r]eferences (LSP)" }

local function remove_unused()
  local params = {
    command = "_typescript.RemoveUnused",
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = "Removed unused"
  }
  vim.lsp.buf.execute_command(params)
end


lvim.builtin.which_key.mappings["c"] = {
  name = "Code",
  --f = { "<Space>lj<Space>la1<CR>", "Fix all" },
  f = { "mF:%!eslint_d --stdin --fix-to-stdout<CR>`F", "Fix all" },
  x = { ":bd <CR>", "close buffer" },
  r = { remove_unused, "remove unused" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettierd",
    name = "prettier",
    filetypes = { "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "jsx",
      "mdx",
      "graphql", "gql", "prisma", "graphqls" },
  },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    name = "eslint",
    command = "eslint",
    filetypes = { "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "jsx", "mdx" },
  },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    name = "eslint",
    command = "eslint",
    filetypes = { "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "jsx", "mdx" },
    args = { "-f", "json", "--stdin", "--stdin-filename", "$FILENAME" }
  },

}


lvim.plugins = {
  { "jparise/vim-graphql" },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}


lvim.autocommands = {
  {
    "BufRead",                               -- see `:h autocmd-events`
    {                                        -- this table is passed verbatim as `opts` to `nvim_create_autocmd`
      pattern = { "*.prisma", "schema.ts" }, -- see `:h autocmd-events`
      command = "setfiletype graphql",
    }
  },
}
local util = require 'lspconfig.util'
local lsp = vim.lsp

local function fix_all(opts)
  opts = opts or {}

  local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, 'eslint')
  if eslint_lsp_client == nil then
    return
  end

  local request
  if opts.sync then
    request = function(bufnr, method, params)
      eslint_lsp_client.request_sync(method, params, nil, bufnr)
    end
  else
    request = function(bufnr, method, params)
      eslint_lsp_client.request(method, params, nil, bufnr)
    end
  end

  local bufnr = util.validate_bufnr(opts.bufnr or 0)
  request(0, 'workspace/executeCommand', {
    command = 'eslint.applyAllFixes',
    arguments = {
      {
        uri = vim.uri_from_bufnr(bufnr),
        version = lsp.util.buf_versions[bufnr],
      },
    },
  })
end

local root_file = {
  '.eslintrc',
  '.eslintrc.js',
  '.eslintrc.cjs',
  '.eslintrc.yaml',
  '.eslintrc.yml',
  '.eslintrc.json',
  'eslint.config.js',
}

return {
  default_config = {
    cmd = { 'vscode-eslint-language-server', '--stdio' },
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'vue',
      'svelte',
      'astro',
    },
    -- https://eslint.org/docs/user-guide/configuring/configuration-files#configuration-file-formats
    root_dir = function(fname)
      root_file = util.insert_package_json(root_file, 'eslintConfig', fname)
      return util.root_pattern(unpack(root_file))(fname)
    end,
    -- Refer to https://github.com/Microsoft/vscode-eslint#settings-options for documentation.
    settings = {
      validate = 'on',
      packageManager = 'npm',
      useESLintClass = false,
      experimental = {
        useFlatConfig = false,
      },
      codeActionOnSave = {
        enable = true,
        mode = 'all',
      },
      format = true,
      quiet = false,
      onIgnoredFiles = 'off',
      rulesCustomizations = {},
      run = 'onType',
      problems = {
        shortenToSingleLine = false,
      },
      -- nodePath configures the directory in which the eslint server should start its node_modules resolution.
      -- This path is relative to the workspace folder (root dir) of the server instance.
      nodePath = '',
      -- use the workspace folder location or the file location (if no workspace folder is open) as the working directory
      workingDirectory = { mode = 'location' },
      codeAction = {
        disableRuleComment = {
          enable = true,
          location = 'separateLine',
        },
        showDocumentation = {
          enable = true,
        },
      },
    },
    on_new_config = function(config, new_root_dir)
      -- The "workspaceFolder" is a VSCode concept. It limits how far the
      -- server will traverse the file system when locating the ESLint config
      -- file (e.g., .eslintrc).
      config.settings.workspaceFolder = {
        uri = new_root_dir,
        name = vim.fn.fnamemodify(new_root_dir, ':t'),
      }

      -- Support flat config
      if vim.fn.filereadable(new_root_dir .. '/eslint.config.js') == 1 then
        config.settings.experimental.useFlatConfig = true
      end

      -- Support Yarn2 (PnP) projects
      local pnp_cjs = util.path.join(new_root_dir, '.pnp.cjs')
      local pnp_js = util.path.join(new_root_dir, '.pnp.js')
      if util.path.exists(pnp_cjs) or util.path.exists(pnp_js) then
        config.cmd = vim.list_extend({ 'yarn', 'exec' }, config.cmd)
      end
    end,
    handlers = {
      ['eslint/openDoc'] = function(_, result)
        if not result then
          return
        end
        local sysname = vim.loop.os_uname().sysname
        if sysname:match 'Windows' then
          os.execute(string.format('start %q', result.url))
        elseif sysname:match 'Linux' then
          os.execute(string.format('xdg-open %q', result.url))
        else
          os.execute(string.format('open %q', result.url))
        end
        return {}
      end,
      ['eslint/confirmESLintExecution'] = function(_, result)
        if not result then
          return
        end
        return 4 -- approved
      end,
      ['eslint/probeFailed'] = function()
        vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
        return {}
      end,
      ['eslint/noLibrary'] = function()
        vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
        return {}
      end,
    },
  },
  commands = {
    EslintFixAll = {
      function()
        fix_all { sync = true, bufnr = 0 }
      end,
      description = 'Fix all eslint problems for this buffer',
    },
  },
  docs = {
    description = [[
https://github.com/hrsh7th/vscode-langservers-extracted

`vscode-eslint-language-server` is a linting engine for JavaScript / Typescript.
It can be installed via `npm`:

```sh
npm i -g vscode-langservers-extracted
```

`vscode-eslint-language-server` provides an `EslintFixAll` command that can be used to format a document on save:
```lua
lspconfig.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
```

See [vscode-eslint](https://github.com/microsoft/vscode-eslint/blob/55871979d7af184bf09af491b6ea35ebd56822cf/server/src/eslintServer.ts#L216-L229) for configuration options.

Messages handled in lspconfig: `eslint/openDoc`, `eslint/confirmESLintExecution`, `eslint/probeFailed`, `eslint/noLibrary`

Additional messages you can handle: `eslint/noConfig`
]],
  },
}

