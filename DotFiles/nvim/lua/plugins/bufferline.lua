return {
    "akinsho/bufferline.nvim",
    opts = function()
        local mocha = require("catppuccin.palettes").get_palette("mocha")
        return {
            highlights = {
                buffer_selected = { fg = mocha.base, bg = mocha.mauve, bold = true, italic = false },
                indicator_selected = { fg = mocha.mauve, bg = mocha.mauve },
                tab_selected = { fg = mocha.base, bg = mocha.mauve },
                close_button_selected = { fg = mocha.base, bg = mocha.mauve },
            },
            options = {
                indicator = { style = "none" },
            },
        }
    end,
}
