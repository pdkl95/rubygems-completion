rubygems-completion
===================

Bash completion support for
[rubygems](http://github.com/pdkl95/rubygems-completion).


TESTED GEM VERSIONS
-------------------

I have useed these versions of rubygems a lot
during development of this script and in my general
ruby use:

* 1.8.10
* 1.8.11
* 1.8.15

Other versions shold work fine regardless unless the
interface to `gem` suddenly changed. It's probably worth
trying on any version that's even remotely "recent-ish".


Installation
------------

Put rubygems-completion.bash in one of the following locations:

* /etc/bash_completion.d
* /usr/local/etc/bash_completion.d
* ~/.bash_completion.d

or otherwise make sure it is sourced into your shell.


Extending Completion
====================

You can apply completion to your own function
or alias with `_gemcomp`. I recommend using this
if possible, instead of calling `complete` directly,
for future compatability.


### Aliasing the `gem` top-level command ###

The function `_gem` handles completion for the
top-level `gem` command itself. For example:

```bash
alias rg="command /some/obscure/path/to/gem"
_gemcomp _gem rg
```


### Aliasing individual gem-commands ###

If you want to alias a specific gem command, hook
directly to the command's completion function
instead of going through `_gem`. The command functions
are named by the command name itself prefixed with `_gem_`
(e.g. `_gem_foo` for the `gem foo` command).

```bash
alias gi="command gem install --verbose"
_gemcomp _gem_install gi
```


Hard-Coded Options
==================

Initially, I dynamically pulled some of the completion
lists out of gem itself, but that turned out to be VERY
slow in practice. An extra second or two on each execution
of `.bashrc` is just too much delay.

It might be practical to have several versions of the options,
and select them by a simple version user-setting, but... that's not
really any different than just choosing the correct version of the file
to load in the first place.

I'm open to suggestions, though, if anybody has an idea on how
to do this efficiently.


Future Plans
============

I'm currently experimenting with a compromise on the above
dynamic-vs-speed issue: precompiling the what I parse out of
the gem command into to bash arrays. It would require triggering
a "recompile" task when rubygems is updated, but I suspect that's
not too big of an issue.

I will never change the default of this script away form
the the "inoffensive and fast" default that it has right now,
but an optional dynamic-update feature could be useful.

At a minimum, I need to find the various `rubygems_plugin.rb` in
gems so the top-level command list can be completed correctly,
even when gem itself has been extended.


The Fine Print
--------------

Copyright (c) 2011,2012 [Brent Sanders](http://thoughtnoise.net) <git@thoughtnoise.net>

Derived losely from [git-completion.sh](https://github.com/rtomayko/git-sh/blob/master/git-completion.bash) in the
[git-sh](https://github.com/rtomayko/git-sh)
package, copyright (c) 2006,2007 Shawn O. Pearce <spearce@spearce.org>,
itself being conceptually based on
[gitcompletion](http://gitweb.hawaga.org.uk/).

Distributed under the [GNU General Public License, version 2.0](http://www.gnu.org/licenses/gpl-2.0.html).
