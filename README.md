# neovim

My own neovim config, built with [nvf](https://github.com/notashelf/nvf).

## Build and test locally

Build it:

```sh
nix build .
```

Run it without installing (just try it out):

```sh
nix run .
```

Run from remote (no clone needed):

```sh
nix run github:reinthal/neovim
```

## Update flake inputs

```sh
nix flake update
```

Or just one input:

```sh
nix flake update nixpkgs
```

## Use in Home Manager

Add the flake as an input in your system flake:

```nix
{
  inputs.neovim.url = "github:reinthal/neovim";
}
```

Then in your home-manager config:

```nix
{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.neovim.packages.${pkgs.system}.default ];
}
```

## Hacking on config

All the neovim module options live in `config.nix`. Edit that, then:

```sh
nix build . && ./result/bin/nvim
```

Or the one-liner:

```sh
nix run .
```
