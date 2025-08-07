{ config, pkgs, lib, ... }:

{
  # Создаём конфиг для Niri в ~/.config/niri/config.kdl
  xdg.configFile."niri/config.kdl".text = ''
input {
    keyboard {
        xkb {
            layout "us,ru"
            options "grp:alt_shift_toggle"
        }
        numlock
    }

}


//Monitors да да это мониторы
output "eDP-1" {
    mode "1366x766@60"
    scale 1    
    transform "normal"
    position x=0 y=0
}

output "HDMI-A-1" {
    mode "1920x1080@60"
    scale 1
    transform "normal"
    position x=-1920 y=0
}

layout {
    gaps 16
    center-focused-column "never"
    preset-column-widths {

        proportion 0.33333
        proportion 0.5
        proportion 0.66667
    }

    focus-ring {
        width 2
       active-color "#7fc8ff"
        inactive-color "#505050"
    }
    struts {
         left -12
         right 0
         top -4
         bottom -4
    }
}
//спавны ну там да
prefer-no-csd
spawn-at-startup "waybar"
spawn-at-startup "sh" "-c" "swww-daemon & swww img /home/flaemer/nix/home-manager/wallpaper/donda_wall2.webp"
spawn-at-startup "xwayland-satellite"

screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"
//енвиронмент
environment {
    DISPLAY ":0"
    QT_QPA_PLATFORM "wayland"
}

cursor {
    xcursor-theme "breeze_cursors"
    xcursor-size 12

    hide-when-typing
    hide-after-inactive-ms 1000
}
animations {
    workspace-switch {
        spring damping-ratio=1.0 stiffness=300 epsilon=0.0001
    }
    window-open {
        duration-ms 350
        curve "ease-out-cubic"
    }

    window-close {
        duration-ms 350
        curve "ease-out-quad"
    }

    horizontal-view-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }

    window-movement {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }

    window-resize {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }

    config-notification-open-close {
        spring damping-ratio=0.6 stiffness=1000 epsilon=0.001
    }

    screenshot-ui-open {
        duration-ms 200
        curve "ease-out-quad"
    }

    overview-open-close {
        spring damping-ratio=1.0 stiffness=800 epsilon=0.0001
    }
}


// виндоу рулес
window-rule {

        match app-id="kitty" title="nmtui"
        match title="Nautilus"
        match app-id="com.saivert.pwvucontrol"
        match app-id="blueman-manager"
        open-floating true
}

window-rule {
        match title="Firefox"
        match title="lite-xl"
        open-maximized true
}

window-rule {
        clip-to-geometry true
        geometry-corner-radius 16
}

// бинды
binds {
    Mod+Shift+Slash { show-hotkey-overlay; }

    Mod+Return hotkey-overlay-title="Open a Terminal" { spawn "kitty"; }
    Mod+Shift+Return hotkey-overlay-title="Run an Application: Fuzzel" { spawn "fuzzel"; }
    Mod+E hotkey-overlay-title="Run a File Manager: Nautilus" { spawn "nautilus" "--new-window"; }
    Mod+B hotkey-overlay-title="Run Firefox" { spawn "firefox"; } 
    Alt+Q hotkey-overlay-title="Run Text Editor: Lite-xl " { spawn "lite-xl"; }
    Mod+Alt+L hotkey-overlay-title="Lock the Screen: swaylock" { spawn "hyprlock"; }
    Mod+Ctrl+Q hotkey-overlay-title="Run Wlogout" { spawn "wlogout"; }
    Mod+Ctrl+V hotkey-overlay-title="Clipboard" { spawn "sh" "-c" "cliphist list | fuzzel --dmenu --config /home/flaemer/.config/fuzzel/clipboard.ini | cliphist decode | wl-copy"; }

    // audio fn buttons yes
    XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
    XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
    XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
    XF86AudioNext { spawn "playerctl" "next"; }
    XF86AudioPlay  { spawn "playerctl" "play-pause"; }
    XF86AudioPrev  { spawn "playerctl" "previous"; }
    XF86MonBrightnessUp { spawn "brightnessctl" "set" "5%+"; }
    XF86MonBrightnessDown { spawn "brightnessctl" "set" "5%-"; }
   
    Mod+Tab repeat=false { toggle-overview; }
    Mod+Q { close-window; }

    Mod+Left  { focus-column-left; }
    Mod+Down  { focus-window-down; }
    Mod+Up    { focus-window-up; }
    Mod+Right { focus-column-right; }

    Mod+Ctrl+Down  { move-window-down; }
    Mod+Ctrl+Left  { move-column-left; }
    Mod+Ctrl+Up    { move-window-up; }
    Mod+Ctrl+Right { move-column-right; }

    Mod+Home { focus-column-first; }
    Mod+End  { focus-column-last; }
    Mod+Ctrl+Home { move-column-to-first; }
    Mod+Ctrl+End  { move-column-to-last; }

    Mod+Shift+Left  { focus-monitor-left; }
    Mod+Shift+Right { focus-monitor-right; }
  
    Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
    Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }

    Mod+Page_Down      { focus-workspace-down; }
    Mod+Page_Up        { focus-workspace-up; }
    Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
    Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }

    Mod+Shift+Page_Down { move-workspace-down; }
    Mod+Shift+Page_Up   { move-workspace-up; }


    Mod+WheelScrollDown      cooldown-ms=80 { focus-workspace-down; }
    Mod+WheelScrollUp        cooldown-ms=80 { focus-workspace-up; }
    Mod+Ctrl+WheelScrollDown cooldown-ms=80 { move-column-to-workspace-down; }
    Mod+Ctrl+WheelScrollUp   cooldown-ms=80 { move-column-to-workspace-up; }

    Mod+WheelScrollRight      { focus-column-right; }
    Mod+WheelScrollLeft       { focus-column-left; }
    Mod+Ctrl+WheelScrollRight { move-column-right; }
    Mod+Ctrl+WheelScrollLeft  { move-column-left; }

    Mod+Shift+WheelScrollDown      { focus-column-right; }
    Mod+Shift+WheelScrollUp        { focus-column-left; }
    Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
    Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }


    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; }
    Mod+3 { focus-workspace 3; }
    Mod+4 { focus-workspace 4; }
    Mod+5 { focus-workspace 5; }
    Mod+6 { focus-workspace 6; }
    Mod+7 { focus-workspace 7; }
    Mod+8 { focus-workspace 8; }
    Mod+9 { focus-workspace 9; }
    Mod+Shift+1 { move-column-to-workspace 1; }
    Mod+Shift+2 { move-column-to-workspace 2; }
    Mod+Shift+3 { move-column-to-workspace 3; }
    Mod+Shift+4 { move-column-to-workspace 4; }
    Mod+Shift+5 { move-column-to-workspace 5; }
    Mod+Shift+6 { move-column-to-workspace 6; }
    Mod+Shift+7 { move-column-to-workspace 7; }
    Mod+Shift+8 { move-column-to-workspace 8; }
    Mod+Shift+9 { move-column-to-workspace 9; }

    Mod+BracketLeft  { consume-or-expel-window-left; }
    Mod+BracketRight { consume-or-expel-window-right; }
    

    Mod+R { switch-preset-column-width; }
    Mod+Shift+R { switch-preset-window-height; }
    Mod+Ctrl+R { reset-window-height; }
    Mod+M { maximize-column; }
    Mod+F { fullscreen-window; }

    Mod+Ctrl+F { expand-column-to-available-width; }

    Mod+C { center-column; }

    // Center all fully visible columns on screen.
    Mod+Ctrl+C { center-visible-columns; }

    Mod+Minus { set-column-width "-5%"; }
    Mod+Equal { set-column-width "+5%"; }

    // Finer height adjustments when in column with other windows.
    Mod+Shift+Minus { set-window-height "-5%"; }
    Mod+Shift+Equal { set-window-height "+5%"; }

    // Move the focused window between the floating and the tiling layout.
    Mod+V       { toggle-window-floating; }
    Mod+Shift+V { switch-focus-between-floating-and-tiling; }

    // Toggle tabbed column display mode.
    // Windows in this column will appear as vertical tabs,
    // rather than stacked on top of each other.
    Mod+W { toggle-column-tabbed-display; }

    Print { screenshot; }
    Shift+Print { screenshot-screen; }
    Ctrl+Print { screenshot-window; }

    Ctrl+Alt+Delete { quit; }
    Mod+Shift+P { power-off-monitors; }
}
 
    '';
}
  
