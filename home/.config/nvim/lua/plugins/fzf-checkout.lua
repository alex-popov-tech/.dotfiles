return function()
    vim.g.fzf_branch_actions = {
        checkout = {
            execute = 'echo system("{git} checkout " . (empty("{branch}") ? "-b {input}" : "{branch}"))',
            required = {}
        }
    }
    vim.cmd("cnoreabbrev gb GBranches")
end
