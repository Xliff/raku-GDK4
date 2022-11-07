use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Content::Deserializer;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcontentdeserializer.h

sub gdk_content_deserialize_async (
  GInputStream        $stream,
  Str                 $mime_type,
  GType               $type,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (
                        GdkContentDeserializer,
                        GAsyncResult,
                        gpointer
                      ),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserialize_finish (
  GAsyncResult            $result,
  GValue                  $value,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_register_deserializer (
  Str                       $mime_type,
  GType                     $type,
                            &deserialize (GdkContentDeserializer),
  gpointer                  $data,
  GDestroyNotify            $notify
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_cancellable (
  GdkContentDeserializer $deserializer
)
  returns GCancellable
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_gtype (GdkContentDeserializer $deserializer)
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_input_stream (
  GdkContentDeserializer $deserializer
)
  returns GInputStream
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_mime_type (
  GdkContentDeserializer $deserializer
)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_priority (
  GdkContentDeserializer $deserializer
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_task_data (
  GdkContentDeserializer $deserializer
)
  returns Pointer
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_user_data (
GdkContentDeserializer $deserializer
)
  returns Pointer
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_get_value (
  GdkContentDeserializer $deserializer
)
  returns GValue
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_return_error (
  GdkContentDeserializer $deserializer,
  Pointer[GError]        $error
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_return_success (
  GdkContentDeserializer $deserializer
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_deserializer_set_task_data (
  GdkContentDeserializer $deserializer,
  gpointer               $data,
                         &notify (gpointer)
)
  is      native(gdk4)
  is      export
{ * }
