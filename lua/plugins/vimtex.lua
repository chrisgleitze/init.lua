return {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
    init = function()
        vim.g.vimtex_compiler_method = 'latexmk'
    end,
}
