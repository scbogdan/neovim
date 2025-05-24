-- Colorschemes
return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        opts = {
            variant = "main",      -- auto, main, main, or dawn
            dark_variant = "main", -- main, main, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            styles = {
                bold = false,
                italic = true,
                transparency = true,
            },
        },
        config = function()
            -- You can configure catppuccin here if needed
            vim.cmd.colorscheme("habamax")
        end,
    },
}
