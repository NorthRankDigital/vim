require("toggleterm").setup{
  size = 20, -- Default size for the terminal window
  open_mapping = [[<c-\>]], -- Keybinding to toggle the terminal
  shade_terminals = true, -- Shade the terminal background
  shading_factor = 2, -- Set the shading factor
  direction = 'horizontal', -- Terminal direction ('horizontal', 'vertical', 'tab', or 'float')
  close_on_exit = true, -- Close the terminal window when the process exits
  shell = vim.o.shell, -- Default shell to use
  start_in_insert = true -- Start terminal in insert mode
}
