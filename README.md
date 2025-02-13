# nvim-tms

super simple tmux sessionizer integration to nvim.

## Requirements: 
Must have: [tms]("https://github.com/jrmoulton/tmux-sessionizer")  or another tmux sessionizer script **NOTE:tms is the only tested command.  As no one else will probably use this.**

**SEE USAGE FOR ALTERNATIVE**

## Basic Usage: 
Pass the other command into setup as:
```lua
{ cmd = "your other command" }
-- defaults to "tms"
```
Default keymap is "<leader>t", configure using keymap option
```lua
{ keymap = "<leader>t" }
```

```lua
return {
    "cjodo/nvim-tms",
    config = function()
        require("nvim-tms").setup({})
    end
}
```
then in nvim you can use :NvimTms to toggle the terminal, or <leader>t.

The terminal will open in tms
The same command will close the terminal

### Extra:

In theory, this plugin will work for most tui's.  But because I kinda just hacked this together for myself one day, there are no promises.

- For example changing `{ cmd = "lazygit" }` will open a terminal with an instance of lazygit and it'll work fine as long as you're in an existing git repo.

Thanks :)
