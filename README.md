# DotEmacs

My Emacs 25 config based on the .emacs of a co-worker who loves evil mode. Because, I never use evil, I commented parts concerning this mode.

I removed the '.' to emacs file and emacs.d folder for easier edition. Do not forget to rename them as .emacs and .emacs.d if you want to try them.

# How to use this .emacs ?

Do not call emacs directly, it's very boring for waiting loading the .emacs everytimes you open a new emacs.

Here is the trick:

* call once emacs server when your Linux session has started:
```sh
emacs-25.1 --daemon
```

It will load your .emacs. You have to do it once by session.
Note: The first time you call it (after cloning this git project), Emacs will download the elpa packages and update them after. So, do not worry if the first time, Emacs takes very very long time for starting !

* Once the deamon has started. Call your emacs client:
```sh
emacsclient -nc
```
An Emacs window appears very quickly. Call this command for each new window you want to open.

* If the Emacs daemon crashes, kill it and start it again.

```sh
pkill emacs
emacs-25.1 --daemon
```
