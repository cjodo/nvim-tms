local state = {
	floating = {
		buf = -1,
		win= -1
	}
}

local default_opts = {
	cmd = "tms",
	keymap = "<leader>t"
}

local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil

	if vim.api.nvim_buf_is_valid(opts.buf) then
		buf = opts.buf
	else
		buf = vim.api.nvim_create_buf(false, true)
	end

  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

	return {
		buf = buf,
		win = win
	}
end

local toggle_terminal = function(opts)
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
			vim.defer_fn(function()
				vim.fn.chansend(vim.bo[state.floating.buf].channel, opts.cmd .. "\n")
				vim.api.nvim_set_current_win(state.floating.win)
				vim.cmd("startinsert!")
			end, 100)
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

local M = {}

M.setup = function (opts)
	opts = opts or default_opts

	vim.keymap.set("t", "qq", "<c-\\><c-n>")
	vim.api.nvim_create_user_command("TmsNvim", function ()
		toggle_terminal(opts)
	end, {})

	vim.keymap.set({"n", "t"}, opts.keymap or default_opts.keymap, function ()
		toggle_terminal(opts)
	end)
end

return M
