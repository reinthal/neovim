{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {nixpkgs, nvf, flake-utils, ...}:

  flake-utils.lib.eachDefaultSystem (system:
    let pkgs = nixpkgs.legacyPackages.${system};
        configModule = {
            # Add any custom options (and do feel free to upstream them!)
            # options = { ... };

            config.vim = {
                theme.enable = true;
                # and more options as you see fit...
            };
        };

        customNeovim = nvf.lib.neovimConfiguration {
            inherit pkgs;
            modules = [configModule];
        };
    in
    {
      # This will make the package available as a flake output under 'packages'
      packages.default = customNeovim.neovim;

      # Example nixosConfiguration using the configured Neovim package
      nixosConfigurations = {
        build = nixpkgs.lib.nixosSystem {
          # ...
          modules = [
            # This will make wrapped neovim available in your system packages
            {environment.systemPackages = [customNeovim.neovim];}
          ];
          # ...
        };
      };
    }
  );

}
