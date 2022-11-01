use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Compat:ver<4>;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::Surface:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdksurface.h

sub gdk_surface_beep (GdkSurface $surface)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_create_cairo_context (GdkSurface $surface)
  returns GdkCairoContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_create_gl_context (
  GdkSurface              $surface,
  CArray[Pointer[GError]] $error
)
  returns GdkGLContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_create_similar_surface (
  GdkSurface      $surface,
  cairo_content_t $content,
  gint            $width,
  gint            $height
)
  returns cairo_surface_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_create_vulkan_context (
  GdkSurface              $surface,
  CArray[Pointer[GError]] $error
)
  returns GdkVulkanContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_destroy (GdkSurface $surface)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_cursor (GdkSurface $surface)
  returns GdkCursor
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_device_cursor (
  GdkSurface $surface,
  GdkDevice  $device
)
  returns GdkCursor
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_device_position (
  GdkSurface      $surface,
  GdkDevice       $device,
  gdouble         $x is rw,
  gdouble         $y is rw,
  GdkModifierType $mask
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_display (GdkSurface $surface)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_frame_clock (GdkSurface $surface)
  returns GdkFrameClock
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_height (GdkSurface $surface)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_mapped (GdkSurface $surface)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_scale_factor (GdkSurface $surface)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_get_width (GdkSurface $surface)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_hide (GdkSurface $surface)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_is_destroyed (GdkSurface $surface)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_new_popup (
  GdkSurface $parent,
  gboolean   $autohide
)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_new_toplevel (GdkDisplay $display)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_queue_render (GdkSurface $surface)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_request_layout (GdkSurface $surface)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_set_cursor (
  GdkSurface $surface,
  GdkCursor  $cursor
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_set_device_cursor (
  GdkSurface $surface,
  GdkDevice  $device,
  GdkCursor  $cursor
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_set_input_region (
  GdkSurface     $surface,
  cairo_region_t $region
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_set_opaque_region (
  GdkSurface     $surface,
  cairo_region_t $region
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_surface_translate_coordinates (
  GdkSurface $from,
  GdkSurface $to,
  gdouble    $x     is rw,
  gdouble    $y     is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
