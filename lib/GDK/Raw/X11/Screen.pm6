use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::X11::Screen;

### /usr/src/gtk4-4.8.1+ds/gdk/x11/gdkx11screen.h

sub gdk_x11_screen_get_current_desktop (GdkX11Screen $screen)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_monitor_output (
  GdkX11Screen $screen,
  gint         $monitor_num
)
  returns XID
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_number_of_desktops (GdkX11Screen $screen)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_screen_number (GdkX11Screen $screen)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_window_manager_name (GdkX11Screen $screen)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_get_xscreen (GdkX11Screen $screen)
  returns Screen
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_screen_supports_net_wm_hint (
  GdkX11Screen $screen,
  Str          $property_name
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
