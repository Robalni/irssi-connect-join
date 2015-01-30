# irssi-connect-join

This script lets you automatically join a channel when you connect to
a server.  You can use the connect command like this:

```
/connect Server:#channel1,#channel2,#channel3
```

...or start irssi like this:

```
irssi -c Server:#channel1,#channel2,#channel3
```

...and then you will automatically join those three channels.  This
script doesn't write anything to your config file, which means that
next time you connect to that server without specifying any channel,
you will not automatically join anything other than what's in your
config file.

## Install

Move connect_join.pl to your `.irssi/scripts` directory.  If you want
it to start automatically, then create a link to it in
`.irssri/scripts/autorun` .