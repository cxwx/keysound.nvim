# keysound.nvim

Neovim 按键音效插件 — 在插入模式下为每次按键播放音效。

## 安装

### lazy.nvim

```lua
{
  "cxwx/keysound.nvim",
  keys = {
    { "<leader>ts", function() require("keysound").toggle() end, desc = "Toggle KeySound" },
  },
  opts = {
    sound_dir = vim.fn.expand("~/.config/nvim/sounds/"),
  },
}
```

或者使用 `cmd` 触发：

```lua
{
  "cxwx/keysound.nvim",
  cmd = "KeySound",
  opts = {
    sound_dir = vim.fn.expand("~/.config/nvim/sounds/"),
  },
}
```

## 配置

```lua
require("keysound").setup({
  -- 音效文件目录（必须以 / 结尾，否则自动补全）
  sound_dir = "/path/to/sounds/",

  -- 自定义音效文件名
  sounds = {
    default = "default.mp3",  -- 普通按键
    enter = "enter.mp3",      -- 回车键
  },

  -- 是否默认启用（默认 true）
  enabled = true,
})
```

### 音效文件

在 `sound_dir` 目录下放置两个 mp3 文件：

- `default.mp3` — 普通按键音效
- `enter.mp3` — 回车键音效

## 使用

### 命令

| 命令 | 说明 |
|------|------|
| `:KeySound toggle` | 切换开关 |
| `:KeySound on` | 开启 |
| `:KeySound off` | 关闭 |
| `:KeySound status` | 查看状态 |

### Lua API

```lua
local keysound = require("keysound")

keysound.toggle()      -- 切换开关
keysound.enable()      -- 开启
keysound.disable()     -- 关闭
keysound.is_enabled()  -- 返回 boolean
keysound.status()      -- 返回 "on" 或 "off"
```

### 推荐快捷键

```lua
vim.keymap.set("n", "<leader>ts", function() require("keysound").toggle() end, { desc = "Toggle KeySound" })
```

## 系统要求

- Neovim 0.10+
- macOS（使用 `afplay` 播放音效）

## 开发

本插件由 Mimo 开发。

## License

MIT
