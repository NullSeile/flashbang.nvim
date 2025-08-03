local config = require("flashbang.config")
local sound = require("flashbang.sound")

local Flashbang = {}

local function deploy()
    local duration = _G.Flashbang.config.duration * 1000
    sound.play("flashbang")
    local timer = vim.uv.new_timer()
    local current = vim.g.colors_name
    timer:start(
        1300,
        0,
        vim.schedule_wrap(function()
            vim.cmd("colorscheme " .. _G.Flashbang.config.light_theme)
            vim.cmd("set background=light")
            timer:start(
                duration,
                0,
                vim.schedule_wrap(function()
                    vim.cmd("colorscheme " .. current)
                    vim.cmd("set background=dark")
                end)
            )
        end)
    )
end
Flashbang.deploy = deploy

function Flashbang.setup(opts)
    _G.Flashbang.config = config.setup(opts)

    vim.api.nvim_create_user_command("FlashbangDeploy", function()
        deploy()
    end, { desc = "Deploy a flashbang" })

    sound.detect_provider()

    local min_interval = _G.Flashbang.config.min_interval * 1000 * 60
    local max_interval = _G.Flashbang.config.max_interval * 1000 * 60

    local timer = vim.uv.new_timer()
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
