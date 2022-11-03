use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use Pango::Layout;
use Pango::LayoutLine;

use MONKEY-TYPING;

augment class Pango::Layout {

  proto method layout_get_clip_region (|)
  { * }

  multi method layout_get_clip_region (
    Int() $x_origin,
    Int() $y_origin,
          @ranges
  ) {
    samewith(
      $x_origin,
      $y_origin,
      ArrayToCArray(gint, @ranges);
      @ranges.elems
    );
  }
  multi method layout_get_clip_region (
    Int()         $x_origin,
    Int()         $y_origin,
    CArray[gint]  $indexes,
    Int()         $n_ranges,
                 :$raw       = False
  ) {
    my gint ($xo, $yo, $n) = ($x_origin, $y_origin, $n_ranges);

    propReturnObject(
      gdk_pango_layout_get_clip_region(
        self.PangoLayout,
        $xo,
        $yo,
        $indexes,
        $n
      ),
      $raw,
      cairo_region_t,
      Cairo::Region
    );
  }

}

augment class Pango::LayoutLine {

  proto method layout_line_get_clip_region (|)
  { * }

  multi method layout_line_get_clip_region (
    Int() $x_origin,
    Int() $y_origin,
          @ranges
  ) {
    samewith(
      $x_origin,
      $y_origin,
      ArrayToCArray(gint, @ranges);
      @ranges.elems
    );
  }
  multi method layout_line_get_clip_region (
    Int()         $x_origin,
    Int()         $y_origin,
    CArray[gint]  $indexes,
    Int()         $n_ranges,
                 :$raw       = False
  ) {
    my gint ($xo, $yo, $n) = ($x_origin, $y_origin, $n_ranges);

    propReturnObject(
      gdk_pango_layout_line_get_clip_region(
        self.PangoLayoutLine,
        $xo,
        $yo,
        $indexes,
        $n
      ),
      $raw,
      cairo_region_t,
      Cairo::Region
    );
  }

}


### /usr/src/gtk4-4.8.1+ds/gdk/gdkpango.h

sub gdk_pango_layout_get_clip_region (
  PangoLayout $layout,
  gint        $x_origin,
  gint        $y_origin,
  gint        $index_ranges is rw,
  gint        $n_ranges
)
  returns cairo_region_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_pango_layout_line_get_clip_region (
  PangoLayoutLine $line,
  gint            $x_origin,
  gint            $y_origin,
  gint            $index_ranges is rw,
  gint            $n_ranges
)
  returns cairo_region_t
  is      native(gdk4)
  is      export
{ * }
