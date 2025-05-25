-- GitHub Copilot
return {
    { "github/copilot.vim" },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        branch = "main",
        dependencies = {
            { "zbirenbaum/copilot.lua" },
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require("CopilotChat").setup({
                debug = false, -- Enable debugging
            })
        end,
    },
}
