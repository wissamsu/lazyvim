local Snacks = require("snacks")
local dap = require("dap")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- SNACKS.NVIM MAPPINGS
-- vim.keymap.set("n", "<leader>th", function()
vim.keymap.set("n", "<leader>ft", function()
  require("nvchad.term").toggle({ pos = "float" })
end, { desc = "float term" })

vim.keymap.set("n", "<leader>df", ":lua add_notebook_cell()<CR>", { noremap = true, silent = true })
-- Normal mode: Tab = next buffer, Shift+Tab = previous buffer
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { desc = "Next Buffer", noremap = true, silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { desc = "Previous Buffer", noremap = true, silent = true })

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Dap Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Dap Continue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Dap Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Dap Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Dap Step Out" })
vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Dap Terminate" })
vim.keymap.set("n", "<leader>da", dap.clear_breakpoints, { desc = "Dap Clear Breakpoints" })
vim.keymap.set("n", "<leader>x", "<cmd>bdelete<cr>", { silent = true })
vim.keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

map("n", "<leader>ww", ":tabNext<CR>", { desc = "Next Tab Command" })
map("n", "<leader>lr", ":Leet run<CR>", { desc = "Run Leet command" })
map("n", "<leader>ls", ":Leet submit<CR>", { desc = "Run Submit command" })
-- ======== PICKERS ========
map("n", "<leader>ff", function()
  Snacks.picker.files()
end, { desc = "Snacks Files" })
map("n", "<leader>fw", function()
  Snacks.picker.grep()
end, { desc = "Snacks Live Grep" })
map("n", "<leader>fb", function()
  Snacks.picker.buffers()
end, { desc = "Snacks Buffers" })
map("n", "<leader>fr", function()
  Snacks.picker.recent()
end, { desc = "Snacks Recent Files" })
map("n", "<leader>fs", function()
  Snacks.picker.lsp_symbols()
end, { desc = "Snacks LSP Symbols" })
map("n", "<leader>fd", function()
  Snacks.picker.diagnostics()
end, { desc = "Snacks Diagnostics" })

map("n", "<leader>e", function()
  Snacks.explorer.toggle()
end, { desc = "Snacks Explorer Toggle" })

map("n", "]g", function()
  Snacks.git.hunk_next()
end, { desc = "Next Git Hunk" })
map("n", "[g", function()
  Snacks.git.hunk_prev()
end, { desc = "Prev Git Hunk" })

map("n", "gs", function()
  Snacks.git.hunk_stage()
end, { desc = "Stage Hunk" })
map("n", "gr", function()
  Snacks.git.hunk_reset()
end, { desc = "Reset Hunk" })
map("n", "gp", function()
  Snacks.git.hunk_preview()
end, { desc = "Preview Hunk" })

map("n", "gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })

map("n", "<leader>gd", function()
  Snacks.git.diff()
end, { desc = "Snacks Diff" })
map("n", "<leader>gh", function()
  Snacks.git.log_file()
end, { desc = "Snacks File History" })
map("n", "<leader>gc", function()
  Snacks.git.log()
end, { desc = "Snacks Git Log" })

map("n", "<leader>sn", function()
  Snacks.notifier.show_history()
end, { desc = "Notifications History" })
map("n", "<leader>sN", function()
  Snacks.notifier.dismiss()
end, { desc = "Dismiss Notifications" })

map("n", "<leader>sw", function()
  Snacks.words.toggle()
end, { desc = "Toggle Word Highlights" })

map("n", "<leader>sp", function()
  Snacks.profiler.open()
end, { desc = "Snacks Startup Profiler" })

function _G.add_notebook_cell()
  local row = vim.api.nvim_win_get_cursor(0)[1] -- current line
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local max_d = 0

  -- scan the buffer for existing # %% nD cells
  for _, line in ipairs(lines) do
    local n = string.match(line, "# %%%% (%d+)D")
    if n then
      n = tonumber(n)
      if n > max_d then
        max_d = n
      end
    end
  end

  local next_d = max_d + 1
  local new_line = "# %% " .. next_d .. "D"

  -- insert new line after current row
  vim.api.nvim_buf_set_lines(0, row, row, false, { new_line })
  -- move cursor to the new line
  vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
end

--crates.nvim
vim.keymap.set("n", "<leader>cde", ":Crates show_dependencies_popup<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cr", ":Crates open_repository<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cu", ":Crates upgrade_all_crates<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ct", ":Crates toggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cd1", ":Crates open_documentation<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cd2", ":Crates open_cratesio<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cv", ":Crates show_versions_popup<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>cf", ":Crates show_features_popup<CR>", { noremap = true, silent = true })

--dap color fixes
-- Normal breakpoint: red dot
vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" })

-- Reached/verified breakpoint: green dot
vim.cmd("hi DapBreakpointColor2 guifg=#32a852")
vim.fn.sign_define("DapStopped", { text = "➜", texthl = "DapBreakpointColor2", linehl = "", numhl = "" })

-- Optional: conditional breakpoint (orange)
vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.fn.sign_define("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointColor2", linehl = "", numhl = "" })

-- Optional: rejected breakpoint (gray)
vim.cmd("hi DapBreakpointColor guifg=#fa4848")
vim.fn.sign_define("DapBreakpointRejected", { text = "●", texthl = "DapBreakpointColor2", linehl = "", numhl = "" })

local ok, comment = pcall(require, "Comment")
if not ok then
  return
end

-- Setup Comment.nvim
comment.setup()

vim.keymap.set("n", "<C-c>", function()
  -- Select entire file and copy to system clipboard
  vim.cmd('normal! ggVG"+y')
  print("Entire file copied to clipboard!")
end, { desc = "Copy Entire File" })

-- Normal mode: toggle current line
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Toggle comment line" })

-- Visual mode: toggle selection correctly
vim.keymap.set("x", "<leader>/", function()
  require("Comment.api").toggle.linewise(vim.fn.mode())
end, { desc = "Toggle comment selection" })
