#!/bin/bash

backup_dir="0ps.configs"
version=$(date "+%Y-%m-%d_%H-%M-%S")

# Create the backup directory if it doesn't exist
if [ ! -d "$backup_dir" ]; then
    mkdir "$backup_dir"
fi

# Create a new backup version
backup_dest="$backup_dir/$version"
mkdir "$backup_dest"

# Backup the user configurations
cp -r ~/.config "$backup_dest"
cp -r ~/.bashrc "$backup_dest"
cp -r /etc/nanorc "$backup_dest"
# Add more configuration files/directories as per your requirement

echo "Backup created at: $backup_dest"


#Save the script to a file, for example, `backup.sh`. Make the script executable using `chmod +x backup.sh`. 

#To execute the script, run `./backup.sh`. It will create a new directory inside `0ps.configs` with the current timestamp as its name. The script then copies the `~/.config` and `~/.bashrc` files to the backup directory. You can add more configuration files/directories to be backed up by using additional `cp` commands.

#Each time the script is executed, it will create a new version labeled with a timestamp in the `0ps.configs` directory.
