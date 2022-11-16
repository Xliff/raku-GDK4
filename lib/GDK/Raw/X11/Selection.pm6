
use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::X11::Selection:ver<4>;

### /usr/src/gdk4-4.8.1+ds/gdk/x11/gdkx11selection.h

sub gdk_x11_display_string_to_compound_text (
  GdkDisplay  $display,
  Str         $str,
  CArray[Str] $encoding,
  gint        $format is rw,
  CArray[Str] $ctext,
  gint        $length is rw
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_text_property_to_text_list (
  GdkDisplay          $display,
  Str                 $encoding,
  gint                $format,
  Str                 $text,
  gint                $length,
  CArray[CArray[Str]] $list
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_utf8_to_compound_text (
  GdkDisplay  $display,
  Str         $str,
  CArray[Str] $encoding,
  gint        $format is rw,
  CArray[Str] $ctext,
  gint        $length is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_free_compound_text (Str $ctext)
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_free_text_list (CArray[Str] $list)
  is      native(gdk4)
  is      export
{ * }
