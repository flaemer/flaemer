{ pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "left";
        orientation = "vertical";
        
        modules-left = ["wlr/taskbar"];
        modules-center = ["clock"];
        modules-right = ["tray" "wireplumber" "network" "backlight" "bluetooth"];
"bluetooth" = {
on-click = "blueman-manager";
format = "{status}";
format-disabled = "❌";
format-connected = "✔";
tooltip-format = "{controller_alias}\t{controller_address}";
tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
}; 

"network" = {
  on-click = "kitty nmtui";
  format = "{ifname}";
  format-wifi = "{signalStrength}%";
  format-ethernet = "{ipaddr}/{cidr}";
  format-disconnected = "📵";
  tooltip-format = "{ifname} via {gwaddr}";
  tooltip-format-wifi = "{essid} ({signalStrength}%)";
  tooltip-format-ethernet = "{ifname}";
  tooltip-format-disconnected = "Disconnected";
  max-length = 50;
};

 "wireplumber" = {
    on-click = "pwvucontrol";
    format = "{volume}%";
    format-muted = "🔇";
    format-icons = ["" "" ""];
  };

  "wlr/taskbar" = {
    format = "{icon}";
    icon-size = 19;
    on-click = "activate";
    on-click-right = "fullscreen";
    tooltip-format = "{title}";
  };
  "clock" = {
    format = "{:%H\n%M\n%d\n%m\n%a}";
    on-click = "gsimplecal";
  };
};
};
 style =
      ''
 * {
    font-size: 14px;
}
  #window {
      padding: 1px 0;
    }

    window#waybar {
      padding: 0 0;
      background-color: transparent;
      /*background-color: rgba(11, 11, 11, 0.4);*/
      color: #ffffff;
    }

    #network {
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 4px 2px;
      background: rgba(0, 0, 0, 0.6);
    }
    #backlight {
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 4px 2px;
      background: rgba(0, 0, 0, 0.6);
    }

    #wireplumber {
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 4px 2px;
      background: rgba(0, 0, 0, 0.6);
    }

    #taskbar {
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 4px 2px;
      background: rgba(0, 0, 0, 0.6);
    }

    #bluetooth {
      color: rgba(255, 255, 255, 1);
      font-size: 16px;
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 2px 2px;
      background: rgba(0, 0, 0, 0.6);
    }
   #clock {
      color: rgba(255, 255, 255, 1);
      font-size: 16px;
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 2px 2px;
      background: rgba(0, 0, 0, 0.6);
    }

    #tray {
      border-radius: 10px;
      border: 3px solid rgba(0, 0, 0, 0.89);
      margin: 2px 4px;
      padding: 2px 2px;
      background: rgba(0, 0, 0, 0.6);
    }

    #battery.charging {
      color: #b4b4b9;
      border-left: 2px solid #ff761a;
    }
    
    #battery.discharging {
      color: #b4b4b9;
      border-left: 2px solid #99a4bc;
    }
    
    #battery.warning.discharging {
      color: #b4b4b9;
      border-left: 2px solid #ffc552;
    }
    
    #battery.critical.discharging {
      color: #b4b4b9;
      border-left: 2px solid #ff3600;
    }
    
    #battery.warning.charging {
      color: #b4b4b9;
      border-left: 2px solid #ff761a;
    }
    
    #battery.critical.charging {
      color: #b4b4b9;
      border-left: 2px solid #ff761a;
    }

    label:focus {
      background-color: #000000;
    }
  '';
 };       
}  
