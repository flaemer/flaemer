#!/bin/bash

# Получаем ID активного окна
active_window=$(hyprctl activewindow -j | jq -r '.pid')

# Находим все аудиопотоки, связанные с этим PID
sink_inputs=$(pactl list sink-inputs | grep -E "Sink Input #|application.process.id" | grep -B1 "$active_window" | grep "Sink Input" | awk '{print $3}' | sed 's/#//')

if [[ -z "$sink_inputs" ]]; then
    notify-send "Аудиопоток не найден"
    exit 1
fi

# Проверяем, есть ли уже заглушенные потоки
muted=false
for sink in $sink_inputs; do
    muted_state=$(pactl list sink-inputs | grep -A 10 "Sink Input #$sink" | grep "Mute:" | awk '{print $2}')
    if [[ "$muted_state" == "yes" ]]; then
        muted=true
    fi
done

# Переключаем состояние (заглушить/разглушить)
for sink in $sink_inputs; do
    if $muted; then
        pactl set-sink-input-mute "$sink" 0
    else
        pactl set-sink-input-mute "$sink" 1
    fi
done

# Уведомление
if $muted; then
    notify-send "Аудио включено"
else
    notify-send "Аудио выключено"
fi
