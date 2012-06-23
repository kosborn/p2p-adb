p2p-adb
=======

**Phone-2-Phone adb - A project for "debugging" phones... from other phones.**

A set of scripts to assist in pulling data, making system changes, etc, with minimal user input.

Goal/Reason
-----------

Attacking another device by plugging directly into it has always been something I thought would be movie hacker cool.

The real idea is that: Someone leaves their phone at the table, locked, and only for a few minutes. You pull your phone out, plug them together, and hope to god that have USB debugging enabled (all custom ROMs do.) Slurp down their files, stick your own backdoors there, and you're set to go!

Took me about 45 seconds to copy over 62MB of com.android.google.\* databases and user\_prefs files (from encrypted Galaxy Nexus to unencrypted Galaxy Nexus, but running AOKP Milestone 5).

Requirements
------------

Most of the scripts should be doable by both PC and an Android phone.

__Note:__ This was designed for sh (not bash/dash/ksh/etc). I can't guarentee functionality will work across the shells.

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

Running
------

 * Copy to phone
 * `su`
 * `sh ./run.sh`
 * profit

I haven't fully tested against all ROMS/busybox versions yet, but what I know this works agains:
 * AOKP Milestone 5
 * Busybox 1.20.0

As necessary, I'll start expanding and building checks against certain ROMs/toolkit versions to crate maximum damage.


AntiGuard
---------
AntiGuard is an Android app I wrote that will assist you in unlcoking a phone.
Since ADB doesn't always give you root, you might be limited in what you can do. However, the standard ADB shell user is also very powerful.

 * To install AntiGuard, you simply need to run
   * `adb install AntiGuard/AntiGuard.apk`

 * To unlock the screen once install
   * `adb shell am start -S io.kos.antiguard/.unlock`

 * To uninstall, hit the uninstall button, or run this command
   * `adb ununinstall io.kos.antiguard`


In the future, this will be rolled into the automated script toolset.


Credits
-------

Me. [@theKos](https://twitter.com/#!/thekos)
[Email](mailto:kyle@kyleosborn.com)

License
-------

[WTFPL - Do What The Fuck You Want To Public License.](http://sam.zoy.org/wtfpl/)
