use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Toplevel::Size:ver<4>;

use GLib::Roles::Implementor;

class GDK::TopLevel::Size {
  also does GLib::Roles::Implementor;

  has GdkToplevelSize $!gdk-tls is implementor;

  submethod BUILD ( :$gdk-toplevel-size ) {
    $!gdk-tls = $gdk-toplevel-size if $gdk-toplevel-size;
  }

  method GDK::Raw::Definitions::GdkToplevelSize
  { $!gdk-tls }

  method new (GdkToplevelSize $gdk-toplevel-size) {
    $gdk-toplevel-size ?? self.bless( :$gdk-toplevel-size ) !! Nil;
  }

  proto method get_bounds (|)
  { * }

  multi method get_bounds {
    samewith($, $);
  }
  multi method get_bounds ($bounds_width is rw, $bounds_height is rw) {
    my gint ($w, $h) = 0 xx 2;

    gdk_toplevel_size_get_bounds($!gdk-tls, $w, $h);
    ($bounds_width, $bounds_height) = ($w, $h);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_toplevel_size_get_type, $n, $t );
  }

  method set_min_size (Int() $min_width, Int() $min_height) {
    my gint ($w, $h) = ($min_width, $min_height);

    gdk_toplevel_size_set_min_size($!gdk-tls, $w, $h);
  }

  method set_shadow_width (
    Int() $left,
    Int() $right,
    Int() $top,
    Int() $bottom
  ) {
    my gint ($l, $r, $t, $b) = ($left, $right, $top, $bottom);

    gdk_toplevel_size_set_shadow_width($!gdk-tls, $l, $r, $t, $b);
  }

  method set_size (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    gdk_toplevel_size_set_size($!gdk-tls, $w, $h);
  }

}
