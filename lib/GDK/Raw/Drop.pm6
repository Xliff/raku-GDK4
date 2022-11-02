use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::Drop:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkdrop.h

sub gdk_drop_finish (GdkDrop $self, GdkDragAction $action)
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_actions (GdkDrop $self)
  returns GdkDragAction
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_device (GdkDrop $self)
  returns GdkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_display (GdkDrop $self)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_drag (GdkDrop $self)
  returns GdkDrag
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_formats (GdkDrop $self)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_surface (GdkDrop $self)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_read_async (
  GdkDrop             $self,
  CArray[Str]         $mime_types,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkDrop, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_read_finish (
  GdkDrop                 $self,
  GAsyncResult            $result,
  CArray[Str]             $out_mime_type,
  CArray[Pointer[GError]] $error
)
  returns GInputStream
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_read_value_async (
  GdkDrop             $self,
  GType               $type,
  gint                $io_priority,
  GCancellable        $cancellable,
                      &callback (GdkDrop, GAsyncResult, gpointer),
  gpointer            $user_data
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_read_value_finish (
  GdkDrop                 $self,
  GAsyncResult            $result,
  CArray[Pointer[GError]] $error
)
  returns GValue
  is      native(gdk4)
  is      export
{ * }

sub gdk_drop_status (
  GdkDrop       $self,
  GdkDragAction $actions,
  GdkDragAction $preferred
)
  is      native(gdk4)
  is      export
{ * }
