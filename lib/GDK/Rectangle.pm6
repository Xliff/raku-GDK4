use v6.c;

use Method::Also;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;

class GDK::Rectangle:ver<4> {
  has GdkRectangle $!gdk-r is implementor handles<x y width height>;

  submethod BUILD ( :$!gdk-r ) { }

  method GDK::Raw::Structs::GdkRectangle
    is also<GdkRectangle>
  { $!gdk-r }

  multi method new (GdkRectangle $gdk-r) {
    return Nil unless $gdk-r;

    self.bless( :$gdk-r );
  }
  multi method new (
    Int() :$x      = 0,
    Int() :$y      = 0,
    Int() :$width  = 0,
    Int() :$height = 0
  ) {
    samewith($x, $y, $width, $height);
  }
  multi method new (Int() $x, Int() $y, Int() $width, Int() $height) {
    my $gdk-r = GdkRectangle.new;
    my $o = ::?CLASS.new($gdk-r);

    $o.x      = $x;
    $o.y      = $y;
    $o.width  = $width;
    $o.height = $height;
  }

  method w    is rw { self.width   }
  method h    is rw { self.height  }

  method gist       { $!gdk-r.gist }

  method contains_point (Int() $x, Int() $y) is also<contains-point> {
    my gint ($xx, $yy) = ($x, $y);

    so gdk_rectangle_contains_point($!gdk-r, $xx, $yy);
  }

  method equal (GdkRectangle() $rect2) {
    so gdk_rectangle_equal($!gdk-r, $rect2);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_rectangle_get_type, $n, $t );
  }

  proto method intersect (|)
  { * }

  multi method intersect (GdkRectangle() $src2, :$raw = False) {
    my $d = GdkRectangle.new;
    return Nil unless $d;

    return-with-all(
      samewith($src2, $d, :all, :$raw)
    );
  }
  multi method intersect (
    GdkRectangle()  $src2,
    GdkRectangle()  $dest is copy,
                   :$all           = False,
                   :$raw           = False,
  ) {
    my $rv = gdk_rectangle_intersect($!gdk-r, $src2, $dest);
    $dest = ::?CLASS.new($dest) if $raw;
    $all.not ?? $rv !! ($rv, $dest);
  }

  proto method union (|)
  { * }

  multi method union (GdkRectangle() $src2, :$raw = False) {
    my $d = GdkRectangle.new;
    return Nil unless $d;

    return-with-all(
      samewith($src2, $d, :all, :$raw)
    );
  }
  multi method union (
    GdkRectangle()  $src2,
    GdkRectangle()  $dest is copy,
                   :$all           = False,
                   :$raw           = False,
  ) {
    my $rv = gdk_rectangle_union($!gdk-r, $src2, $dest);
    $dest = ::?CLASS.new($dest) if $raw;
    $all.not ?? $rv !! ($rv, $dest);
  }

}

### /usr/src/gtk4-4.8.1+ds/gdk/gdkrectangle.h

sub gdk_rectangle_contains_point (
  GdkRectangle $rect,
  gint         $x,
  gint         $y
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rectangle_equal (
  GdkRectangle $rect1,
  GdkRectangle $rect2
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rectangle_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_rectangle_intersect (
  GdkRectangle $src1,
  GdkRectangle $src2,
  GdkRectangle $dest
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_rectangle_union (
  GdkRectangle $src1,
  GdkRectangle $src2,
  GdkRectangle $dest
)
  is      native(gdk4)
  is      export
{ * }
