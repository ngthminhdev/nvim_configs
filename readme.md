# 🚀 Neovim Configuration

Đây là cấu hình Neovim cá nhân của tôi, được tối ưu hóa cho phát triển phần mềm với trải nghiệm hiện đại và hiệu quả.

![Neovim](https://neovim.io/logos/neovim-mark-flat.png)

## ✨ Tính năng

- 🔌 Plugin quản lý tự động với [lazy.nvim](https://github.com/folke/lazy.nvim)
- 🌳 Hỗ trợ LSP cho nhiều ngôn ngữ lập trình
- 🔍 Tìm kiếm mã nguồn nhanh chóng với [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- 🎨 Theme đẹp mắt với highlighting nâng cao
- 📁 File explorer với [Neo-tree](https://github.com/nvim-neo-tree/neo-tree.nvim)
- 🔤 Tự động hoàn thành thông minh với [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- 📊 Git integration với [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- ⚡ Khởi động nhanh và trải nghiệm mượt mà
- 📝 Formatting và linting tích hợp
- 🧩 Giao diện UI hiện đại với [noice.nvim](https://github.com/folke/noice.nvim)

## 📋 Yêu cầu

### Cần thiết
- Neovim >= 0.10.0
- Git
- [Node.js](https://nodejs.org/) (cho một số LSP và plugin)
- [Nerd Font](https://www.nerdfonts.com/) (cho icons và glyph)
- [gcc/clang](https://gcc.gnu.org/) (cho việc biên dịch một số plugin)

### Công cụ bên ngoài
- [Ripgrep](https://github.com/BurntSushi/ripgrep) (cho Telescope tìm kiếm văn bản)
- [fd](https://github.com/sharkdp/fd) (cho Telescope tìm kiếm file nhanh)
- [Lazygit](https://github.com/jesseduffield/lazygit) (cho giao diện Git)
- [fzf](https://github.com/junegunn/fzf) (cho tìm kiếm mờ)
- [xclip](https://github.com/astrand/xclip) hoặc [xsel](https://github.com/kfish/xsel) (cho clipboard trên Linux)

### Khuyến nghị
- [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (cho cài đặt ngôn ngữ treesitter)
- [glow](https://github.com/charmbracelet/glow) (cho việc hiển thị markdown)
- [Universal-ctags](https://github.com/universal-ctags/ctags) (cho tag generation)
- [eslint](https://eslint.org/) (cho linting JavaScript/TypeScript)
- [prettier](https://prettier.io/) (cho format code)

## ⚙️ Cài đặt

1. Sao lưu cấu hình Neovim hiện tại của bạn (nếu có):

```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Cài đặt các công cụ bên ngoài cần thiết:

```bash
# Ubuntu/Debian
sudo apt install git curl ripgrep fd-find xclip lazygit

# Arch Linux
sudo pacman -S git curl ripgrep fd xclip lazygit

# macOS (với Homebrew)
brew install git curl ripgrep fd lazygit
```

3. Cài đặt Nerd Font:
```bash
# Ví dụ với JetBrainsMono Nerd Font
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFontMono-Regular.ttf
fc-cache -f -v
```

4. Clone repository này:

```bash
git clone https://github.com/ngthminhdev/nvim_configs.git ~/.config/nvim
```

5. Khởi động Neovim để tự động cài đặt lazy.nvim và các plugin:

## 🔌 Danh sách plugin chính

- **Quản lý Plugin**: [lazy.nvim](https://github.com/folke/lazy.nvim)
- **LSP**: [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- **Tự động hoàn thành**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- **Tìm kiếm**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- **Syntax highlighting**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- **File Explorer**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)
- **Status Line**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)
- **Theme**: [catppuccin](https://github.com/catppuccin/nvim)
- **Git**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)
- **UI**: [noice.nvim](https://github.com/folke/noice.nvim), [alpha-nvim](https://github.com/goolord/alpha-nvim)
- **Format & Lint**: [conform.nvim](https://github.com/stevearc/conform.nvim), [nvim-lint](https://github.com/mfussenegger/nvim-lint)
- **Terminal**: [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)
- **Hiệu suất**: [impatient.nvim](https://github.com/lewis6991/impatient.nvim)

## ⌨️ Phím tắt quan trọng

### Chung

| Phím tắt     | Mô tả                          |
|--------------|--------------------------------|
| `<Space>`    | Leader key                     |
| `<Space>ff`  | Tìm kiếm file                  |
| `<Space>fc`  | Tìm văn bản trong files        |
| `<Space>fb`  | Tìm buffer                     |
| `<C-f>`   | Mở file explorer (Neo-tree)    |
| `<Space>w`   | Lưu file                       |
| `<Space>x`   | Đóng buffer hiện tại           |
| `<Space>gf`  | Mở lazygit                     |
| `<F12>`  | Mở terminal                    |
| `<Space-h/j/k/l>`| Di chuyển giữa các split       |

### LSP

| Phím tắt     | Mô tả                          |
|--------------|--------------------------------|
| `gd`         | Đi đến định nghĩa              |
| `gr`         | Xem tham chiếu                 |
| `K`          | Hiện thông tin                 |
| `<Space>ca`  | Hiện code actions              |
| `<Space>rn`  | Đổi tên biến/hàm               |
| `<Space>fm`   | Format code                    |
| `<Space>ds`   | Hiện diagnostics               |
| `[d` / `]d`  | Chuyển tới lỗi trước/sau       |

### Telescope

| Phím tắt        | Mô tả                          |
|-----------------|--------------------------------|
| `<Space>fw`     | Tìm với live grep              |
| `<Space>fh`     | Tìm help tags                  |
| `<Space>fk`     | Tìm keymaps                    |

### Danh sách đầy đủ các phím tắt có thể được tìm thấy trong file `lua/mappings.lua`.

## 🎨 Theme

Cấu hình này sử dụng theme [Catppuccin](https://github.com/catppuccin/nvim) mặc định với flavor "mocha". Bạn có thể thay đổi theme hoặc flavor trong file cấu hình plugin tương ứng.

![Catppuccin Theme](https://raw.githubusercontent.com/catppuccin/nvim/main/assets/ss.png)

## 🔧 Tùy chỉnh

Bạn có thể dễ dàng tùy chỉnh cấu hình bằng cách chỉnh sửa các file trong thư mục `lua/`. Một số file quan trọng:

- `lua/options.lua`: Cài đặt Neovim cơ bản
- `lua/mappings.lua`: Phím tắt
- `lua/plugins/init.lua`: Cấu hình lazy.nvim và các plugin
- `lua/configs/`: Thư mục chứa cấu hình chi tiết cho từng plugin

## 💡 Các tính năng nổi bật

### Lazygit Integration

Bạn có thể mở lazygit trực tiếp từ Neovim bằng cách nhấn `<Space>gf`. Đảm bảo bạn đã cài đặt [lazygit](https://github.com/jesseduffield/lazygit) trên hệ thống của mình.

### LSP và Mason

Cấu hình sử dụng [mason.nvim](https://github.com/williamboman/mason.nvim) để quản lý và cài đặt các LSP servers, formatters, và linters. Bạn có thể mở Mason bằng cách gõ lệnh `:Mason` và cài đặt các tools cần thiết từ giao diện của nó.

### Telescope với ripgrep và fd

Để tìm kiếm văn bản nhanh chóng qua nhiều file, cấu hình sử dụng [ripgrep](https://github.com/BurntSushi/ripgrep) và [fd](https://github.com/sharkdp/fd). Đảm bảo bạn đã cài đặt chúng để Telescope hoạt động hiệu quả nhất.

### Treesitter

Syntax highlighting nâng cao được cung cấp bởi [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter). Các ngôn ngữ sẽ được cài đặt tự động khi bạn mở file thuộc ngôn ngữ đó lần đầu tiên.

## 📝 Ghi chú

- Cấu hình này được tối ưu hóa cho phát triển với các ngôn ngữ phổ biến như JavaScript, TypeScript, Python, Rust, Go, và Lua.
- LSP servers, formatters, và linters sẽ được cài đặt thông qua Mason khi bạn cần.
- Nếu bạn gặp vấn đề khi sử dụng đầy đủ các tính năng, hãy kiểm tra lại bạn đã cài đặt đầy đủ các requirement bên ngoài.

## 🤝 Đóng góp

Đóng góp luôn được chào đón! Hãy thoải mái fork repository này và gửi pull request.

## 📄 Giấy phép

Dự án này được cấp phép theo [MIT License](LICENSE).

## 📞 Liên hệ

Nếu bạn có bất kỳ câu hỏi nào, hãy tạo một issue trong repository này hoặc liên hệ với tôi qua:

- GitHub: [@ngthminhdev](https://github.com/ngthminhdev)
- Email: ngthminh.dev@gmail.com
