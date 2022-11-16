use v6.c;

use NativeCall;

use Cairo;
use GLib::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Cairo:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcairo.h

sub gdk_cairo_draw_from_gl (
  cairo_t    $cr,
  GdkSurface $surface,
  gint       $source,
  gint       $source_type,
  gint       $buffer_scale,
  gint       $x,
  gint       $y,
  gint       $width,
  gint       $height
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_rectangle (cairo_t $cr, GdkRectangle $rectangle)
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_region (cairo_t $cr, cairo_region_t $region)
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_region_create_from_surface (cairo_surface_t $surface)
  returns cairo_region_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_set_source_pixbuf (
  cairo_t   $cr,
  GdkPixbuf $pixbuf,
  gdouble   $pixbuf_x,
  gdouble   $pixbuf_y
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_set_source_rgba (cairo_t $cr, GdkRGBA $rgba)
  is      native(gdk4)
  is      export
{ * }
