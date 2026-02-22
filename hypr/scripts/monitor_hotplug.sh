#!/bin/bash

# Function to handle reloads
handle_event() {
    # Check if the event is related to monitor changes
    if [[ $1 == "monitorremoved>>"* ]]; then
        # Use hyprctl reload or specific commands to fix services
        hyprctl reload
    fi
}

# Listen to the socket
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
    handle_event "$line"
done

