[![copy.gif](https://s3.gifyu.com/images/copy.gif)](https://gifyu.com/image/tBwL)

Copy and paste with system clipboard using
[wl-clipboard](https://github.com/bugaevc/wl-clipboard).

## Requirements

- [wl-clipboard](https://github.com/bugaevc/wl-clipboard)

## Installation

### Install using xpm.xplr

```lua
require("xpm").setup({
  ---
  { name = "sayanarijit/wl-clipboard.xplr" }
  ---
})
```

### Install manually

- Add the following line in `~/.config/xplr/init.lua`

  ```lua
  local home = os.getenv("HOME")
  package.path = home
  .. "/.config/xplr/plugins/?/init.lua;"
  .. home
  .. "/.config/xplr/plugins/?.lua;"
  .. package.path
  ```

- Clone the plugin

  ```bash
  mkdir -p ~/.config/xplr/plugins

  git clone https://github.com/sayanarijit/wl-clipboard.xplr ~/.config/xplr/plugins/wl-clipboard
  ```

- Require the module in `~/.config/xplr/init.lua`

  ```lua
  require("wl-clipboard").setup()

  -- Or

  require("wl-clipboard").setup{
    copy_command = "wl-copy",
    paste_command = "wl-paste",
    keep_selection = false,
  }

  -- Type `yy` to copy and `p` to paste files.
