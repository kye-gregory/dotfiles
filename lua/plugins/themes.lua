return {
    {
        'bettervim/yugen.nvim',
        priority = 1000,
        config = function()
            vim.cmd.colorscheme('yugen')
        end
    },

    {'nyoom-engineering/oxocarbon.nvim'} 
}
