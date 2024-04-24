use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GIO::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Clipboard:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkclipboard.h

sub gdk_clipboard_get_content (GdkClipboard $clipboard)
  returns GdkContentProvider
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_get_display (GdkClipboard $clipboard)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_get_formats (GdkClipboard $clipboard)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_is_local (GdkClipboard $clipboard)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_async (
  GdkClipboard        $clipboard,
  CArray[Str]         $mime_types,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkClipboard, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_finish (
  GdkClipboard            $clipboard,
  GAsyncResult            $result,
  CArray[Str]             $out_mime_type,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_text_async (
  GdkClipboard        $clipboard,
  GCancellable        $cancellable,
                      &callback (GdkClipboard, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_text_finish (
  GdkClipboard            $clipboard,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_texture_async (
  GdkClipboard        $clipboard,
  GCancellable        $cancellable,
                      &callback (GdkClipboard, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_texture_finish (
  GdkClipboard            $clipboard,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_value_async (
  GdkClipboard        $clipboard,
  GType               $type,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkClipboard, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_read_value_finish (
  GdkClipboard            $clipboard,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GValue
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set (
  GdkClipboard $clipboard,
  GType        $type
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set_content (
  GdkClipboard       $clipboard,
  GdkContentProvider $provider
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set_text (
  GdkClipboard $clipboard,
  Str          $text
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set_texture (
  GdkClipboard $clipboard,
  GdkTexture   $texture
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set_valist (
  GdkClipboard $clipboard,
  GType        $type,
  va_list      $args
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_set_value (
  GdkClipboard $clipboard,
  GValue       $value
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_store_async (
  GdkClipboard        $clipboard,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkClipboard, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_clipboard_store_finish (
  GdkClipboard            $clipboard,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
