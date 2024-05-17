{ config, pkgs, ... }:

{

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      equinusocio.vsc-material-theme
      pkief.material-icon-theme
      ms-vscode-remote.remote-ssh
      ms-python.python
    ];
  };

}
