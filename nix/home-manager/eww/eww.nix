{ config, pkgs, lib, ... }:

{
  xdg.configFile."eww/eww.yuck".text = ''
 ; Windows foldstart
 (defwindow bar 
  :monitor 0
  :stacking "fg" 
  :exclusive true
  :geometry (geometry :x 0 :y 0 :height "20px" :width "100%" :anchor "center top")
  :focusable false
  (bar :screen 0))
; foldend

; Bar foldstart
(defwidget bar [screen]
  (box :orientation "h"
       :space-evenly false
       :class "bar"
    (box :halign "start"
         :spacing 5
         :space-evenly false
     ;; (ping)
      (time)
      (player))
    (box :halign "end"
         :spacing 7
         :hexpand true
         :space-evenly false
      (speaker)
      (tray)
      (date))))
; foldend

; Variables foldstart
(defpoll time_poll :interval "1s" "date +%H:%M")
(defpoll date_poll :interval "1m" "date +%b:%d/%y")
(defpoll ping_poll :interval "10s" "./modules/ping.sh")
(deflisten player_listen :initial '{"show": "no", "content": ""}' "./modules/player.sh")


; Make this cleaner at some point
(defpoll speaker_poll :interval "0.1s" "./modules/speaker.sh")
; foldend
(defwidget tray []
  (box :class "tray"
    (systray)))
; Modules foldstart
; Generic icon module foldstart
(defwidget icon-module [icon ?class ?visible]
  (box :class "${class} icon-module"
       :orientation "h"
       :halign "end"
       :space-evenly false
       :visible {visible ?: true} ; because the argument is optional
    (label :class "icon-module__icon" :text "${icon}")
    (children)))
; foldend

(defwidget player []
  (icon-module :class "player" :icon "" :visible {player_listen.show == "yes"}
    (literal :content {player_listen.content})))

(defwidget date []
  (icon-module :class "date" :icon "" 
    (label :text date_poll)))

(defwidget time []
  (icon-module :class "time" :icon "" 
    (label :text time_poll))) 

       
(defwidget ping []
  (icon-module :class "ping" :icon ""
    (label :text ping_poll))) 

(defwidget network []
  (icon-module :class "network" :icon ""
    (label :text "${round(EWW_NET.enp42s0.NET_UP / 1000000, 2)}/${round(EWW_NET.enp42s0.NET_DOWN / 1000000, 2)}"))) 

(defwidget speaker []
  (icon-module :class "speaker" 
               :icon {speaker_poll.icon}
    (eventbox :onscroll `eww update speaker_poll="$(./modules/speaker.sh {})"`
      (button :onclick `eww update speaker_poll="$(./modules/speaker.sh toogle)"`
        (label :text {speaker_poll.content})))))
      '';
}
