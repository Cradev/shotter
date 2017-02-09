Shotter
===================

Shotter is a simple project I started after having some troubles with the captured app for macOS. The upload "API" located on your server is a minimal re-write of the [Captured-php](https://github.com/csexton/captured-php) script for [Captured](http://www.capturedapp.com).

It will automatically upload the image to the server you have the /uploaded.php file located on. It will perform basic authentication and, if authenticated and file successfully uploaded, return the public link to the file and copy if to your clip board.

Since I'm an Apple geek it will currently only work on macOS.


To do
-------------

>**Features**
> - Make the command line arguments prettier/easier to use.
> - Create a GUI app or make the script watch certain folders for file changes and automatically upload.
> By doing the above hopefully make the project easier to use for non-tech savy users.
> Add automatic copying of link to clip-board on linux too.
> Make the code more pretty and easier to add to/modify.
> More awesomeness.


Installation
-------------

> **Step 1**
> Make sure the shebang "*#!/usr/bin/env python3*" is added at the top of upload.py.
>
> **Step 2**
> Make the file executable: *chmod -x upload.py*
>
> **Step 3**
>
> Create a folder to hold your personal scripts: *mkdir -p ~/bin*
> Copy *upload.py* to the newly created folder: *cp upload.py ~/.bin*
> Add *export PATH=$PATH":$HOME/bin"* to your .profile or .bash_profile.
> Test it out by typing *uploader -f [path_to_file]*


Usage
-------------

> **Command(s)**
> *upload -f [path_to_file]*
