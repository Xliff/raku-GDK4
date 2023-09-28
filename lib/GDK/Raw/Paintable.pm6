use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::Paintable:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkpaintable.h

sub gdk_paintable_compute_concrete_size (
  GdkPaintable $paintable,
  gdouble      $specified_width,
  gdouble      $specified_height,
  gdouble      $default_width,
  gdouble      $default_height,
  gdouble      $concrete_width    is rw,
  gdouble      $concrete_height   is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_current_image (GdkPaintable $paintable)
  returns GdkPaintable
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_flags (GdkPaintable $paintable)
  returns GdkPaintableFlags
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_intrinsic_aspect_ratio (GdkPaintable $paintable)
  returns gdouble
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_intrinsic_height (GdkPaintable $paintable)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_intrinsic_width (GdkPaintable $paintable)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_invalidate_contents (GdkPaintable $paintable)
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_invalidate_size (GdkPaintable $paintable)
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_new_empty (
  gint $intrinsic_width,
  gint $intrinsic_height
)
  returns GdkPaintable
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_snapshot (
  GdkPaintable $paintable,
  GdkSnapshot  $snapshot,
  gdouble      $width,
  gdouble      $height
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_paintable_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }


### /usr/src/gtk4-4.8.1+ds/gdk/gdksnapshot.h

sub gdk_snapshot_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
