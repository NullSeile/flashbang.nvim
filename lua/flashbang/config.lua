local Config = {}

--- Flashbang configuration with its default values.
---
---@type table
--- Default values:
---@eval return MiniDoc.afterlines_to_code(MiniDoc.current.eval_section)
Config.options = {
    enabled = true,
    min_interval = 5,
    max_interval = 20,
    duration = 2.5,
    light_theme = "delek",
}

---@private
local defaults = vim.deepcopy(Config.options)

--- Defaults Flashbang options by merging user provided options with the default plugin values.
---
---@param options table Module config table. See |Flashbang.options|.
---
---@private
function Config.defaults(options)
    Config.options = vim.deepcopy(vim.tbl_deep_extend("keep", options or {}, defaults or {}))

    assert(type(Config.options.min_interval) == "number", "`min_interval` must be a number.")
    assert(type(Config.options.max_interval) == "number", "`max_interval` must be a number.")
    assert(type(Config.options.duration) == "number", "`duration` must be a number.")

    return Config.options
end

--- Define your flashbang setup.
---
---@param options table Module config table. See |Flashbang.options|.
---
---@usage `require("flashbang").setup()` (add `{}` with your |Flashbang.options| table)
function Config.setup(options)
    Config.options = Config.defaults(options or {})
    return Config.options
end

return Config
