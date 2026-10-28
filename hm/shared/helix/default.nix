{
  pkgs,
  lib,
  ...
}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [lua-language-server nixd bash-language-server fish-lsp marksman];
    defaultEditor = true;
    settings = {
      editor = {
        indent-guides = {
          render = true;
        };
        lsp.display-progress-messages = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };

      keys = {
        normal = {
          C-k = ["extend_to_line_bounds" "delete_selection" "move_line_up" "paste_before"];
          C-j = ["extend_to_line_bounds" "delete_selection" "paste_after"];
        };
      };
    };
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = lib.getExe pkgs.alejandra;
      }
    ];
  };
}
