# raku-GDK4
Raku bindings for GDK4

## Installation

Make a directory to contain the p6-Gtk-based projects. Once made, then set the P6_GTK_HOME environment variable to that directory:

```
$ export P6_GTK_HOME=/path/to/projects
```

Switch to that directory and clone both p6-GtkPlus and p6-WebkitGTK

```
$ git clone https://github.com/Xliff/p6-GLib.git
$ git clone https://github.com/Xliff/p6-GIO.git
$ git clone https://github.com/Xliff/p6-Pango.git
$ git clone https://github.com/Xliff/raku-GDK4.git
$ cd p6-GLib
$ ./install-prereqs.sh
```

[Optional] To build all of WebkitGTK and the required GTK modules, you can change to the p6-WebkitGTK directory and do:

```
./build.sh
```

And here's a quick one-liner to get basic stats on your primary monitor:

`./p6gtk4exec -e 'use GDK::Display:ver<4>; say GDK::Display.open(":0").get-monitors.head.fullInfo'`
