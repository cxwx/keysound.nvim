local M = {}

local source = debug.getinfo(1, "S").source:sub(2)
local plugin_root = source:match("(.*)/(.*)/(.*)/(.*)")
  or vim.fn.expand("~/.local/share/nvim/lazy/keysound.nvim/") .. "/"

M._enabled = false
M._ns = vim.api.nvim_create_namespace("keysound")
M._config = {
  sound_dir = plugin_root .. "/sound/mario/",
  sounds = {
    default = "default.mp3",
    enter = "enter.mp3",
  },
}

local function get_sound(key)
  if key == "\r" or key == "\13" then
    return M._config.sounds.enter
  end
  return M._config.sounds.default
end

local function play_sound(file)
  if not file or file == "" then
    return
  end
  local full = M._config.sound_dir .. file
  if vim.fn.filereadable(full) ~= 1 then
    return
  end
  vim.fn.jobstart({ "afplay", full }, { detach = true })
end

local function on_key_fn(key)
  if not M._enabled then
    return
  end
  local mode = vim.api.nvim_get_mode().mode
  if mode ~= "i" then
    return
  end
  if key == "" then
    return
  end
  local sound = get_sound(key)
  play_sound(sound)
end

local function attach()
  vim.on_key(on_key_fn, M._ns, { buf_local = false })
end

local function detach()
  vim.on_key(nil, M._ns)
end

function M.setup(opts)
  opts = opts or {}
  if opts.sound_dir then
    M._config.sound_dir = opts.sound_dir
  end
  if opts.sounds then
    M._config.sounds = vim.tbl_extend("force", M._config.sounds, opts.sounds)
  end
  if M._config.sound_dir and not M._config.sound_dir:match("/$") then
    M._config.sound_dir = M._config.sound_dir .. "/"
  end
  if opts.enabled ~= false then
    M.enable()
  end
end

function M.toggle()
  if M._enabled then
    M.disable()
  else
    M.enable()
  end
end

function M.enable()
  if M._enabled then
    return
  end
  M._enabled = true
  attach()
end

function M.disable()
  if not M._enabled then
    return
  end
  M._enabled = false
  detach()
end

function M.is_enabled()
  return M._enabled
end

function M.status()
  return M._enabled and "on" or "off"
end

return M
