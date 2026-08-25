if _G.FlashbangLoaded then
    return
end

vim.api.nvim_create_augroup("Flashbang", { clear = true })

vim.api.nvim_create_autocmd("ColorScheme", {
    group = "Flashbang",
    callback = function(args)
        if vim.tbl_contains(vim.fn.getcompletion("", "color"), args.match) then
            _G.Flashbang.current_theme = args.match
            _G.Flashbang.current_background = vim.o.background
        end
    end,
})

_G.FlashbangLoaded = true
