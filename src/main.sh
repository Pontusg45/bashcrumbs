#!/bin/bash

menu_file="../res/menu_options.txt"

function display_menu() {
    options=()
    index=1
    while read -r line; do
        options+=("$index" "$line")  # Build an array of menu items
        index=$((index + 1))
    done < "$menu_file"

    # Use whiptail or select for the menu display as in the previous examples
    # Example with whiptail:
    choice=$(whiptail --title "Main Menu" --menu "Choose an option:" 10 100 4 \
        "${options[@]}" 3>&1 1>&2 2>&3)
    # ...

    if [[ $? -eq 1 ]]; then  # 'Cancel' was selected
        echo "Exiting..."
        exit 0
    fi
}

# Execute a command and exit
function execute_and_exit() {
  selected_line=$(sed -n "${choice}p" "$menu_file")
  command=$(echo $selected_line | cut -d'|' -f2- | xargs) 
  $command
  exit 0
}

while true; do 
  display_menu

  # Check if choice is the 'Exit' option 
  if [[ $choice == 1 ]]; then  # Replace with actual index
    echo "Exiting..."
    exit 0 
  else
    execute_and_exit
  fi
done