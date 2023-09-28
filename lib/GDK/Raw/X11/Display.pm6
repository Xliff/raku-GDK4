use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::X11::Display:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/x11/gdkx11display.h

sub gdk_x11_display_broadcast_startup_message (
  GdkX11Display $display,
  Str           $message_type,
  Str
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_error_trap_pop (GdkX11Display $display)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_error_trap_pop_ignored (GdkX11Display $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_error_trap_push (GdkX11Display $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_lookup_xdisplay (Display $xdisplay)
  returns GdkX11Display
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_set_sm_client_id (Str $sm_client_id)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_default_group (GdkX11Display $display)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_primary_monitor (GdkX11Display $display)
  returns GdkMonitor
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_screen (GdkX11Display $display)
  returns GdkX11Screen
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_startup_notification_id (GdkX11Display $display)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_user_time (GdkX11Display $display)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_xcursor (
  GdkX11Display $display,
  GdkCursor     $cursor
)
  returns Cursor
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_xdisplay (GdkX11Display $display)
  returns Display
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_xrootwindow (GdkX11Display $display)
  returns Window
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_xscreen (GdkX11Display $display)
  returns Screen
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_grab (GdkX11Display $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_open (Str $display_name)
  returns GdkX11Display
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_set_cursor_theme (
  GdkX11Display $display,
  Str           $theme,
  gint          $size
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_set_program_class (
  GdkX11Display $display,
  Str           $program_class
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_set_startup_notification_id (
  GdkX11Display $display,
  Str           $startup_id
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_set_surface_scale (
  GdkX11Display $display,
  gint          $scale
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_ungrab (GdkX11Display $display)
  is      native(gdk4)
  is      export
{ * }


sub gdk_x11_surface_lookup_for_display (
  GdkDisplay $display,
  Window     $window
)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }
