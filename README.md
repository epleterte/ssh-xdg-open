ssh-xdg-open :penguin:
============

tids and bits needed to enable ssh-links (ssh://) in the web browser (Chromium, Firefox)  
...or any desktop application.  
I found both tids and bits lying gently on the Internet, so thank you kindly Internets.


installation
------------

You can run the included, primitive but interactive *install.sh*

    $ ./install.sh

Run with *-h* for options:

    $ ./install.sh -h
    Usage: ./install.sh [-h|-p <prefix]
      -h  This.
      -p  Install prefix. Defaults to /home/<username>/.local

...or you can do it manually. Files involved are *mimeapps.list*, *ssh.desktop* and *ssh-handler*:

Copy *ssh.desktop* to *~/.local/share/applications/*

    $ cp ssh.desktop ~/.local/share/applications/

Add to *mimeapps.list* in *~/.local/share/applications/*

    $ [ -f ~/.local/share/applications/mimeapps.list ] && sed 1d mimeapps.list >> ~/.local/share/applications/mimeapps.list \
      [ -f ~/.local/share/applications/mimeapps.list ] || cp mimeapps.list ~/.local/share/applications/
      

Now xdg-open knows what to do when it encounters links of type *'ssh://my.remote.host'*  
...but we still need a handler! *ssh.desktop* defines `ssh-handler`, so you should put that in your path. I have mine in *~/bin/* (must be in your PATH)  
Use the included script:

    $ cp ssh-handler ~/bin/ && chmod +x ~/bin/ssh-handler
or

    $ cp ssh-handler.minimal ~/bin/ssh-handler && chmod +x ~/bin/ssh-handler

...or write your own ssh-handler script :smiley_cat:

Now test with

    $ xdg-open ssh://localhost


usage
-----

After having set up mimeapps.list and ssh.desktop, the rest is up to the ssh-handler script:

    Usage: ./ssh-handler [-h|-c <command>|-m <mode>|-t '<terminal> [<terminal>]'] <ssh://my.remote.host>
      -h  This.
      -c  Command used to connect to remote host. Defaults to 'ssh'
      -m  Mode. Defaults to 'default'
      -t  Space separates list of terminal emulators. Defaults to 'urxvt xterm'
    
    Available modes:
      default, tmux
    
    The following variables can be set in /home/<username>/.ssh-handler.conf:
      mode="default"
      command="ssh"
      terminals="urxvt xterm"
    
    Examples:
      ./ssh-handler ssh://my.remote.host
      ./ssh-handler my.remote.host
      ./ssh-handler -m tmux ssh://my.remote.host
      ./ssh-handler -c 'remmina -n --protocol=SSH -s'
      ./ssh-handler -t 'gnome-terminal xterm'

If you, like me, have a web application where server information is being documented, you can now render ssh hyperlinks like so:

    <a href="ssh://remote.host">remote.host</a>

I've slightly modified the [Racktables](http://racktables.org) interface like this, but it works equally well with any kind of Wiki / Puppet External Node Classifier UI ([Puppet Dashboard](https://puppetlabs.com/puppet/related-projects/dashboard/), [Foreman](http://theforeman.org/)) / Whatever.


tips are for trix
-----------------

By default the ssh client will use your local username when logging in remotely - use *~/.ssh/config* extensively to get the most out of this. While you could find other mechanisms - i.e. if you have control of your web application and your environment you could render ssh hyperlinks with the right user for the given box/environment (or use the username of the logged in user) - I recommend using *~/.ssh/config* for least pain and maximum flexibility.

Add entries like these to *~/ssh/config* :

    Host *.domain
      User username
    
    Host *.test.domain
      User otherusername

Using *ProxyCommand* is also a very good idea.

