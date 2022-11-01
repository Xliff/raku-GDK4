use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use Pango::Raw::Enums;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Device:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkdevice.h

sub gdk_device_get_caps_lock_state (GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_device_tool (GdkDevice $device)
  returns GdkDeviceTool
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_direction (GdkDevice $device)
  returns PangoDirection
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_display (GdkDevice $device)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_has_cursor (GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_modifier_state (GdkDevice $device)
  returns GdkModifierType
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_name (GdkDevice $device)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_num_lock_state (GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_num_touches (GdkDevice $device)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_product_id (GdkDevice $device)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_scroll_lock_state (GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_seat (GdkDevice $device)
  returns GdkSeat
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_source (GdkDevice $device)
  returns GdkInputSource
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_surface_at_position (
  GdkDevice $device,
  gdouble   $win_x   is rw,
  gdouble   $win_y   is rw
)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_timestamp (GdkDevice $device)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_get_vendor_id (GdkDevice $device)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_has_bidi_layouts (GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
