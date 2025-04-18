{
  plugins.snacks = {
    enable = true;
    settings = {
      bigfile = { enabled = true; };
      dim = { enabled = true; };
      explorer = { enabled = true; };
      indent = { enabled = true; };
      picker = { enabled = true; };
    };
  };

  keymaps = [
    # Zen Mode
    {
      key = "<leader>z";
      action = ''lua Snacks.zen()'';
      options = { desc = "Toggle Zen Mode"; };
      mode = "n";
    }
    {
      key = "<leader>Z";
      action = ''lua Snacks.zen.zoom()'';
      options = { desc = "Toggle Zoom"; };
      mode = "n";
    }
    # Top Pickers & Explorer
    {
      key = "<leader><space>";
      action = ''lua Snacks.picker.smart()'';
      options = { desc = "Smart Find Files"; };
      mode = "n";
    }
    {
      key = "<leader>,";
      action = ''lua Snacks.picker.buffers()'';
      options = { desc = "Buffers"; };
      mode = "n";
    }
    {
      key = "<leader>/";
      action = ''lua Snacks.picker.grep()'';
      options = { desc = "Grep"; };
      mode = "n";
    }
    {
      key = "<leader>:";
      action = ''lua Snacks.picker.command_history()'';
      options = { desc = "Command History"; };
      mode = "n";
    }
    {
      key = "<leader>n";
      action = ''lua Snacks.picker.notifications()'';
      options = { desc = "Notification History"; };
      mode = "n";
    }
    {
      key = "<leader>e";
      action = ''lua Snacks.explorer()'';
      options = { desc = "File Explorer"; };
      mode = "n";
    }
    # Find
    {
      key = "<leader>fb";
      action = ''lua Snacks.picker.buffers()'';
      options = { desc = "Buffers"; };
      mode = "n";
    }
    {
      key = "<leader>fc";
      action = ''lua Snacks.picker.files({ cwd = vim.fn.stdpath("config") })'';
      options = { desc = "Find Config File"; };
      mode = "n";
    }
    {
      key = "<leader>ff";
      action = ''lua Snacks.picker.files()'';
      options = { desc = "Find Files"; };
      mode = "n";
    }
    {
      key = "<leader>fg";
      action = ''lua Snacks.picker.git_files()'';
      options = { desc = "Find Git Files"; };
      mode = "n";
    }
    {
      key = "<leader>fp";
      action = ''lua Snacks.picker.projects()'';
      options = { desc = "Projects"; };
      mode = "n";
    }
    {
      key = "<leader>fr";
      action = ''lua Snacks.picker.recent()'';
      options = { desc = "Recent"; };
      mode = "n";
    }
    # Git
    {
      key = "<leader>gb";
      action = ''lua Snacks.picker.git_branches()'';
      options = { desc = "Git Branches"; };
      mode = "n";
    }
    {
      key = "<leader>gl";
      action = ''lua Snacks.picker.git_log()'';
      options = { desc = "Git Log"; };
      mode = "n";
    }
    {
      key = "<leader>gL";
      action = ''lua Snacks.picker.git_log_line()'';
      options = { desc = "Git Log Line"; };
      mode = "n";
    }
    {
      key = "<leader>gs";
      action = ''lua Snacks.picker.git_status()'';
      options = { desc = "Git Status"; };
      mode = "n";
    }
    {
      key = "<leader>gS";
      action = ''lua Snacks.picker.git_stash()'';
      options = { desc = "Git Stash"; };
      mode = "n";
    }
    {
      key = "<leader>gd";
      action = ''lua Snacks.picker.git_diff()'';
      options = { desc = "Git Diff (Hunks)"; };
      mode = "n";
    }
    {
      key = "<leader>gf";
      action = ''lua Snacks.picker.git_log_file()'';
      options = { desc = "Git Log File"; };
      mode = "n";
    }
    # Grep
    {
      key = "<leader>sb";
      action = ''lua Snacks.picker.lines()'';
      options = { desc = "Buffer Lines"; };
      mode = "n";
    }
    {
      key = "<leader>sB";
      action = ''lua Snacks.picker.grep_buffers()'';
      options = { desc = "Grep Open Buffers"; };
      mode = "n";
    }
    {
      key = "<leader>sg";
      action = ''lua Snacks.picker.grep()'';
      options = { desc = "Grep"; };
      mode = "n";
    }
    {
      key = "<leader>sw";
      action = ''lua Snacks.picker.grep_word()'';
      options = { desc = "Visual selection or word"; };
      mode = [ "n" "x" ];
    }
    # Search
    {
      key = "<leader>s\"";
      action = ''lua Snacks.picker.registers()'';
      options = { desc = "Registers"; };
      mode = "n";
    }
    {
      key = "<leader>s/";
      action = ''lua Snacks.picker.search_history()'';
      options = { desc = "Search History"; };
      mode = "n";
    }
    {
      key = "<leader>sa";
      action = ''lua Snacks.picker.autocmds()'';
      options = { desc = "Autocmds"; };
      mode = "n";
    }
    {
      key = "<leader>sc";
      action = ''lua Snacks.picker.command_history()'';
      options = { desc = "Command History"; };
      mode = "n";
    }
    {
      key = "<leader>sC";
      action = ''lua Snacks.picker.commands()'';
      options = { desc = "Commands"; };
      mode = "n";
    }
    {
      key = "<leader>sd";
      action = ''lua Snacks.picker.diagnostics()'';
      options = { desc = "Diagnostics"; };
      mode = "n";
    }
    {
      key = "<leader>sD";
      action = ''lua Snacks.picker.diagnostics_buffer()'';
      options = { desc = "Buffer Diagnostics"; };
      mode = "n";
    }
    {
      key = "<leader>sh";
      action = ''lua Snacks.picker.help()'';
      options = { desc = "Help Pages"; };
      mode = "n";
    }
    {
      key = "<leader>sH";
      action = ''lua Snacks.picker.highlights()'';
      options = { desc = "Highlights"; };
      mode = "n";
    }
    {
      key = "<leader>si";
      action = ''lua Snacks.picker.icons()'';
      options = { desc = "Icons"; };
      mode = "n";
    }
    {
      key = "<leader>sj";
      action = ''lua Snacks.picker.jumps()'';
      options = { desc = "Jumps"; };
      mode = "n";
    }
    {
      key = "<leader>sk";
      action = ''lua Snacks.picker.keymaps()'';
      options = { desc = "Keymaps"; };
      mode = "n";
    }
    {
      key = "<leader>sl";
      action = ''lua Snacks.picker.loclist()'';
      options = { desc = "Location List"; };
      mode = "n";
    }
    {
      key = "<leader>sm";
      action = ''lua Snacks.picker.marks()'';
      options = { desc = "Marks"; };
      mode = "n";
    }
    {
      key = "<leader>sM";
      action = ''lua Snacks.picker.man()'';
      options = { desc = "Man Pages"; };
      mode = "n";
    }
    {
      key = "<leader>sp";
      action = ''lua Snacks.picker.lazy()'';
      options = { desc = "Search for Plugin Spec"; };
      mode = "n";
    }
    {
      key = "<leader>sq";
      action = ''lua Snacks.picker.qflist()'';
      options = { desc = "Quickfix List"; };
      mode = "n";
    }
    {
      key = "<leader>sR";
      action = ''lua Snacks.picker.resume()'';
      options = { desc = "Resume"; };
      mode = "n";
    }
    {
      key = "<leader>su";
      action = ''lua Snacks.picker.undo()'';
      options = { desc = "Undo History"; };
      mode = "n";
    }
    {
      key = "<leader>uC";
      action = ''lua Snacks.picker.colorschemes()'';
      options = { desc = "Colorschemes"; };
      mode = "n";
    }
    # LSP
    {
      key = "gd";
      action = ''lua Snacks.picker.lsp_definitions()'';
      options = { desc = "Goto Definition"; };
      mode = "n";
    }
    {
      key = "gD";
      action = ''lua Snacks.picker.lsp_declarations()'';
      options = { desc = "Goto Declaration"; };
      mode = "n";
    }
    {
      key = "gr";
      action = ''lua Snacks.picker.lsp_references()'';
      options = { desc = "References"; nowait = true; };
      mode = "n";
    }
    {
      key = "gI";
      action = ''lua Snacks.picker.lsp_implementations()'';
      options = { desc = "Goto Implementation"; };
      mode = "n";
    }
    {
      key = "gy";
      action = ''lua Snacks.picker.lsp_type_definitions()'';
      options = { desc = "Goto T[y]pe Definition"; };
      mode = "n";
    }
    {
      key = "<leader>ss";
      action = ''lua Snacks.picker.lsp_symbols()'';
      options = { desc = "LSP Symbols"; };
      mode = "n";
    }
    {
      key = "<leader>sS";
      action = ''lua Snacks.picker.lsp_workspace_symbols()'';
      options = { desc = "LSP Workspace Symbols"; };
      mode = "n";
    }
    # Toggle Mappings from init
    {
      key = "<leader>us";
      action = ''lua Snacks.toggle.option("spell", { name = "Spelling" })()'';
      options = { desc = "Toggle Spelling"; };
      mode = "n";
    }
    {
      key = "<leader>uw";
      action = ''lua Snacks.toggle.option("wrap", { name = "Wrap" })()'';
      options = { desc = "Toggle Wrap"; };
      mode = "n";
    }
    {
      key = "<leader>uL";
      action = ''lua Snacks.toggle.option("relativenumber", { name = "Relative Number" })()'';
      options = { desc = "Toggle Relative Number"; };
      mode = "n";
    }
    {
      key = "<leader>ud";
      action = ''lua Snacks.toggle.diagnostics()'';
      options = { desc = "Toggle Diagnostics"; };
      mode = "n";
    }
    {
      key = "<leader>ul";
      action = ''lua Snacks.toggle.line_number()'';
      options = { desc = "Toggle Line Number"; };
      mode = "n";
    }
    {
      key = "<leader>uc";
      action = ''lua Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })()'';
      options = { desc = "Toggle Conceallevel"; };
      mode = "n";
    }
    {
      key = "<leader>uT";
      action = ''lua Snacks.toggle.treesitter()'';
      options = { desc = "Toggle Treesitter"; };
      mode = "n";
    }
    {
      key = "<leader>ub";
      action = ''lua Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" })()'';
      options = { desc = "Toggle Dark Background"; };
      mode = "n";
    }
    {
      key = "<leader>uh";
      action = ''lua Snacks.toggle.inlay_hints()'';
      options = { desc = "Toggle Inlay Hints"; };
      mode = "n";
    }
    {
      key = "<leader>ug";
      action = ''lua Snacks.toggle.indent()'';
      options = { desc = "Toggle Indent"; };
      mode = "n";
    }
    {
      key = "<leader>uD";
      action = ''lua Snacks.toggle.dim()'';
      options = { desc = "Toggle Dim"; };
      mode = "n";
    }
  ];

  extraConfigLua = ''
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command
      end,
    })
  '';
}
