return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-live-grep-args.nvim" },
      { "nvim-telescope/telescope-frecency.nvim" },
      { "nvim-telescope/telescope-project.nvim" },
      { "nvim-telescope/telescope-ui-select.nvim" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
      },
    },
    keys = {
      {
        "<leader>fn",
        "<CMD>Telescope notify<CR>",
        desc = "Find: Notifications",
      },
      {
        "<leader><leader>",
        "<CMD>Telescope commands<CR>",
        desc = "Find: Commands",
      },
      {
        "<leader>ff",
        "<CMD>Telescope find_files<CR>",
        desc = "Find: Files",
      },
      {
        "<leader>fb",
        "<CMD>Telescope buffers<CR>",
        desc = "Find: Buffers",
      },
      {
        "<leader>fc",
        "<CMD>Telescope colorscheme<CR>",
        desc = "Find: Colorscheme",
      },
      {
        "<leader>fF",
        "<CMD>Telescope file_browser<CR>",
        desc = "Find: File Browser",
      },
      {
        "<leader>fr",
        "<CMD>Telescope oldfiles<CR>",
        desc = "Find: Recent Files",
      },
      {
        "<leader>fw",
        "<CMD>Telescope live_grep<CR>",
        desc = "Find: Live Grep",
      },
      {
        "<leader>fp",
        "<CMD>Telescope project<CR>",
        desc = "Find: Project",
      },
      {
        "<leader>fs",
        "<CMD>Telescope current_buffer_fuzzy_find<CR>",
        desc = "Find: Line",
      },
    },
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-g>"] = actions.close,
              ["<C-h>"] = "which_key"
            }
          },
          layout_config = {
            width = 0.92,
            height = 0.88,
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["i"] = {},
              ["n"] = {},
            },
          },
          live_grep_args = {
            auto_quoting = true,
          },
          frecency = {
            show_scores = true,
            show_unindexed = true,
            ignore_patterns = { "*.git/*", "*/tmp/*" },
          },
          project = {
            base_dirs = {},
            hidden_files = true,
            theme = "dropdown",
            order_by = "asc",
            search_by = "title",
            sync_with_nvim_tree = true,
            on_project_selected = function(prompt_bufnr)
              require("telescope._extensions.project.actions").change_working_directory(prompt_bufnr, false)
              require("harpoon.ui").nav_file(1)
            end
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("live_grep_args")
      require("telescope").load_extension("frecency")
      require("telescope").load_extension("project")
      require("telescope").load_extension("fzf")
    end,
  },
}
