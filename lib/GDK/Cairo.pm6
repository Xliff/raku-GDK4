use v6.c;

use Cairo;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Cairo:ver<4>;

use MONKEY-TYPING;

augment class Cairo::Context {

  method draw_from_gl (
    GdkSurface() $surface,
    Int()        $source,
    Int()        $source_type,
    Int()        $buffer_scale,
    Int()        $x,
    Int()        $y,
    Int()        $width,
    Int()        $height
  ) {
    my gint ($ss, $st, $bs, $xx, $yy, $w, $h) =
      ($source, $source_type, $buffer_scale, $x, $y, $width, $height);

    gdk_cairo_draw_from_gl(
      self.context,
      $surface,
      $ss,
      $st,
      $bs,
      $xx,
      $yy,
      $w,
      $h
    )
  }

  multi method rectangle (GdkRectangle() $rectangle, :$gdk is required) {
    gdk_cairo_rectangle(self.context, $rectangle);
  }

  method region (cairo_region_t() $region) {
    gdk_cairo_region(self.context, $region);
  }

  method cairo_set_source_pixbuf (
    GdkPixbuf() $pixbuf,
    Num()       $pixbuf_x,
    Num()       $pixbuf_y
  ) {
    my gdouble ($px, $py);

    gdk_cairo_set_source_pixbuf(self.context, $pixbuf, $px, $py);
  }

  method cairo_set_source_rgba (GdkRGBA() $rgba) {
    gdk_cairo_set_source_rgba(self.context, $rgba);
  }
}

augment class Cairo::Surface {

  method create_region_from_surface {
    #Cairo::Region.new(
      gdk_cairo_region_create_from_surface(self.surface)
    #);
  }

  method Cairo::cairo_surface_t {
    self.surface
  }

}
