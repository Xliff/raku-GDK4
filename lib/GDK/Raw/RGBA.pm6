use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::RGBA:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkrgba.h

sub gdk_rgba_copy (GdkRGBA $rgba)
  returns GdkRGBA
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_equal (
  GdkRGBA $p1,
  GdkRGBA $p2
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_free (GdkRGBA $rgba)
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_hash (GdkRGBA $p)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_is_clear (GdkRGBA $rgba)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_is_opaque (GdkRGBA $rgba)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_parse (GdkRGBA $rgba, Str $spec)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_to_string (GdkRGBA $rgba)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_rgba_get_type ()
  returns GType
  is      native(gdk4)
  is      export
{ * }
