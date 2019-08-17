# DotEmacs

My Emacs 25 config based on the co-worker's work.

Note: In the git project I removed the '.' in the file name '.emacs' and also in the directory name '.emacs.d' for simplifying the edition. But if you want to use my Emacs config, please do not forget to rename them as '.emacs' and '.emacs.d' and place them in your home directory.

# How to use this .emacs ?

###### Step 1: prerequisite

* Install or compile Emacs >= 25.
* For C developpers, install gtags:
```sh
sudo apt-get install globals
```

###### Step 2: backup your emacs config (if you have one)

```sh
mv ~/.emacs ~/OLD.emacs
mv ~/.emacs.d ~/OLD.emacs.d
```

###### Step 3: copy the new .emacs

```sh
git clone https://github.com/Lecrapouille/DotEmacs.git
mv DotEmacs/emacs ~/.emacs
mv DotEmacs/emacs.d ~/.emacs.d
```

###### Step 4: Configure your emacs

You can modify the following files:
* .emacs.d/init.el: this file is entry point of the emacs config. It is splited into two parts. The first part allows to add your desired ELPA packages (they are automaticly downloaded and updated). The second part is for loading .el files located in the .emacs.d/conf/ directory.
* .emacs.d/conf/c.el: this file manages several C style identation. Define here your own C style and include your project path which will launch your desired C style when you open a C file on it. By default it will my C style (based on the GNU style).
* .emacs.d/conf/epita.el: this file generates an header file for several languages (C, java, OCaml, Lisp ...). Type Ctl-c Ctrl-h for generating the header. But before, you have to find and replace John and Doe words by your first and last name.
* .emacs.d/conf/evil.el and .emacs.d/conf/evil-cursors.el For people who like Evil mode. The initial project used a lot Evil shortcuts. I personally do not use this mode, so I tried to group evils stuffs in these two files in which I commented in the init.el. You can uncomment these lines in the .emacs.d/init.el file to get them.

###### Step 5: launch Emacs

Do not call emacs directly, it's very boring to waiting for it loading the .emacs everytimes you open a new emacs.

Do this trick:

* call once the emacs server when your Linux session has started:
```sh
emacs-25.1 --daemon
```

It will load for once your .emacs. You have to do it once by session.

Note: The first time you call it (after cloning this git project), Emacs will download some ELPA packages (in .emacs.d/elpa/. So, do not worry if for the very first time, Emacs takes very very long time for starting, it will start faster later !

* Once the deamon has started. Call an emacs client (call as many as you wish):
```sh
emacsclient -nc
```
An Emacs window will appear very quickly. Call this command for each new window you want to open.

* If after some work, your Emacs starts bugging, save your current work, kill the Emacs server and start it again:
```sh
pkill emacs-25.1
emacs-25.1 --daemon
```

* You can create some aliases. Place this code in your `~/.bashrc` file:
```sh
alias emacsc='emacsclient -nc'
alias emacsd='emacs25 --daemon'
```

# Known bugs

Help is welcome:
* iedit-mode is not working well when GTAGS have been created (iedit allows to edit multiple regions simulteanously. My binder is the F11 key).
* copy-paste with the mouse is broken.
