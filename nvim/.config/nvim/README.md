# NVIM config
## Requirements
- [Nerd Font](https://www.nerdfonts.com/)
- curl
- fzf
- ripgrep
- fd

## Plugins
### Core & Package Management
- lazy.nvim
- plenary.nvim
- mason.nvim
- mason-lspconfig.nvim
- mason-tool-installer.nvim
- mason-nvim-dap.nvim

### UI & Appearance
- catppuccin
- lualine.nvim
- noice.nvim
- nui.nvim
- which-key.nvim
- nvim-colorizer.lua
- mini.icons

### LSP & Completion
- nvim-lspconfig
- blink.cmp
- LuaSnip
- friendly-snippets
- lazydev.nvim

### Editing & Text Objects
- mini.nvim
- nvim-autopairs
- nvim-treesitter
- nvim-ts-autotag
- conform.nvim
- guess-indent.nvim
- inc-rename.nvim
- flash.nvim
- nvim-ufo
- promise-async

### Utilities & Tools
- harpoon
- oil.nvim
- gitsigns.nvim
- persistence.nvim
- obsidian.nvim
- render-markdown.nvim
- snacks.nvim
- todo-comments.nvim

### Debugging
- nvim-dap
- nvim-dap-ui
- nvim-dap-python
- nvim-dap-virtual-text
- nvim-nio

### Troubleshooting & Navigation (Not Loaded)
- trouble.nvim
- vim-tmux-navigator

## Keymaps
- `<leader>` is map to space bar.
### General

| Key          | Description                              | Mode       |
| ------------ | ---------------------------------------- | ---------- |
| `<Esc>`      | Clear highlights on search               | n          |
| `<leader>e`  | Open Explorer (Oil)                               | n          |
| `<leader>;`  | Easy way to input commands               | n          |
| `<C-s>`      | Save file                                | i, x, n, s |
| `<leader>qq` | Quit all                                 | n          |
| `<leader>wd` | [W]indow [D]elete                        | n          |
| `j`          | Down (handles wrapped lines)             | n, x       |
| `<Down>`     | Down (handles wrapped lines)             | n, x       |
| `k`          | Up (handles wrapped lines)               | n, x       |
| `<Up>`       | Up (handles wrapped lines)               | n, x       |
| `<C-h>`      | Move focus to the left window            | n          |
| `<C-l>`      | Move focus to the right window           | n          |
| `<C-j>`      | Move focus to the lower window           | n          |
| `<C-k>`      | Move focus to the upper window           | n          |
| `<leader>l`  | [L]azy (open Lazy plugin manager)        | n          |
| `J`          | Move selected line(s) down               | v          |
| `K`          | Move selected line(s) up                 | v          |
| `<C-d>`      | Half-page down and center cursor         | n          |
| `<C-u>`      | Half-page up and center cursor           | n          |
| `n`          | Next search result and center cursor     | n          |
| `N`          | Previous search result and center cursor | n          |
| `<`          | Better indenting (keep selection)        | x          |
| `>`          | Better indenting (keep selection)        | x          |
| `<leader>p`  | Paste over selection without losing yank | x          |

### snacks.nvim

| Key               | Description        | Mode |
| ----------------- | ------------------ | ---- |
| `<leader><space>` | [S]earch [F]iles   | n    |
| `<leader>sf`      | [S]earch [F]iles   | n    |
| `<leader>sb`      | [S]earch [B]uffers | n    |
| `<leader>fp`      | [F]ind [P]rojects  | n    |
| `<leader>sg`      | [S]earch [G]rep    | n    |
| `<leader>sh`      | [S]earch [H]elp    | n    |
| `<leader>sk`      | [S]earch [K]eymaps | n    |

### conform.nvim
| Key         | Description     | Mode |
| ----------- | --------------- | ---- |
| `<leader>cf` | Format buffer | n, v |

### harpoon

| Key          | Description             | Mode |
| ------------ | ----------------------- | ---- |
| `<leader>a`  | Add file to Harpoon     | n    |
| `<C-e>`      | Toggle Harpoon menu     | n    |
| `<leader>1`  | Go to Harpoon file 1    | n    |
| `<leader>2`  | Go to Harpoon file 2    | n    |
| `<leader>3`  | Go to Harpoon file 3    | n    |
| `<leader>4`  | Go to Harpoon file 4    | n    |
| `<leader>xa` | Clear Harpoon list      | n    |
| `<C-p>`      | Previous Harpoon buffer | n    |
| `<C-n>`      | Next Harpoon buffer     | n    |

### todo-comments.nvim
| Key          | Description                | Mode |
| ------------ | -------------------------- | ---- |
| `]t`         | Next Todo Comment          | n    |
| `[t`         | Previous Todo Comment      | n    |
| `<leader>xt` | Todo (Trouble)             | n    |
| `<leader>xT` | Todo/Fix/Fixme (Trouble)   | n    |
| `<leader>st` | Todo (Telescope)           | n    |
| `<leader>sT` | Todo/Fix/Fixme (Telescope) | n    |

### noice.nvim

| Key          | Description                     | Mode |
| ------------ | ------------------------------- | ---- |
| `<leader>n`  | [N]oice                         | n    |
| `<S-Enter>`  | Redirect Cmdline                | c    |
| `<leader>nl` | [N]oice [L]ast Message          | n    |
| `<leader>nh` | [N]oice [H]istory               | n    |
| `<leader>na` | [N]oice [A]ll                   | n    |
| `<leader>nd` | [D]ismiss [A]ll                 | n    |
| `<leader>nt` | Noice Picker (Telescope/FzfLua) | n    |

### nvim-ufo
| Key  | Description              | Mode |
| ---- | ------------------------ | ---- |
| `za` | Toggle fold under cursor | n    |
| `zR` | Open all folds           | n    |

### obsidian.nvim

| Key          | Description             | Mode |
| ------------ | ----------------------- | ---- |
| `<leader>on` | [O]bsidian [N]ote       | n    |
| `<leader>od` | [O]bsidian [D]aily Note | n    |
| `<leader>ob` | [O]bsidian [B]acklinks  | n    |
| `<leader>ot` | [O]bsidian [T]ags       | n    |
| `<leader>oo` | [O]bsidian [O]pen       | n    |
| `<leader>ct` | [C]hecklist [T]oggle       | n    |

### oil.nvim

| Key     | Description                  | Mode |
| ------- | ---------------------------- | ---- |
| `q`     | Close Oil                    | n    |
| `<Esc>` | Close Oil                    | n    |
| `g?`    | Show help                    | n    |
| `<CR>`  | Select item                  | n    |
| `<C-a>` | Select (split horizontally)  | n    |
| `<C-v>` | Select (split vertically)    | n    |
| `<C-p>` | Preview file                 | n    |
| `<C-r>` | Refresh                      | n    |
| `-`     | Go to parent directory       | n    |
| `_`     | Open current working dir     | n    |
| `` ` `` | Change directory (cd)        | n    |
| `~`     | Change directory (tab scope) | n    |
| `gs`    | Change sort order            | n    |
| `gx`    | Open file externally         | n    |
| `g.`    | Toggle hidden files          | n    |
| `g\`    | Toggle trash mode            | n    |

### persistence.nvim

| Key          | Description                  | Mode |
| ------------ | ---------------------------- | ---- |
| `<leader>qs` | Restore [S]ession            | n    |
| `<leader>qS` | Select [S]ession             | n    |
| `<leader>ql` | Restore [L]ast Session       | n    |
| `<leader>qd` | [D]on’t Save Current Session | n    |

### vim-tmux-navigator

| Key     | Description            | Mode |
| ------- | ---------------------- | ---- |
| `<C-h>` | Navigate left          | n    |
| `<C-j>` | Navigate down          | n    |
| `<C-k>` | Navigate up            | n    |
| `<C-l>` | Navigate right         | n    |
| `<C-\>` | Navigate previous pane | n    |

### inc-rename

| Key     | Description            | Mode |
| ------- | ---------------------- | ---- |
| `<leader>cr` | Rename word under cursor          | n    |

## Credits
- The base of my config is from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim/tree/master), which I modulized and added some plugins of my own, with some keybind and autocmd from [LazyVim](https://www.lazyvim.org/).







