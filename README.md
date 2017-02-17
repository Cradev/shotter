Shotter
===================

Shotter is a simple project I started after having some troubles with the captured app for macOS. The upload "API" *(uploader.php)* included is a minimal re-write of the [Captured-php](https://github.com/csexton/captured-php) script for [Captured](http://www.capturedapp.com).

upload.py will automatically upload the specified image to the server where you have uploaded uploaded.php. It will perform basic authentication and upload the image, if succeded in both, it will return the public link to the file and copy if to your clip board.

Since I'm an Apple geek it will currently only work on macOS.


To do
-------------
 > - Make the command line arguments prettier/easier to use.
 > - Create a GUI app or make the script watch certain folders for file changes and automatically upload.
 > - By doing the above hopefully make the project easier to use for non-tech savy users.
 > - Add automatic copying of link to clip-board on linux too.
 > - More awesomeness.

Installation
-------------

**uploader.php**
>**Step 1**
>Upload uploader.php to your web-root.
>
>**Step 2**
>Make sure apache/nginx has write access to the folder.

**upload.rb This is currently an ugly hack proper instructions will follow.**
> **Step 1**
> Make sure the shebang `#!/usr/bin/env ruby` is added at the top of upload.rb.
>
> **Step 2**
> Create a folder to hold your personal executables. `mkdir -p ~/bin`. If you already have a preferred folder for this, you can skip this step.
>
>**Step 3**
> Copy upload.rb, uploader.rb and config.yaml either to ~/bin or to your preferred folder.
>
>**Step 4**
> Make upload.rb executable `chmod +x upload.rb`.
>
> **Step 5**
> Rename the file so we can get rid of the .rb part. `mv upload.rb upload`
>
> **Step 6**
> Add `export PATH=$PATH":$HOME/bin"` to your .profile or .bash_profile file.
> Now restart your shell and type `upload -f [path-to-file]`


Usage
-------------

> **Command(s)**
> *upload -d -f [path-to-file]*
> *-d or --delete will delete the file after upload*

