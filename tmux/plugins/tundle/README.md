## About

[![Build Status](https://travis-ci.org/javier-lopez/tundle.png?branch=master)](https://travis-ci.org/javier-lopez/tundle)

[Tundle](https://github.com/javier-lopez/tundle/) is a portmanteau of _tmux_ and _bundle_, and is a [tmux](http://en.wikipedia.org/wiki/tmux) plugin manager.

<p align="center">
<img src="http://javier.io/assets/img/tundle.gif" alt="tundle"/>
</p>

Tundle is based on [tpm](https://github.com/tmux-plugins/tpm) with additional syntax sugar and relaxed dependency requirements.

## Quick start

1. Set up [Tundle](https://github.com/javier-lopez/tundle/):

   ```
   $ git clone --depth=1 https://github.com/javier-lopez/tundle ~/.tmux/plugins/tundle
   ```

2. Configure bundles:

   Sample `~/.tmux.conf`:

   ```
   run-shell "~/.tmux/plugins/tundle/tundle"

   #let tundle manage tundle, required!
   setenv -g @bundle "javier-lopez/tundle" #set -g can be used if tmux >= 1.8

   #from GitHub, tundle-plugins
   setenv -g @BUNDLE "gh:javier-lopez/tundle-plugins/tmux-sensible"
       #options
   setenv -g @plugin "javier-lopez/tundle-plugins/tmux-pain-control"
       setenv -g @pane_resize "10"
   setenv -g @PLUGIN "github:javier-lopez/tundle-plugins/tmux-copycat:master"
   setenv -g @bundle "https://github.com/javier-lopez/tundle-plugins/tmux-yank:3f821b0"

   #from GitHub, tmux-plugins
   setenv -g @bundle "tmux-plugins/tmux-resurrect"

   #from non GitHub
   #setenv -g @bundle "git://git.domain.ltd/rep.git"

   #from web
   #setenv -g @bundle "http://domain.ltd/awesome-plugin"
   #setenv -g @bundle "ftp://domain.ltd/yet/another-awesome-plugin"

   #from file system
   #setenv -g @bundle "file://path/to/tmux-plugin"

   # Brief help
   # `prefix + I`       (I as in *I*nstall) to install configured bundles
   # `prefix + U`       (U as in *U*pdate) to update configured bundles
   # `prefix + alt + u` (u as in *u*ninstall) to remove unused bundles
   # `prefix + alt + l` (l as in *l*ist) to list installed bundles
   ```

3. Install configured bundles:

   ```
   $ tmux source-file ~/.tmux.conf
   ```

Hit `prefix + I` (or run `~/.tmux/plugins/tundle/scripts/install_plugins.sh` for CLI lovers)

Installation requires [Git](http://git-scm.com/) and triggers [`git clone`](http://gitref.org/creating/#clone) for each configured repo to `~/.tmux/plugins/`.

## Uninstalling

If by any reason you dislike [Tundle](https://github.com/javier-lopez/tundle) you can uninstall it by removing the top tundle directory:

   ```
   $ rm -rf ~/.tmux/plugins/tundle
   ```

## Getting plugins

Common plugins are available in the following repositories:

* [tundle-plugins](https://github.com/javier-lopez/tundle-plugins) (tmux => 1.6 / posix sh)
* [tmux-plugins](https://github.com/tmux-plugins)  (tmux => 1.9 / bash)

## Inspiration and ideas from

* [tpm](https://github.com/tmux-plugins/tpm)
* [vundle](https://github.com/gmarik/vundle)
* [shundle](https://github.com/javier-lopez/shundle)

## Also

* tundle was developed against tmux 1.6 and dash 0.5 on Linux
* tundle will try to run in as many platforms & shells as possible
* tundle tries to be as [KISS](http://en.wikipedia.org/wiki/KISS_principle) as possible

## TODO:
[Tundle](https://github.com/javier-lopez/tundle/) is a work in progress, any ideas and patches are appreciated.

* better coverage tests
* improve install|update visualization
* parallel installation process
* make it rock!
