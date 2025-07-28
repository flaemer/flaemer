{ pkgs, ... }: {
  home.packages = [ pkgs.fastfetch ];  # Убедись, что пакет есть в списке

  xdg.configFile."fastfetch/config.json".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "modules": [
        "title",
        "separator",
        "os",
        "host",
        "kernel",
        "uptime",
        "shell",
        "cpu",
        "gpu",
        "memory",
      ],
      "logo": {
        "type": "nixos"
      }
    }
  '';
}
