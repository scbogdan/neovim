-- Luacheck configuration for Neovim
std = "luajit"

-- Neovim global variables
globals = {
    "vim",
}

-- Read-only globals (these shouldn't be modified)
read_globals = {
    "vim",
}

-- Ignore specific warnings
ignore = {
    "212", -- Unused argument (we'll fix these case by case)
}

-- File-specific configurations
files = {
    -- Plugin files can use vim global extensively
    ["lua/plugins/*.lua"] = {
        globals = { "vim" },
    },
    -- Init file
    ["init.lua"] = {
        globals = { "vim" },
    },
}

-- Line length limit
max_line_length = 140

-- Allow unused arguments starting with underscore
unused_args = false
