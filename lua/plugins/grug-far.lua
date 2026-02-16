-- find and replace plugin
return {
    {
        'MagicDuck/grug-far.nvim',
        cmd = 'GrugFar',
        keys = {
            {
                '<leader>gf',
                function()
                    local grug = require('grug-far')
                    grug.open({ transient = true })
                end,
                desc = 'GrugFar',
                mode = { 'n', 'v' },
            },
        },
        opts = {
            folding = { enabled = false },
            -- don't numerate the result list
            resultLocation = { showNumberLabel = false },
        },
    },
}
