local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Tab Settings (These can stay here, but usually go in options.lua)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.keymap.set({ "n", "v" }, "=", function()
    vim.lsp.buf.format()
end)

require("lazy").setup({
    spec = {
        -- 1. Import LazyVim core
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- 2. Import your own plugins from lua/plugins/*.lua
        { import = "plugins" },
    },
    defaults = {
        lazy = false,
        version = false,
    },
    -- Configure how lazy.nvim installs itself
    install = {
        colorscheme = { "catppuccin", "tokyonight", "habamax" },
    },
    checker = {
        enabled = true,
        notify = false,
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
