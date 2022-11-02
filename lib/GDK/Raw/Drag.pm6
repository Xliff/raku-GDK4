use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Drag:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkdrag.h

sub gdk_drag_action_is_unique (GdkDragAction $action)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_begin (
  GdkSurface         $surface,
  GdkDevice          $device,
  GdkContentProvider $content,
  GdkDragAction      $actions,
  gdouble            $dx,
  gdouble            $dy
)
  returns GdkDrag
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_drop_done (GdkDrag  $drag, gboolean $success)
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_actions (GdkDrag $drag)
  returns GdkDragAction
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_content (GdkDrag $drag)
  returns GdkContentProvider
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_device (GdkDrag $drag)
  returns GdkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_display (GdkDrag $drag)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_drag_surface (GdkDrag $drag)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_formats (GdkDrag $drag)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_selected_action (GdkDrag $drag)
  returns GdkDragAction
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_surface (GdkDrag $drag)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_drag_set_hotspot (GdkDrag $drag, gint $hot_x, gint $hot_y)
  is      native(gdk4)
  is      export
{ * }
