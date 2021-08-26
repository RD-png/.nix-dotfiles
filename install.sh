mkdir -p $HOME/.config/nixpkgs
ln -s $(pwd)/hosts/$1/default.nix $(pwd)/nixos/default.nix
ln -s $(pwd)/hosts/$1/home.nix $HOME/.config/nixpkgs/home.nix
ln -s $(pwd)/nixos /etc/nixos
