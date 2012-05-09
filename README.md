p2p-adb
=======

**Phone-2-Phone adb - A project for "debugging" phones... from other phones.**

A set of scripts to assist in pulling data, making system changes, etc, with minimal user input.

Goal/Reason
-----------

Attacking another device by plugging directly into it has always been something I thought would be movie hacker cool.

One evening, circumstances forced me to leave my computer before ensuring my phone re-flash had gone correctly. It had not. I conveniently had another Android phone with me that I was preparing to take with me on an out of country trip, and realized that I could probably solve this issue if I had my USB OTG cable, but the idea was untested. I then decided to just figure it out, and so I did. Hence these set of scripts.


Requirements
------------

Most of the scripts should be doable by both PC and an Android phone.

Android requires:
 * An install has/supports adb (I don't believe stock comes with adb, otherwise you could probably add it)
 * An install that supports USB host mode
 * A phone that supports USB host mode (hardware support)
 * Root
 * A terminal emulator
 * Probably a [USB On the Go cable](http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=usb+otg)

PC requires 
 * Android SDK (specifically)
 * adb needs to be in $PATH
 * Something that will interpret shell (I'm looking at you, Windows users)


Credits
-------

Me. [@theKos](https://twitter.com/#!/thekos)
[Email](mailto:kyle@kyleosborn.com)

License
-------

[WTFPL - Do What The Fuck You Want To Public License.](http://sam.zoy.org/wtfpl/)
