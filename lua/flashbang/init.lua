local config = require("flashbang.config")
local sound = require("flashbang.sound")

local Flashbang = {}

function Flashbang.setup(opts)
    _G.Flashbang.config = config.setup(opts)

    sound.detect_provider()

    local min_interval = _G.Flashbang.config.min_interval * 1000 * 60
    local max_interval = _G.Flashbang.config.max_interval * 1000 * 60
    local duration = _G.Flashbang.config.duration * 1000

    local function deploy()
        sound.play("flashbang")
        local timer = vim.loop.new_timer()

        timer:start(
            1300,
            0,
            vim.schedule_wrap(function()
                vim.cmd("colorscheme delek")
                vim.cmd("set background=light")
                timer:start(
                    duration,
                    0,
                    vim.schedule_wrap(function()
                        vim.cmd("colorscheme gruvbox")
                        vim.cmd("set background=dark")
                    end)
                )
            end)
        )
    end
    -- deploy()

    local timer = vim.loop.new_timer()
    local function recurring_deploy()
        timer:start(
            math.random(min_interval, max_interval),
            0,
            vim.schedule_wrap(function()
                deploy()
                recurring_deploy()
            end)
        )
    end
    recurring_deploy()
end

_G.Flashbang = Flashbang

return _G.Flashbang
