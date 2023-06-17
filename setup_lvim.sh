if ! command -v <cargo> &> /dev/null
then
    echo "<cargo> could not be found"
    brew install rust
    exit
fi

if ! command -v <lvim> &> /dev/null
then
    echo "<lvim> could not be found"
    LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/fc6873809934917b470bff1b072171879899a36b/utils/installer/install.sh)
    exit
fi
