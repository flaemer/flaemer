{config, pkgs, ...}: {

	wayland.windowManager.hyprland = {
    		enable = true;
    		xwayland.enable = true;


	settings = {
      		"$mainMod" = "SUPER";
					"$terminal" = "kitty";
					"$filemanager" = "nemo";
					"$browser" = "firefox";
					"$text_editor" = "lite-xl";
					"$rofi" = "rofi -show drun";
					"$bluetooth-manager" = "blueman-manager";
					"$sound_manager" = "pwvucontrol";

      	monitor = [
          "eDP-1,1360x768@60,1920x0, 1"
          "HDMI-A-1,1920x1080@60,0x0, 1"
	];

	env = [
	];

	debug = {
		disable_logs = false;
		enable_stdout_logs = true;
	};

	input = {
		kb_layout = "us, ru";
		kb_options = "grp:alt_shift_toggle";

		follow_mouse = 1;

	touchpad = {
          natural_scroll = true;
	};

	sensitivity = 0;
	accel_profile = "flat";

	};

	general = {
		gaps_in = 6;
		gaps_out = 12;
		border_size = 0;

		"col.active_border" = "rgb(f0f8ff) rgb(808080) 45deg";
		"col.inactive_border" = "rgb(808080)";

		layout = "dwindle";

		resize_on_border = false;

		allow_tearing = true;
	};

	decoration = {
		rounding = 20;
		active_opacity = "1.0";
		inactive_opacity = "0.98";

	shadow = {
		enabled = true;
		range = 25;
		render_power = 15;
		color = "rgb(101010)";
	};

	blur = {
		enabled = true;
		size = 5;
		passes = 3;
		contrast = "1.5";
		vibrancy = "0.1696";
		};

	};
	      animations = {
		enabled = true;


 bezier = [
      "linear, 0, 0, 1, 1"
      "md3_standard, 0.2, 0, 0, 1"
      "md3_decel, 0.05, 0.7, 0.1, 1"
      "md3_accel, 0.3, 0, 0.8, 0.15"
      "overshot, 0.05, 0.9, 0.1, 1.1"
      "crazyshot, 0.1, 1.5, 0.76, 0.92"
      "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
      "menu_decel, 0.1, 1, 0, 1"
      "menu_accel, 0.38, 0.04, 1, 0.07"
      "easeInOutCirc, 0.85, 0, 0.15, 1"
      "easeOutCirc, 0, 0.55, 0.45, 1"
      "easeOutExpo, 0.16, 1, 0.3, 1"
      "softAcDecel, 0.26, 0.26, 0.15, 1"
      "md2, 0.4, 0, 0.2, 1"
    ];

    animation = [
      "windows, 1, 3, md3_decel, popin 60%"
      "windowsIn, 1, 3, md3_decel, popin 60%"
      "windowsOut, 1, 3, md3_accel, popin 60%"
      "border, 1, 10, default"
      "fade, 1, 3, md3_decel"
      "layersIn, 1, 3, menu_decel, slide"
      "layersOut, 1, 1.6, menu_accel"
      "fadeLayersIn, 1, 2, menu_decel"
      "fadeLayersOut, 1, 4.5, menu_accel"
      "workspaces, 1, 7, menu_decel, slide"
      "specialWorkspace, 1, 3, md3_decel, slidevert"
    ];

	layerrule = [
	"animation slide, rofi"
	"ignorezero, rofi"
	];
};

	dwindle = {
		pseudotile = true;
		preserve_split = true;
	};
	
	misc = {
		force_default_wallpaper = "3";
		disable_hyprland_logo = true;
	};
	
        exec-once = [
    "waybar"
    "swww-daemon"
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "swaync"
    "hypridle"
    "systemctl --user start hyprpolkitagent"
        ];

      bindm = [
    "$mainMod, mouse:272, movewindow"
    "$mainMod, mouse:273, resizewindow"
    ];

    bindel = [
    ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
    ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
    ", XF86AudioNext, exec, playerctl next"
    ", XF86AudioPause, exec, playerctl play-pause"
    ", XF86AudioPlay, exec, playerctl play-pause"
    ", XF86AudioPrev, exec, playerctl previous"
    ];
    
    bind = [ 
    "$mainMod, Tab, workspace, m+1"
    "$mainMod SHIFT, Tab, workspace, m-1"

"$mainMod SHIFT, 1, movetoworkspace, 1"
"$mainMod SHIFT, 2, movetoworkspace, 2"
"$mainMod SHIFT, 3, movetoworkspace, 3"
"$mainMod SHIFT, 4, movetoworkspace, 4"
"$mainMod SHIFT, 5, movetoworkspace, 5"
"$mainMod SHIFT, 6, movetoworkspace, 6"
"$mainMod SHIFT, 7, movetoworkspace, 7"
"$mainMod SHIFT, 8, movetoworkspace, 8"
"$mainMod SHIFT, 9, movetoworkspace, 9"
"$mainMod SHIFT, 0, movetoworkspace, 10"

"$mainMod SHIFT, F1, movetoworkspace, 11"
"$mainMod SHIFT, F2, movetoworkspace, 12"
"$mainMod SHIFT, F3, movetoworkspace, 13"
"$mainMod SHIFT, F4, movetoworkspace, 14"
"$mainMod SHIFT, F5, movetoworkspace, 15"
"$mainMod SHIFT, F6, movetoworkspace, 16"
"$mainMod SHIFT, F7, movetoworkspace, 17"
"$mainMod SHIFT, F8, movetoworkspace, 18"
"$mainMod SHIFT, F9, movetoworkspace, 19"
"$mainMod SHIFT, F10, movetoworkspace, 20"

"$mainMod, 1, workspace, 1"
"$mainMod, 2, workspace, 2"
"$mainMod, 3, workspace, 3"
"$mainMod, 4, workspace, 4"
"$mainMod, 5, workspace, 5"
"$mainMod, 6, workspace, 6"
"$mainMod, 7, workspace, 7"
"$mainMod, 8, workspace, 8"
"$mainMod, 9, workspace, 9"
"$mainMod, 0, workspace, 10"

"$mainMod  ,F1, workspace, 11"
"$mainMod  ,F2, workspace, 12"
"$mainMod  ,F3, workspace, 13"
"$mainMod  ,F4, workspace, 14"
"$mainMod  ,F5, workspace, 15"
"$mainMod  ,F6, workspace, 16"
"$mainMod  ,F7, workspace, 17"
"$mainMod  ,F8, workspace, 18"
"$mainMod  ,F9, workspace, 19"
"$mainMod  ,F10, workspace, 20"

'', Print, exec, grim -g "$(slurp)" - | wl-copy''

# Normal keyboard fn buttons
"$mainMod CTRL, Page_Up, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
"$mainMod CTRL, Page_Down, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
"$mainMod CTRL, End, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
"$mainMod SHIFT, Page_Down, exec, playerctl --player=playerctld next"
"$mainMod SHIFT, Page_Up, exec, playerctl --player=playerctld previous"
"$mainMod SHIFT, End, exec, playerctl --player=playerctld play-pause"

# Applications binds launch
"ALT, Q, exec, $text_editor"
"$mainMod ,F11, exec, $bluetooth-manager"
"$mainMod ,F12, exec, $sound_manager"
"$mainMod, RETURN, exec, $terminal"
"$mainMod, B, exec, $browser"
"$mainMod, E, exec, $filemanager"
"$mainMod CTRL, Q, exec, wlogout"
"$mainMod SHIFT, RETURN, exec, $rofi"

# Window changing?? or something
"$mainMod, F, fullscreen, 0"
"$mainMod, M, fullscreen, 1"
"$mainMod, T, togglefloating"
"$mainMod SHIFT, T, workspaceopt, allfloat"
"$mainMod, J, togglesplit"

# Kill active window
"$mainMod, Q, killactive"
"$mainMod SHIFT, Q, exec, hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"

# Move focused window
"$mainMod, left, movefocus, l"
"$mainMod, right, movefocus, r"
"$mainMod, up, movefocus, u"
"$mainMod, down, movefocus, d"

# Resize focused window
"$mainMod SHIFT, right, resizeactive, 100 0"
"$mainMod SHIFT, left, resizeactive, -100 0"
"$mainMod SHIFT, down, resizeactive, 0 100"
"$mainMod SHIFT, up, resizeactive, 0 -100"

# Split function и это круто мне нравится ебать как я жил раньше
"$mainMod, G, togglegroup"
"$mainMod, K, swapsplit"
"$mainMod ALT, left, swapwindow, l"
"$mainMod ALT, right, swapwindow, r"
"$mainMod ALT, up, swapwindow, u"
"$mainMod ALT, down, swapwindow, d"

# Moving active windows
"$mainMod CTRL, left, moveactive, -80 0"
"$mainMod CTRL, right, moveactive, 80 0"
"$mainMod CTRL, up, moveactive, 0 -80"
"$mainMod CTRL, down, moveactive, 0 80"

 "$mainMod CTRL, R, exec, hyprctl reload"
 ];
 
 workspace = [
        "1, monitor:eDP-1"
        "2, monitor:eDP-1"
        "3, monitor:eDP-1"
        "4, monitor:eDP-1"
        "5, monitor:eDP-1"
        "6, monitor:eDP-1"
        "7, monitor:eDP-1"
        "8, monitor:eDP-1"
        "9, monitor:eDP-1"
        "10, monitor:eDP-1"
        "11, monitor:HDMI-A-1"
        "12, monitor:HDMI-A-1"
        "13, monitor:HDMI-A-1"
        "14, monitor:HDMI-A-1"
        "15, monitor:HDMI-A-1"
        "16, monitor:HDMI-A-1"
        "17, monitor:HDMI-A-1"
        "18, monitor:HDMI-A-1"
        "19, monitor:HDMI-A-1"
        "20, monitor:HDMI-A-1"
      ];
      
      windowrule = [
      "float, title:^(kitty)$"
			"float, title:^(Picture-in-Picture)$"
			"pin, title:^(Picture-in-Picture)$"
			"move 69.5% 4%, title:^(Picture-in-Picture)$"
			"float, title:^(blueman-manager)$"
			"float, class:(com.saivert.pwvucontrol)"
			"float, class:(firefox)"
			"idleinhibit fullscreen, class:([window])"
      ];

      windowrulev2 = [
      "size 800 500, title:^(kitty)$"
			"float, class:(org.gnome.Nautilus)"
			"size 800 500, class:(org.gnome.Nautilus)"
			"center, class:(org.gnome.Nautilus)"
			"size 800 500, class:(firefox)"
			];
			};
		};

}
