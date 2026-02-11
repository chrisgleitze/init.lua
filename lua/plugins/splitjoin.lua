-- join and split code block
return {
    'nvim-mini/mini.splitjoin',
    keys = {
        {
            '<leader>sj',
            function()
                require('mini.splitjoin').toggle()
            end,
        },
    },
}
