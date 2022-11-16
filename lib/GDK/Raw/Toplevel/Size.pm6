use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::TopLevelSize:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdktoplevelsize.h

sub gdk_toplevel_size_get_bounds (
  GdkToplevelSize $size,
  gint            $bounds_width is rw,
  gint            $bounds_height is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_size_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_size_set_min_size (
  GdkToplevelSize $size,
  gint            $min_width,
  gint            $min_height
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_size_set_shadow_width (
  GdkToplevelSize $size,
  gint            $left,
  gint            $right,
  gint            $top,
  gint            $bottom
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_size_set_size (
  GdkToplevelSize $size,
  gint            $width,
  gint            $height
)
  is      native(gdk4)
  is      export
{ * }
