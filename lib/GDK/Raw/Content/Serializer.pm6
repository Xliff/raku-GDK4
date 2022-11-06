use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::Content::Serializer:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcontentserializer.h

sub gdk_content_register_serializer (
  GType                   $type,
  Str                     $mime_type,
                          &serialize (GdkContentSerializer),
  gpointer                $data,
                          &notify (gpointer)
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serialize_async (
  GOutputStream       $stream,
  Str                 $mime_type,
  GValue              $value,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkContentSerializer, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serialize_finish (
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_cancellable (GdkContentSerializer $serializer)
  returns GCancellable
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_gtype (GdkContentSerializer $serializer)
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_mime_type (GdkContentSerializer $serializer)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_output_stream (GdkContentSerializer $serializer)
  returns GOutputStream
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_priority (GdkContentSerializer $serializer)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_task_data (GdkContentSerializer $serializer)
  returns Pointer
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_user_data (GdkContentSerializer $serializer)
  returns Pointer
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_get_value (GdkContentSerializer $serializer)
  returns GValue
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_return_error (
  GdkContentSerializer $serializer,
  Pointer[GError]      $error
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_return_success (GdkContentSerializer $serializer)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_serializer_set_task_data (
  GdkContentSerializer $serializer,
  gpointer             $data,
                       &notify (gpointer)
)
  is      native(gdk4)
  is      export
{ * }
