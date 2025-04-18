{ pkgs, ... }: {
  imports = [
    ./conform.nix
    ./gitsigns.nix
    ./lsp.nix
    ./lualine.nix
    ./number-toggle.nix
    ./nvim-cmp.nix
    ./nvim-surround.nix
    ./rustaceanvim.nix
    # We disable this while the plugin is far behind current version and 
    # doesn't support e.g. Picker.
    # ./snacks.nvim.nix
    ./todo-comments.nix
    ./treesitter.nix
    ./which-key.nix

  ];

  # You can easily change to a different colorscheme.
  # Add your colorscheme here and enable it.
  # Don't forget to disable the colorschemes you arent using
  #
  # If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  colorschemes = {
    # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
    catppuccin = {
      enable = false;
      settings = {
        flavour = "frappe";
        integrations = {
          cmp = true;
          gitsigns = true;
          treesitter = true;
        };
      };
    };
    gruvbox = {
      enable = false;
    };
    tokyonight = {
      enable = false;
    };
  };

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#globals
  globals = {
    # Set <space> as the leader key
    # See `:help mapleader`
    mapleader = " ";
    maplocalleader = " ";

    # Set to true if you have a Nerd Font installed and selected in the terminal
    have_nerd_font = true;
  };

  #  See `:help 'clipboard'`
  clipboard = {
    providers = {
      wl-copy.enable = true; # For Wayland
      xsel.enable = true; # For X11
    };

    # Sync clipboard between OS and Neovim
    #  Remove this option if you want your OS clipboard to remain independent.
    register = "unnamedplus";
  };

  # [[ Setting options ]]
  # See `:help vim.opt`
  # NOTE: You can change these options as you wish!
  #  For more options, you can see `:help option-list`
  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#opts
  opts = {
    # Show line numbers
    number = true;
    # You can also add relative line numbers, to help with jumping.
    #  Experiment for yourself to see if you like it!
    relativenumber = true;

    # Enable mouse mode, can be useful for resizing splits for example!
    mouse = "a";

    # Don't show the mode, since it's already in the statusline
    showmode = false;

    # Enable break indent
    breakindent = true;

    # Save undo history
    undofile = true;

    # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
    ignorecase = true;
    smartcase = true;

    # Keep signcolumn on by default
    signcolumn = "yes";

    # Decrease update time
    updatetime = 250;

    # Decrease mapped sequence wait time
    # Displays which-key popup sooner
    timeoutlen = 300;

    # Configure how new splits should be opened
    splitright = true;
    splitbelow = true;

    # Sets how neovim will display certain whitespace characters in the editor
    #  See `:help 'list'`
    #  and `:help 'listchars'`
    list = true;
    # NOTE: .__raw here means that this field is raw lua code
    listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

    # Preview substitutions live, as you type!
    inccommand = "split";

    # Show which line your cursor is on
    cursorline = true;

    # Minimal number of screen lines to keep above and below the cursor.
    scrolloff = 10;

    # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
    # instead raise a dialog asking if you wish to save the current file(s)
    # See `:help 'confirm'`
    confirm = true;

    # See `:help hlsearch`
    hlsearch = true;
  };

  # [[ Basic Keymaps ]]
  #  See `:help vim.keymap.set()`
  # https://nix-community.github.io/nixvim/keymaps/index.html
  keymaps = [
    # Clear highlights on search when pressing <Esc> in normal mode
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
    # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
    # is not what someone will guess without a bit more experience.
    #
    # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
    # or just use <C-\><C-n> to exit terminal mode
    {
      mode = "t";
      key = "<Esc><Esc>";
      action = "<C-\\><C-n>";
      options = {
        desc = "Exit terminal mode";
      };
    }
    # TIP: Disable arrow keys in normal mode
    /*
      {
        mode = "n";
        key = "<left>";
        action = "<cmd>echo 'Use h to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<right>";
        action = "<cmd>echo 'Use l to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<up>";
        action = "<cmd>echo 'Use k to move!!'<CR>";
      }
      {
        mode = "n";
        key = "<down>";
        action = "<cmd>echo 'Use j to move!!'<CR>";
      }
      */
    # Keybinds to make split navigation easier.
    #  Use CTRL+<hjkl> to switch between windows
    #
    #  See `:help wincmd` for a list of all window commands
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w><C-h>";
      options = {
        desc = "Move focus to the left window";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w><C-l>";
      options = {
        desc = "Move focus to the right window";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w><C-j>";
      options = {
        desc = "Move focus to the lower window";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w><C-k>";
      options = {
        desc = "Move focus to the upper window";
      };
    }
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
  autoGroups = {
    kickstart-highlight-yank = {
      clear = true;
    };
  };

  # [[ Basic Autocommands ]]
  #  See `:help lua-guide-autocommands`
  # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
  autoCmd = [
    # Highlight when yanking (copying) text
    #  Try it with `yap` in normal mode
    #  See `:help vim.highlight.on_yank()`
    {
      event = [ "TextYankPost" ];
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      callback.__raw = ''
        function()
          vim.highlight.on_yank()
        end
      '';
    }
  ];

  plugins = {
    # Adds icons for plugins to utilize in ui
    web-devicons.enable = true;

    # Detect tabstop and shiftwidth automatically
    # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
    sleuth = {
      enable = true;
    };
  };

  extraPackages = with pkgs; [
    # These are for snacks primarily
    ripgrep
    fd
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
  extraPlugins = with pkgs.vimPlugins; [
    gruvbox-material
    snacks-nvim
  ];

  # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfiglua
  extraConfigLua = ''
    vim.g.gruvbox_material_background = "medium"
    vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    vim.g.gruvbox_material_better_performance = 1
    vim.cmd.colorscheme('gruvbox-material')

    -- snacks
    require('snacks').setup({
      bigfile = { enabled = true },
      dim = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = true },
      picker = { enabled = true },
    })

    -- Keymappings
    vim.keymap.set('n', '<leader>z', function() require('snacks').zen() end, { desc = 'Toggle Zen Mode' })
    vim.keymap.set('n', '<leader>Z', function() require('snacks').zen.zoom() end, { desc = 'Toggle Zoom' })
    vim.keymap.set('n', '<leader><space>', function() require('snacks').picker.smart() end, { desc = 'Smart Find Files' })
    vim.keymap.set('n', '<leader>,', function() require('snacks').picker.buffers() end, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>/', function() require('snacks').picker.grep() end, { desc = 'Grep' })
    vim.keymap.set('n', '<leader>:', function() require('snacks').picker.command_history() end, { desc = 'Command History' })
    vim.keymap.set('n', '<leader>n', function() require('snacks').picker.notifications() end, { desc = 'Notification History' })
    vim.keymap.set('n', '<leader>e', function() require('snacks').explorer() end, { desc = 'File Explorer' })
    vim.keymap.set('n', '<leader>fb', function() require('snacks').picker.buffers() end, { desc = 'Buffers' })
    vim.keymap.set('n', '<leader>fc', function() require('snacks').picker.files({ cwd = vim.fn.stdpath('config') }) end, { desc = 'Find Config File' })
    vim.keymap.set('n', '<leader>ff', function() require('snacks').picker.files() end, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', function() require('snacks').picker.git_files() end, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>fp', function() require('snacks').picker.projects() end, { desc = 'Projects' })
    vim.keymap.set('n', '<leader>fr', function() require('snacks').picker.recent() end, { desc = 'Recent' })
    vim.keymap.set('n', '<leader>gb', function() require('snacks').picker.git_branches() end, { desc = 'Git Branches' })
    vim.keymap.set('n', '<leader>gl', function() require('snacks').picker.git_log() end, { desc = 'Git Log' })
    vim.keymap.set('n', '<leader>gL', function() require('snacks').picker.git_log_line() end, { desc = 'Git Log Line' })
    vim.keymap.set('n', '<leader>gs', function() require('snacks').picker.git_status() end, { desc = 'Git Status' })
    vim.keymap.set('n', '<leader>gS', function() require('snacks').picker.git_stash() end, { desc = 'Git Stash' })
    vim.keymap.set('n', '<leader>gd', function() require('snacks').picker.git_diff() end, { desc = 'Git Diff (Hunks)' })
    vim.keymap.set('n', '<leader>gf', function() require('snacks').picker.git_log_file() end, { desc = 'Git Log File' })
    vim.keymap.set('n', '<leader>sb', function() require('snacks').picker.lines() end, { desc = 'Buffer Lines' })
    vim.keymap.set('n', '<leader>sB', function() require('snacks').picker.grep_buffers() end, { desc = 'Grep Open Buffers' })
    vim.keymap.set('n', '<leader>sg', function() require('snacks').picker.grep() end, { desc = 'Grep' })
    vim.keymap.set({ 'n', 'x' }, '<leader>sw', function() require('snacks').picker.grep_word() end, { desc = 'Visual selection or word' })
    vim.keymap.set('n', '<leader>s"', function() require('snacks').picker.registers() end, { desc = 'Registers' })
    vim.keymap.set('n', '<leader>s/', function() require('snacks').picker.search_history() end, { desc = 'Search History' })
    vim.keymap.set('n', '<leader>sa', function() require('snacks').picker.autocmds() end, { desc = 'Autocmds' })
    vim.keymap.set('n', '<leader>sc', function() require('snacks').picker.command_history() end, { desc = 'Command History' })
    vim.keymap.set('n', '<leader>sC', function() require('snacks').picker.commands() end, { desc = 'Commands' })
    vim.keymap.set('n', '<leader>sd', function() require('snacks').picker.diagnostics() end, { desc = 'Diagnostics' })
    vim.keymap.set('n', '<leader>sD', function() require('snacks').picker.diagnostics_buffer() end, { desc = 'Buffer Diagnostics' })
    vim.keymap.set('n', '<leader>sh', function() require('snacks').picker.help() end, { desc = 'Help Pages' })
    vim.keymap.set('n', '<leader>sH', function() require('snacks').picker.highlights() end, { desc = 'Highlights' })
    vim.keymap.set('n', '<leader>si', function() require('snacks').picker.icons() end, { desc = 'Icons' })
    vim.keymap.set('n', '<leader>sj', function() require('snacks').picker.jumps() end, { desc = 'Jumps' })
    vim.keymap.set('n', '<leader>sk', function() require('snacks').picker.keymaps() end, { desc = 'Keymaps' })
    vim.keymap.set('n', '<leader>sl', function() require('snacks').picker.loclist() end, { desc = 'Location List' })
    vim.keymap.set('n', '<leader>sm', function() require('snacks').picker.marks() end, { desc = 'Marks' })
    vim.keymap.set('n', '<leader>sM', function() require('snacks').picker.man() end, { desc = 'Man Pages' })
    vim.keymap.set('n', '<leader>sp', function() require('snacks').picker.lazy() end, { desc = 'Search for Plugin Spec' })
    vim.keymap.set('n', '<leader>sq', function() require('snacks').picker.qflist() end, { desc = 'Quickfix List' })
    vim.keymap.set('n', '<leader>sR', function() require('snacks').picker.resume() end, { desc = 'Resume' })
    vim.keymap.set('n', '<leader>su', function() require('snacks').picker.undo() end, { desc = 'Undo History' })
    vim.keymap.set('n', '<leader>uC', function() require('snacks').picker.colorschemes() end, { desc = 'Colorschemes' })
    vim.keymap.set('n', 'gd', function() require('snacks').picker.lsp_definitions() end, { desc = 'Goto Definition' })
    vim.keymap.set('n', 'gD', function() require('snacks').picker.lsp_declarations() end, { desc = 'Goto Declaration' })
    vim.keymap.set('n', 'gr', function() require('snacks').picker.lsp_references() end, { nowait = true, desc = 'References' })
    vim.keymap.set('n', 'gI', function() require('snacks').picker.lsp_implementations() end, { desc = 'Goto Implementation' })
    vim.keymap.set('n', 'gy', function() require('snacks').picker.lsp_type_definitions() end, { desc = 'Goto T[y]pe Definition' })
    vim.keymap.set('n', '<leader>ss', function() require('snacks').picker.lsp_symbols() end, { desc = 'LSP Symbols' })
    vim.keymap.set('n', '<leader>sS', function() require('snacks').picker.lsp_workspace_symbols() end, { desc = 'LSP Workspace Symbols' })

    -- Autocommand for initialization
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        -- Setup globals for debugging
        _G.dd = function(...)
          require('snacks').debug.inspect(...)
        end
        _G.bt = function()
          require('snacks').debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create toggle mappings
        require('snacks').toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
        require('snacks').toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
        require('snacks').toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
        require('snacks').toggle.diagnostics():map('<leader>ud')
        require('snacks').toggle.line_number():map('<leader>ul')
        require('snacks').toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
        require('snacks').toggle.treesitter():map('<leader>uT')
        require('snacks').toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
        require('snacks').toggle.inlay_hints():map('<leader>uh')
        require('snacks').toggle.indent():map('<leader>ug')
        require('snacks').toggle.dim():map('<leader>uD')
      end,
    })
  '';
}
