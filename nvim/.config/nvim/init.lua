vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
vim.o.showmode = false
vim.o.ruler = false
vim.o.laststatus = 3
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.completeopt = "menuone,noselect,popup,fuzzy"
vim.o.scrolloff = 8

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.pack.add({
  "https://github.com/ibhagwan/fzf-lua",
  "https://github.com/nvim-tree/nvim-tree.lua",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/Mofiqul/dracula.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
  "https://github.com/nvim-mini/mini.pairs",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/folke/noice.nvim",
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, { confirm = false })

vim.cmd.colorscheme("dracula")

require("nvim-web-devicons").setup({ color_icons = false })

local fzf = require("fzf-lua")
fzf.setup({})

require("nvim-tree").setup({ view = { width = 40 } })

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("UserTreeStartup", { clear = true }),
  callback = function()
    local api = require("nvim-tree.api")
    local skip = #vim.api.nvim_list_uis() == 0
      or vim.bo.buftype ~= ""
      or vim.tbl_contains({ "gitcommit", "gitrebase" }, vim.bo.filetype)
      or api.tree.is_visible()
    if not skip then
      api.tree.toggle({ focus = false })
    end
  end,
})

require("lualine").setup({
  options = {
    theme = "dracula-nvim",
    globalstatus = true,
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_c = { { "filename", path = 1 } },
    lualine_x = {
      {
        function() return require("noice").api.status.command.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
        color = "Statement",
      },
      {
        function() return require("noice").api.status.mode.get() end,
        cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
        color = "Constant",
      },
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})

require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "%d+L, %d+B" },
          { find = "; after #%d+" },
          { find = "; before #%d+" },
        },
      },
      view = "mini",
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
  },
})

require("which-key").setup({
  preset = "helix",
  spec = {
    { "<leader>f", group = "file/find" },
    { "<leader>s", group = "search" },
    { "<leader>q", group = "quit" },
    { "<leader>w", group = "windows" },
  },
})

require("gitsigns").setup({})
require("mini.pairs").setup({})

require("nvim-treesitter").install({
  "css", "go", "gomod", "gosum", "html", "javascript", "json", "lua",
  "markdown", "markdown_inline", "tsx", "typescript", "vim", "vimdoc", "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("UserTreesitter", { clear = true }),
  callback = function(event)
    pcall(vim.treesitter.start, event.buf)
  end,
})

vim.diagnostic.config({ virtual_text = true, severity_sort = true })

vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { "go.work", "go.mod", ".git" },
})

vim.lsp.config("vtsls", {
  cmd = { "vtsls", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { library = { vim.env.VIMRUNTIME }, checkThirdParty = false },
    },
  },
})

vim.lsp.enable({ "gopls", "vtsls", "lua_ls" })

require("conform").setup({
  formatters_by_ft = {
    go = { lsp_format = "prefer" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
  },
  formatters = { prettier = { require_cwd = true } },
  format_on_save = { timeout_ms = 1000 },
  notify_no_formatters = false,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLsp", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, desc = "Go to definition" })
  end,
})

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })
vim.keymap.set("n", "<leader><space>", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", fzf.git_files, { desc = "Find git files" })
vim.keymap.set("n", "<leader>/", fzf.live_grep, { desc = "Search text in project" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep, { desc = "Search text in project" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set("n", "<leader>|", "<C-w>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>-", "<C-w>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-w>c", { desc = "Delete window", remap = true })
