if vim.g.loaded_keysound then
  return
end
vim.g.loaded_keysound = true

vim.api.nvim_create_user_command("KeySound", function(args)
  local keysound = require("keysound")
  if args.args == "toggle" then
    keysound.toggle()
  elseif args.args == "on" then
    keysound.enable()
  elseif args.args == "off" then
    keysound.disable()
  elseif args.args == "status" then
    vim.notify("KeySound: " .. keysound.status())
  end
end, {
  nargs = 1,
  complete = function()
    return { "toggle", "on", "off", "status" }
  end,
})
