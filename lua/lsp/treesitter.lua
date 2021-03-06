require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    -- ignore_install = {"javascript"}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {"yaml"} -- list of language that will be disabled
        -- additional_vim_regex_highlighting = true
    },
    indent = {enable = true},
    autotag = {enable = true},
    incremental_selection = {enable = true}
}
