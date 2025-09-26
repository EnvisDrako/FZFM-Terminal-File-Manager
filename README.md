FZFM - A Powerful Terminal File Manager
FZFM (Fuzzy Finder File Manager) is an advanced, terminal-based file management and navigation tool designed to enhance productivity and user experience within the command-line environment. It integrates the power of fzf with other modern utilities to create a seamless and intuitive workflow for developers, system administrators, and power users.

Features
Intuitive Fuzzy Finding: Instantly search and navigate through complex directory structures.

Rich File Previews: Preview syntax-highlighted code, text files, and even images directly in the terminal.

Seamless File Operations: Copy, cut, paste, and safely delete files using intuitive key bindings without leaving the manager.

Quick Creation: Create new files and directories on the fly.

Intelligent File Handling: Automatically opens files in the most appropriate application (e.g., nvim for text, sxiv for images, mpv for video).

Multi-Select: Perform operations on multiple files at once.

Dependencies
Before you begin, ensure you have the following command-line tools installed. You can usually install them with your system's package manager (e.g., apt, brew, pacman).

fzf: The core fuzzy finder.

lsd: For beautiful, icon-rich directory listings.

bat: For syntax-highlighted file previews.

chafa: For rendering image previews in the terminal.

trash-cli: For safely moving files to the trash instead of permanently deleting them.

A Nerd Font: Required for lsd to display icons correctly. We recommend FiraCode Nerd Font.

Example installation on Debian/Ubuntu:

sudo apt update
sudo apt install fzf lsd bat chafa trash-cli git

Installation
To make fzfm and its helper scripts available as a global command, follow these steps:

1. Clone the Repository
First, clone this repository to a location of your choice, for example, in your home directory.

git clone <your-repository-url> ~/.fzfm
cd ~/.fzfm

2. Create a Local bin Directory
It's a best practice to have a local directory for your personal executable scripts.

mkdir -p ~/bin

3. Make the Scripts Executable
Grant execute permissions to the main script and its helpers.

chmod +x fzfm.sh create_dir.sh create_file.sh

4. Update Script Paths
The main fzfm.sh script has hardcoded paths to its helper scripts. You must update them.

Open fzfm.sh in your favorite editor and find these lines:

--bind "ctrl-d:execute(bash -e /home/envis/junk/create_dir.sh)+reload(lsd -a -1)" \
--bind "ctrl-f:execute(bash -e /home/envis/junk/create_file.sh)+reload(lsd -a -1)" \

Change the paths to point to your new ~/bin directory:

--bind "ctrl-d:execute(bash -e ~/bin/create_dir.sh)+reload(lsd -a -1)" \
--bind "ctrl-f:execute(bash -e ~/bin/create_file.sh)+reload(lsd -a -1)" \

Save and close the file.

5. Move Scripts to Your bin Directory
Move the scripts to the bin directory you created.

mv fzfm.sh create_dir.sh create_file.sh ~/bin/

You can rename fzfm.sh to just fzfm for easier access if you like: mv ~/bin/fzfm.sh ~/bin/fzfm.

6. Add Your bin Directory to the System PATH
For the shell to find your new fzfm command, you need to add ~/bin to your PATH.

For Bash users, add this line to the end of your ~/.bashrc file:

export PATH="$HOME/bin:$PATH"

For Zsh users, add it to your ~/.zshrc file:

export PATH="$HOME/bin:$PATH"

7. Apply the Changes
Reload your shell configuration for the changes to take effect.

# For Bash
source ~/.bashrc

# For Zsh
source ~/.zshrc

The fzfm command is now globally available!

Usage
Simply open your terminal and run the command:

fzfm

This will launch the file manager in your current directory.

Key Bindings
Key

Action

Enter / Right

Enter a directory or open a file.

Left

Go up to the parent directory.

Shift-Up

Scroll preview window up.

Shift-Down

Scroll preview window down.

Space

Toggle selection for an item (for multi-select).

Delete

Move selected file(s) to the trash.

Ctrl+f

Create a new file (or multiple files).

Ctrl+d

Create a new directory.

Ctrl+c

Copy selected file(s) to the internal buffer.

Ctrl+x

Cut selected file(s) to the internal buffer.

Ctrl+g

Paste the file(s) from the buffer here.

Esc

Exit the file manager.

License
This project is licensed under the MIT License. See the LICENSE file for details.
