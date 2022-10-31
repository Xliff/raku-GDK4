use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Monitor:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkmonitor.h

sub gdk_monitor_get_connector (GdkMonitor $monitor)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_display (GdkMonitor $monitor)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_geometry (
  GdkMonitor   $monitor,
  GdkRectangle $geometry
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_height_mm (GdkMonitor $monitor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_manufacturer (GdkMonitor $monitor)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_model (GdkMonitor $monitor)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_refresh_rate (GdkMonitor $monitor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_scale_factor (GdkMonitor $monitor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_subpixel_layout (GdkMonitor $monitor)
  returns GdkSubpixelLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_get_width_mm (GdkMonitor $monitor)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_monitor_is_valid (GdkMonitor $monitor)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
