#!/bin/bash

# Add Kali Linux repository to APT sources
add_kali_repository() {
  if ! grep -r "^deb .*kali" /etc/apt/ &>/dev/null; then
    cat <<EOF | sudo tee -a /etc/apt/sources.list
deb http://http.kali.org/kali kali-rolling main non-free contrib
EOF
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ED444FF07D8D0BF6
    sudo apt update
    echo "Kali Linux repository has been added to APT sources."
  else
    echo "Kali Linux repository is already present."
  fi
}

# Function to install the selected tools
install_tools() {
  tools_to_install=()
  read -p "Enter tools to install (comma-separated numbers or 'all' for all tools): " choices

  if [[ $choices == "all" ]]; then
    tools_to_install=("${available_tools[@]}")
  else
    choice_arr=(${choices//,/ })

    for choice in "${choice_arr[@]}"; do
      index=$((choice - 1))

      if ((index >= 0 && index < ${#available_tools[@]})); then
        tools_to_install+=("${available_tools[index]}")
      fi
    done
  fi

  if [[ ${#tools_to_install[@]} -eq 0 ]]; then
    echo "No valid tools selected."
    return
  fi

  sudo apt update

  for tool in "${tools_to_install[@]}"; do
    echo "Installing $tool..."
    sudo apt install -y "$tool"
  done
}

# Add Kali Linux repository
add_kali_repository

# Get list of available tools from Kali Linux repositories
available_tools=($(apt-cache search kali-linux | awk '{print $1}'))

# Prompt user to select tools
echo "Kali Linux Tools:"

for index in "${!available_tools[@]}"; do
  echo "$((index + 1)). ${available_tools[index]}"
done

install_tools

echo "Script execution complete."


#Remember to save the script to a file (e.g., `kali_tools_installer.sh`) and make it executable using the command: `chmod +x kali_tools_installer.sh`.

#Then, you can run the script with the command: `./kali_tools_installer.sh`.

#The updated script first adds the Kali Linux repository to the APT sources and then proceeds to display the list of available tools and install the selected ones.






