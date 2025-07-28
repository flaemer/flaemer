{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        
        modules-left = ["hyprland/workspaces""wlr/taskbar"];
        modules-center = ["clock" "tray"];
        modules-right = ["tray" "network" "wireplumber" "battery" "custom/power"];

        # Конфиги модулей (как у вас)
        "wlr/taskbar" = {
          format = "{icon}";
          on-click = "activate";
          on-click-right = "fullscreen";
          icon-size = 19;
          tooltip-format = "{title}";
        };

        "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          format = "{}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
          persistent-workspaces = {
            "*" = 5;
          };
        };

        clock = {
          format = "{:%H:%M %d.%m.%Y %A}";
          tooltip = false;
        };

        network = {
          format = "{ifname}";
          format-wifi = "   {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "Not connected";
          tooltip-format = " {ifname} via {gwaddri}";
          tooltip-format-wifi = "   {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "kitty nmtui";
        };

        wireplumber = {
          format = "{icon} : {volume}%";
          format-bluetooth = "󰂰";
          nospacing = 1;
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = ["󰖀" "󰕾" ""];
          };
          on-click = "pwvucontrol";
          scroll-step = 5;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
      };
    };

style = ''
  /* Базовые стили */
  * {
    border: none;
    min-height: 0;
    font-family: "JetBrainsMono Nerd Font";
    font-size: 13px;
    background-color: transparent;
  }

  /* Скругления для конкретных элементов */
  #taskbar, #tray, #network, #wireplumber, 
  #battery, #custom-power, #clock {
    border-radius: 8px;
    margin: 4px 2px;
    padding: 2px 8px;
  }

  /* Рабочие пространства */
  #workspaces button {
    border-radius: 6px;
    margin: 6px 3px;
    padding: 4px 8px;
  }

  /* Активное рабочее пространство */
  #workspaces button.active {
    border-radius: 8px;
  }

  /* Всплывающие подсказки */
  tooltip {
    border-radius: 8px;
    padding: 15px;
    background-color: #131822;
  }

  /* Цвета (сохраняем ваши) */
  #workspaces button {
    background-color: #1e1e2e;
    color: #cdd6f4;
  }

  #wireplumber {
    border-radius: 4px;
    margin: 6px 3px;
    padding: 3px 6px;
    background-color: rgb(156, 114, 203);
  }

  #workspaces button.active {
    background-color: rgb(110, 233, 255);
    color: rgb(30, 30, 45);
  }

  #network {
    background-color: rgb(106, 123, 170);
  }

  #taskbar {
    background-color: rgb(30, 30, 45);
  }

  #battery {
    background-color: rgb(160, 129, 174);
  }

  #clock {
    background-color: rgb(203, 166, 247);
  }

'';
};
}
