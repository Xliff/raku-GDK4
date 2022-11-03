use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Keys:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkkeys.h

sub gdk_keyval_convert_case (
  guint $symbol,
  guint $lower is rw,
  guint $upper is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_from_name (Str $keyval_name)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_is_lower (guint $keyval)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_is_upper (guint $keyval)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_name (guint $keyval)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_to_lower (guint $keyval)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_to_unicode (guint $keyval)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_keyval_to_upper (guint $keyval)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_unicode_to_keyval (guint32 $wc)
  returns guint
  is      native(gdk4)
  is      export
{ * }
