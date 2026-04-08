return {
  -- Tell LazyVim which colorscheme to use
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin", -- NOT "catppuccin-macchiato"
    },
  },
  -- Configure Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha", -- specify the variant here
      custom_highlights = function(colors)
        return {
          -- Relative numbers (Greyish)
          LineNrAbove = { fg = "#a9a9a9" },
          LineNrBelow = { fg = "#a9a9a9" },
          -- Current line (Hot Pink/Purple)
          --CursorLineNr = { fg = "#ea9bc5", style = { "bold" } },
          CursorLineNr = { fg = colors.pink, style = { "bold" } },
        }
      end,
      transparent_background = true,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        harpoon = true,
        telescope = true,
        mason = true,
        noice = true,
        notify = true,
        which_key = true,
        fidget = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
  },
}
