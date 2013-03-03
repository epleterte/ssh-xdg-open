ssh-xdg-open
============

tids and bits needed to enable ssh-links (ssh://) in the web browser
...or any desktop application.
I found both tids and bits lying gently on the Internet, so thank you kindly Internets.


installation
------------

You can run the included, primitive but interactive install.sh

    $ ./install.sh

Run with *-h* for options:

    $ ./install.sh
    Usage: ./install.sh [-h|-p <prefix]
      -h  This.
      -p  Install prefix. Defaults to /home/<username>/.local

...or you can do it manually:

Copy ssh.desktop to ~/.local/share/applications/

    $ cp ssh.desktop ~/.local/share/applications/

add to mimeapps.list in ~/.local/share/applications/

    $ [ -f ~/.local/share/applications/mimeapps.list ] && sed 1d mimeapps.list >> ~/.local/share/applications/mimeapps.list \
      [ -f ~/.local/share/applications/mimeapps.list ] || cp mimeapps.list ~/.local/share/applications/

now xdg-open knows what to do when it encounters links of type 'ssh://my.remote.host'
...but we still need a handler! ssh.desktop defines 'ssh-handler', so you should put that in your path. I have mine in ~/bin/
Use the included script, or modify it to your own needs.

Now test with

    $ xdg-open ssh://localhost

usage
-----

    Usage: ./ssh-handler [-h|-c <command>-m <mode>] <ssh://my.remote.host>
      -h  This.
      -c  Command used to connect to remote host. Defaults to 'ssh'
      -m  Mode. Defaults to 'default'

    Available modes:
    default, tmux
    
    Examples:
      ./ssh-handler ssh://my.remote.host
      ./ssh-handler my.remote.host
      ./ssh-handler -m tmux ssh://my.remote.host
      ./ssh-handler -c 'remmina -n --protocol=SSH -s'

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

Using ProxyCommand is also a very good idea.

