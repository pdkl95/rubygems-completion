rubygems-completion
===================

Bash completion support for [rubygems](http://github.com/pdkl95/rubygems-completion). (based on gem 1.8.10)


Installation
------------

Put rubygems-completion.bash in one of the following locations:

    * /etc/bash_completion.d
    * /usr/local/etc/bash_completion.d
    * ~/.bash_completion.d

or otherwise make sure it is sourced into your shell.


Hard-Coded Options
==================

Initially, I dynamically pulled some of the completion
lists out of gem itself, but that turned out to be VERY
slow in practice. An extra second or two on each execution
of .bashrc is just too much delay.

It might be practical to have several versions of the options,
and select them by a simple version user-setting, but... that's not
really any different than just choosing the correct version of the file
to load in the first place.

I'm open to suggestions, though, if anybody has an idea on how
to do this efficiently.


The Fine Print
--------------

Copyright (c) 2011 [Brent Sanders](http://thoughtnoise.net) <git@thoughtnoise.net>

Derived losely from [git-completion.sh](https://github.com/rtomayko/git-sh/blob/master/git-completion.bash) in the
[git-sh](https://github.com/rtomayko/git-sh)
package, copyright (c) 2006,2007 Shawn O. Pearce <spearce@spearce.org>,
itself being conceptually based on
[gitcompletion](http://gitweb.hawaga.org.uk/).

Distributed under the [GNU General Public License, version 2.0](http://www.gnu.org/licenses/gpl-2.0.html).
