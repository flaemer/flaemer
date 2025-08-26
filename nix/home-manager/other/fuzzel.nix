{ pkgs, ... }: { 

  xdg.configFile."fuzzel/fuzzel.ini".text = ''
  [main]
font=Ubuntu Mono Nerd Font:size=12,Noto Sans Mono CJK TC:size=12
line-height=18
prompt=""
terminal="kitty"
icon-theme=Colloid
icons-enabled=yes
horizontal-pad=30
vertical-pad=30
inner-pad=10
image-size-ratio=0.3
lines=10
width=15
letter-spacing=0.1

[border]
radius=16
width=3

[colors]
background = "#00000099"       
text = "#d8daddff"             
prompt = "#d8daddff"           
input = "#d8daddff"            
match = "#d8daddff"             
selection = "#758a9b99"        
selection-text = "#d8daddff"   
selection-match = "#b7d4edf2"  
border = "#000000e3"          
'';
}
