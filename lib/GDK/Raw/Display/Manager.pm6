use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Display::Manager:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkdisplaymanager.h

sub gdk_set_allowed_backends (Str $backends)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_get
  returns GdkDisplayManager
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_get_default_display (GdkDisplayManager $manager)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_list_displays (GdkDisplayManager $manager)
  returns GSList
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_open_display (
  GdkDisplayManager $manager,
  Str               $name
)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_manager_set_default_display (
  GdkDisplayManager $manager,
  GdkDisplay        $display
)
  is      native(gdk4)
  is      export
{ * }
