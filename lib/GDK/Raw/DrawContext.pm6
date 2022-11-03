use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::DrawContext:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkdrawcontext.h

sub gdk_draw_context_begin_frame (
  GdkDrawContext $context,
  cairo_region_t $region
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_end_frame (GdkDrawContext $context)
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_get_display (GdkDrawContext $context)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_get_frame_region (GdkDrawContext $context)
  returns cairo_region_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_get_surface (GdkDrawContext $context)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_draw_context_is_in_frame (GdkDrawContext $context)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
