# Configurations

Most configurations are explained in the corresponding program's directory and
rc-file.


## Usage

1. Clone repo.
2. Rename `~/config` to `~/.config`.
3. Symlink `~/.config/zsh/zshrc` to `~/.zshrc`.
4. Symlink `~/.config/tmux/tmux.conf` to `~/.tmux.conf`.
5. Install `SpaceMono Nerd Font` or any other NerdFont.
6. Install brew
    6.1 Install nvim, tmux, skhd, z, starship, node, exa, jq, zsh-autosuggestions, zsh-syntax-highlighting, 
        `brew install nvim tmux skhd z starship node exa jq zsh-autosuggestions zsh-syntax-highlighting `
7. NVIM
    7.1 Install Vim-Plug for Neovim.
    7.2 Execute `:PlugInstall`
    7.3 Coc
        7.3.1 Install Coc extensions: `CocInstall coc-json coc-tsserver coc-emmet coc-highlight coc-prettier coc-pairs coc-spell-checker`
