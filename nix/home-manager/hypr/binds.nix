# hyprland-binds.nix
{ lib, ... }:

{
  bindm = lib.mkOptionDefault [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
  ];

  bind = lib.mkOptionDefault [
# Workspaces
"bind = $mainMod, 1, workspace, 1"
"bind = $mainMod, 2, workspace, 2"
"bind = $mainMod, 3, workspace, 3"
"bind = $mainMod, 4, workspace, 4"
"bind = $mainMod, 5, workspace, 5"
"bind = $mainMod, 6, workspace, 6"
"bind = $mainMod, 7, workspace, 7"
"bind = $mainMod, 8, workspace, 8"
"bind = $mainMod, 9, workspace, 9"
"bind = $mainMod, 0, workspace, 10"

"bind = $mainMod  ,F1, workspace, 11"
"bind = $mainMod  ,F2, workspace, 12"
"bind = $mainMod  ,F3, workspace, 13"
"bind = $mainMod  ,F4, workspace, 14"
"bind = $mainMod  ,F5, workspace, 15"
"bind = $mainMod  ,F6, workspace, 16"
"bind = $mainMod  ,F7, workspace, 17"
"bind = $mainMod  ,F8, workspace, 18"
"bind = $mainMod  ,F9, workspace, 19"
"bind = $mainMod  ,F10, workspace, 20"

# Move to workspaces
"bind = $mainMod SHIFT, 1, movetoworkspace, 1"
"bind = $mainMod SHIFT, 2, movetoworkspace, 2"
"bind = $mainMod SHIFT, 3, movetoworkspace, 3"
"bind = $mainMod SHIFT, 4, movetoworkspace, 4"
"bind = $mainMod SHIFT, 5, movetoworkspace, 5"
"bind = $mainMod SHIFT, 6, movetoworkspace, 6"
"bind = $mainMod SHIFT, 7, movetoworkspace, 7"
"bind = $mainMod SHIFT, 8, movetoworkspace, 8"
"bind = $mainMod SHIFT, 9, movetoworkspace, 9"
"bind = $mainMod SHIFT, 0, movetoworkspace, 10"

"bind = $mainMod SHIFT, F1, movetoworkspace, 11"
"bind = $mainMod SHIFT, F2, movetoworkspace, 12"
"bind = $mainMod SHIFT, F3, movetoworkspace, 13"
"bind = $mainMod SHIFT, F4, movetoworkspace, 14"
"bind = $mainMod SHIFT, F5, movetoworkspace, 15"
"bind = $mainMod SHIFT, F6, movetoworkspace, 16"
"bind = $mainMod SHIFT, F7, movetoworkspace, 17"
"bind = $mainMod SHIFT, F8, movetoworkspace, 18"
"bind = $mainMod SHIFT, F9, movetoworkspace, 19"
"bind = $mainMod SHIFT, F10, movetoworkspace, 20"

# Move full workspace
"bind = $mainMod CTRL, 1, exec, $HYPRSCRIPTS/moveTo.sh 1"
"bind = $mainMod CTRL, 2, exec, $HYPRSCRIPTS/moveTo.sh 2"
"bind = $mainMod CTRL, 3, exec, $HYPRSCRIPTS/moveTo.sh 3"
"bind = $mainMod CTRL, 4, exec, $HYPRSCRIPTS/moveTo.sh 4"
"bind = $mainMod CTRL, 5, exec, $HYPRSCRIPTS/moveTo.sh 5"
"bind = $mainMod CTRL, 6, exec, $HYPRSCRIPTS/moveTo.sh 6"
"bind = $mainMod CTRL, 7, exec, $HYPRSCRIPTS/moveTo.sh 7"
"bind = $mainMod CTRL, 8, exec, $HYPRSCRIPTS/moveTo.sh 8"
"bind = $mainMod CTRL, 9, exec, $HYPRSCRIPTS/moveTo.sh 9"
"bind = $mainMod CTRL, 0, exec, $HYPRSCRIPTS/moveTo.sh 10"

"bind = $mainMod  CONTROL, F1, exec, $HYPRSCRIPTS/moveTo.sh 11"
"bind = $mainMod  CONTROL, F2, exec, $HYPRSCRIPTS/moveTo.sh 12"
"bind = $mainMod  CONTROL, F3, exec, $HYPRSCRIPTS/moveTo.sh 13"
"bind = $mainMod  CONTROL, F4, exec, $HYPRSCRIPTS/moveTo.sh 14"
"bind = $mainMod  CONTROL, F5, exec, $HYPRSCRIPTS/moveTo.sh 15"
"bind = $mainMod  CONTROL, F6, exec, $HYPRSCRIPTS/moveTo.sh 16"
"bind = $mainMod  CONTROL, F7, exec, $HYPRSCRIPTS/moveTo.sh 17"
"bind = $mainMod  CONTROL, F8, exec, $HYPRSCRIPTS/moveTo.sh 18"
"bind = $mainMod  CONTROL, F9, exec, $HYPRSCRIPTS/moveTo.sh 19"
"bind = $mainMod  CONTROL, F10, exec, $HYPRSCRIPTS/moveTo.sh 20"

# Mouse workspaces
"bind = $mainMod, mouse_down, workspace, r+1"
"bind = $mainMod, mouse_up, workspace, r-1"
"bind = $mainMod CONTROL, mouse_up, movetoworkspace, r-1"
"bind = $mainMod CONTROL, mouse_down, movetoworkspace, r+1"

"bind = $mainMod, Tab, workspace, m+1"
"bind = $mainMod SHIFT, Tab, workspace, m-1"

# Fn buttons laptop
"bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
"bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
"bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
"bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
"bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
"bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"

"bindl = , XF86AudioNext, exec, playerctl next"
"bindl = , XF86AudioPause, exec, playerctl play-pause"
"bindl = , XF86AudioPlay, exec, playerctl play-pause"
"bindl = , XF86AudioPrev, exec, playerctl previous"

# Normal keyboard fn buttons
"bind = $mainMod CTRL, Page_Up, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
"bind = $mainMod CTRL, Page_Down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
"bind = $mainMod CTRL, End, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
"bind = $mainMod SHIFT, Page_Down, exec, playerctl --player=playerctld next"
"bind = $mainMod SHIFT, Page_Up, exec, playerctl --player=playerctld previous"
"bind = $mainMod SHIFT, End, exec, playerctl --player=playerctld play-pause"

# Screenshots
''bind = , Print, exec, grim -g "$(slurp)" - | wl-copy''

# Applications binds launch
"bind = ALT, Q, exec, $text_editor"
"bind = $mainMod ,F11, exec, $bluetooth-manager"
"bind = $mainMod ,F12, exec, $sound_manager"
"bind = $mainMod, RETURN, exec, $terminal"
"bind = $mainMod, B, exec, $browser"
"bind = $mainMod, E, exec, $filemanager"
"bind = $mainMod CTRL, Q, exec, wlogout"
"bind = $mainMod SHIFT, RETURN, exec, $rofi"

# Window changing?? or something
"bind = $mainMod, F, fullscreen, 0"
"bind = $mainMod, M, fullscreen, 1"
"bind = $mainMod, T, togglefloating"
"bind = $mainMod SHIFT, T, workspaceopt, allfloat"
"bind = $mainMod, J, togglesplit"

# Kill active window
"bind = $mainMod, Q, killactive"
"bind = $mainMod SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"

# Move focused window
"bind = $mainMod, left, movefocus, l"
"bind = $mainMod, right, movefocus, r"
"bind = $mainMod, up, movefocus, u"
"bind = $mainMod, down, movefocus, d"

# Resize focused window
"bind = $mainMod SHIFT, right, resizeactive, 100 0"
"bind = $mainMod SHIFT, left, resizeactive, -100 0"
"bind = $mainMod SHIFT, down, resizeactive, 0 100"
"bind = $mainMod SHIFT, up, resizeactive, 0 -100"

# Split function и это круто мне нравится ебать как я жил раньше
"bind = $mainMod, G, togglegroup"
"bind = $mainMod, K, swapsplit"
"bind = $mainMod ALT, left, swapwindow, l"
"bind = $mainMod ALT, right, swapwindow, r"
"bind = $mainMod ALT, up, swapwindow, u"
"bind = $mainMod ALT, down, swapwindow, d"

# Ресайз окон и перемщенье мышью
"bindm = $mainMod, mouse:272, movewindow"
"bindm = $mainMod, mouse:273, resizewindow"

# Moving active windows
"bind = $mainMod CTRL, left, moveactive, -80 0"
"bind = $mainMod CTRL, right, moveactive, 80 0"
"bind = $mainMod CTRL, up, moveactive, 0 -80"
"bind = $mainMod CTRL, down, moveactive, 0 80"

"bind = $mainMod CTRL, R, exec, hyprctl reload"
"bind = $mainMod SHIFT, A, exec, $HYPRSCRIPTS/toggle-animations.sh"
"bind = $mainMod CTRL, K, exec, $HYPRSCRIPTS/keybindings.sh"
"bind = $mainMod SHIFT, B, exec, ~/.config/hypr/scripts/waybar-reload"
"bind = $mainMod CTRL, B, exec, ~/.config/waybar/toggle.sh"
"bind = $mainMod SHIFT, R, exec, $HYPRSCRIPTS/loadconfig.sh"
"bind = $mainMod SHIFT, H, exec, $HYPRSCRIPTS/hyprshade.sh"
];
}
