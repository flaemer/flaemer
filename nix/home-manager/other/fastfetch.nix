{ pkgs, ... }: { 

  xdg.configFile."fastfetch/config.jsonc".text = ''
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "modules": [
    "title", "host",
    "separator",
    "os",
    "kernel",
    "shell",
    "packages",
    "separator",
    "uptime",
                {
            "type": "command",
            "key": "OS Age",
            "text":"birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
        },
    "de",
    "wm",
    "terminal",
    "separator",
    "cpu",
    "gpu",
    "memory",
    "display",
    "battery",
    "separator",
    "swap",
    "disk",
    "colors",

  ]
}
  '';

xdg.configFile."fastfetch/config-minimal.jsonc".text = ''
{
  "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
  "modules": [
    "title", "host",
    "os",
    "kernel",
    "packages",
    "uptime",
                {
            "type": "command",
            "key": "OS Age",
            "text":"birth_install=$(stat -c %W /); current=$(date +%s); time_progression=$((current - birth_install)); days_difference=$((time_progression / 86400)); echo $days_difference days"
        },
    "de",
    "wm",
    "cpu",
    "gpu",
    "memory",
    
  ]
}
  '';
}
