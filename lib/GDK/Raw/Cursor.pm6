use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Cursor:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcursor.h

sub gdk_cursor_get_fallback (GdkCursor $cursor)
  returns GdkCursor
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_get_hotspot_x (GdkCursor $cursor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_get_hotspot_y (GdkCursor $cursor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_get_name (GdkCursor $cursor)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_get_texture (GdkCursor $cursor)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_new_from_name (
  Str       $name,
  GdkCursor $fallback
)
  returns GdkCursor
  is      native(gdk4)
  is      export
{ * }

sub gdk_cursor_new_from_texture (
  GdkTexture $texture,
  gint       $hotspot_x,
  gint       $hotspot_y,
  GdkCursor  $fallback
)
  returns GdkCursor
  is      native(gdk4)
  is      export
{ * }
