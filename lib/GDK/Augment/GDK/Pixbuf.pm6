use v6.c;

use MONKEY-TYPING;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;

use GDK::Pixbuf;

augment class GDK::Pixbuf {

  multi method new (
    GdkSurface() $s,
    Int()        $src_x,
    Int()        $src_y,
    Int()        $width,
    Int()        $height,

                 :gdk_surface(:gdk-surface(
                   :$surface
                 )) is required
  )
    is static
  {
    ::?CLASS.get_from_surface($s, $src_x, $src_y, $width, $height);
  }
  method get_from_surface (
    cairo_surface_t() $surface,
    Int()             $src_x,
    Int()             $src_y,
    Int()             $width,
    Int()             $height
  )
    is static
  {
    my gint ($x, $y, $w, $h) = ($src_x, $src_y, $width, $height);

    my $gdk-pixbuf = gdk_pixbuf_get_from_surface(
      $surface,
      $x,
      $y,
      $w,
      $h
    );

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

  proto method get_from_texture (|)
  { * }

  multi method new (
    GdkTexture $t,

    :gdk_texture(:gdk-texture(:$texture)) is required
  )
    is static
  {
    ::?CLASS.get_from_texture($texture);
  }
  multi method get_from_texture (GdkTexture() $texture) is static {
    my $gdk-pixbuf = gdk_pixbuf_get_from_texture($texture);

    $gdk-pixbuf ?? self.bless( :$gdk-pixbuf ) !! Nil;
  }

}

package GDK::Augment::Pixbuf:ver<4> { };

### /usr/src/gtk4-4.8.1+ds/gdk/gdkpixbuf.h

sub gdk_pixbuf_get_from_surface (
  cairo_surface_t $surface,
  gint            $src_x,
  gint            $src_y,
  gint            $width,
  gint            $height
)
  returns GdkPixbuf
  is      native(gdk4)
  is      export
{ * }

sub gdk_pixbuf_get_from_texture (GdkTexture $texture)
  returns GdkPixbuf
  is      native(gdk4)
  is      export
{ * }
