#### [Click here to readme](https://github.com/SarvM/git-work)


## Setup Git Environment                          

This setup is required only once on a give computer; they’ll stick around between upgrades. You can also change them at any time by running through the commands again.

1. Setup Identity

    The first thing you should do when you install Git is to set your user name and email address. This is important because every Git commit uses this information, and it’s immutably baked into the commits you start creating:
    
    ```sh
    $ git config --global user.name "Dupree Susan"
    $ git config --global user.email "susan@mail.com"
    ```
2. Setup Editor

    Vim, Emacs and Notepad++ are popular text editors, which can be configured as default text editor for Git.
    
    For Example: Configuring emacs text editor as default editor
    
    ```sh
    $ git config --global core.editor emacs
    ```
    

    