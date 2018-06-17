" vimrc file
"
" File structure:
"     'autoload': init function which has the package manager, third part bundle defination and other basic configure.
"     'plugin': self plugins
"     'ftplugin': Filetype special.
"
" Vim is my first customizable editor, but Emacs is the first one I configure structured. The old vim config file is too
" ugly.
" Emacs can let user do everything, so it has simple config standard. Configuring it just like making a program. But vim
" is not the same. It has some basic rules, so configs have different coding ideas (Of course, you can do like emacs,
" but it is fool).
" *Use everything supported by tools*.
" I think vim config file is just for configuring. If you want to do some powerful
" things, put them into 'plugin' dir. As well putting other settings into related directory. See more about
" 'runtimepath'.
" I code all basic config in autoload's function. This may be more neat than write them in an other file with a
" function like 'execute' to call it or in this file. But this isn't semantic, I think. Because 'autoload' is used to
" define init function which may only called once.
"
" As the same reason, update will be done by yourself or in update script(in shell). Vim is always closed and opened.
"
" Why do I use neovim to instead of vim?
"     Neovim has more morden design and features. It also more active than origin one. But the mast important reason is
"     that some good plugins don't support origin one. Some of has cound use in both, but the neovim is the high
"     priority one.
"     And it is easy to swich both, if the plugins can support both. All init scripts are written in VimScript.
"
" Put your custom script in 'after' dir.
"
" This file only contains one line which calls a function to init.
"

call vonfry#init()
