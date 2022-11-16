use v6.c;

use NativeCall;

use GLib::Raw::Definition;
use GDK::Raw::Definition:ver<4>;

unit package GDK::Raw::Toplevel::Layout;

### /usr/src/gtk4-4.8.1+ds/gdk/gdktoplevellayout.h

sub gdk_toplevel_layout_copy (GdkToplevelLayout $layout)
  returns GdkToplevelLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_equal (
  GdkToplevelLayout $layout,
  GdkToplevelLayout $other
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_get_fullscreen (
  GdkToplevelLayout $layout,
  gboolean          $fullscreen
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_get_fullscreen_monitor (GdkToplevelLayout $layout)
  returns GdkMonitor
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_get_maximized (
  GdkToplevelLayout $layout,
  gboolean          $maximized
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_get_resizable (GdkToplevelLayout $layout)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_new
  returns GdkToplevelLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_ref (GdkToplevelLayout $layout)
  returns GdkToplevelLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_set_fullscreen (
  GdkToplevelLayout $layout,
  gboolean          $fullscreen,
  GdkMonitor        $monitor
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_set_maximized (
  GdkToplevelLayout $layout,
  gboolean          $maximized
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_set_resizable (
  GdkToplevelLayout $layout,
  gboolean          $resizable
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_layout_unref (GdkToplevelLayout $layout)
  is      native(gdk4)
  is      export
{ * }
