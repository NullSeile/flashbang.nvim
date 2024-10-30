local Flashbang = {}

--- Flashbang configuration with its default values.
---
---@type table
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
Flashbang.options = {
    min_interval = 5,
    max_interval = 20,
    duration = 2.5,
}

---@private
local defaults = vim.deepcopy(Flashbang.options)

--- Defaults Flashbang options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |Flashbang.options|.
---
---@private
function Flashbang.defaults(options)
    Flashbang.options = vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    assert(type(Flashbang.options.min_interval) == "number", "`min_interval` must be a number.")
    assert(type(Flashbang.options.max_interval) == "number", "`max_interval` must be a number.")
    assert(type(Flashbang.options.duration) == "number", "`duration` must be a number.")

    return Flashbang.options
end

--- Define your flashbang setup.
---
---@param options table Module config table. See |Flashbang.options|.
---
---@usage `require("flashbang").setup()` (add `{}` with your |Flashbang.options| table)
function Flashbang.setup(options)
    Flashbang.options = Flashbang.defaults(options or {})
    return Flashbang.options
end

return Flashbang
