use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Content::Provider;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcontentprovider.h

sub gdk_content_provider_content_changed (GdkContentProvider $provider)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_get_value (
  GdkContentProvider      $provider,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_ref_formats (GdkContentProvider $provider)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_ref_storable_formats (GdkContentProvider $provider)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_write_mime_type_async (
  GdkContentProvider  $provider,
  Str                 $mime_type,
  GOutputStream       $stream,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkContentProvider, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_provider_write_mime_type_finish (
  GdkContentProvider      $provider,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
