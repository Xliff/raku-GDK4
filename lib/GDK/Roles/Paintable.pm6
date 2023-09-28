use v6.c;

use Method::Also;

use NativeCall;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Paintable:ver<4>;

use GDK::Snapshot:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GDK::Roles::Paintable:ver<4> {
  has GdkPaintable $!gdk-p is implementor;

  method roleInit-GdkPaintable {
    return if $!gdk-p;

    my \i = findProperImplementor(self.^attributes);
    $!gdk-p = cast( GdkPaintable, i.get_value(self) );
  }

  method GDK::Raw::Definitions::GdkPaintable
  { $!gdk-p }

  method GdkPaintable
  { $!gdk-p }

  method new_empty (Int() $intrinsic_width, Int() $intrinsic_height)
    is also<new-empty>
  {
    my gint ($w, $h) = ($intrinsic_width, $intrinsic_height);

    my $gdk-paintable = gdk_paintable_new_empty($!gdk-p, $w, $h);

    $gdk-paintable ?? self.new( :$gdk-paintable ) !! Nil;
  }

  proto method compute_concrete_size (|)
    is also<compute-concrete-size>
  { * }

  multi method compute_concrete_size (
    Num() $specified_width,
    Num() $specified_height,
    Num() $default_width,
    Num() $default_height,
  ) {
    samewith(
      $specified_width,
      $specified_height,
      $default_width,
      $default_height,
      $,
      $
    );
  }
  multi method compute_concrete_size (
    Num() $specified_width,
    Num() $specified_height,
    Num() $default_width,
    Num() $default_height,
          $concrete_width    is rw,
          $concrete_height   is rw
  ) {
    my gdouble ($sw, $sh, $dw, $dh) =
      ($specified_width, $specified_height, $default_width, $default_height);

    my gdouble ($cw, $ch) = 0e0 xx 2;

    gdk_paintable_compute_concrete_size($!gdk-p, $sw, $sh, $dw, $dh, $cw, $ch);
    ($concrete_width, $concrete_height) = ($cw, $ch);
  }

  method get_current_image ( :$raw = False ) is also<get-current-image> {
    propReturnObject(
      gdk_paintable_get_current_image($!gdk-p),
      $raw,
      |self.getTypePair
    );
  }

  method get_flags ( :set(:$flags) = True ) is also<get-flags> {
    my $f = gdk_paintable_get_flags($!gdk-p);
    return $f unless $flags;
    getFlags(GdkPaintableFlagsEnum, $f);
  }

  method get_intrinsic_aspect_ratio is also<get-intrinsic-aspect-ratio> {
    gdk_paintable_get_intrinsic_aspect_ratio($!gdk-p);
  }

  method get_intrinsic_height is also<get-intrinsic-height> {
    gdk_paintable_get_intrinsic_height($!gdk-p);
  }
  method height {
    self.get_intrinsic_height
  }

  method get_intrinsic_width is also<get-intrinsic-width> {
    gdk_paintable_get_intrinsic_width($!gdk-p);
  }
  method width {
    self.get_intrinsic_width;
  }

  method invalidate_contents is also<invalidate-contents> {
    gdk_paintable_invalidate_contents($!gdk-p);
  }

  method invalidate_size is also<invalidate-size> {
    gdk_paintable_invalidate_size($!gdk-p);
  }

  multi method snapshot (
    GdkPaintable() $paintable,
    Num()          $width,
    Num()          $height,
                  :$raw                  = False
  ) {
    my $snapshot = GDK::Snapshot.new;

    samewith($paintable, $snapshot, $width, $height, :$raw);
  }
  multi method snapshot (
    GdkPaintable() $paintable,
    GdkSnapshot()  $snapshot   is copy,
    Num()          $width,
    Num()          $height,
                  :$raw                  = False
  ) {
    my gdouble ($w, $h) = ($width, $height);

    $snapshot = ::?CLASS.new-obj-ptr(GDK::Snapshot.get_type);

    $snapshot = propReturnObject(
      gdk_paintable_snapshot($!gdk-p, $snapshot, $w, $h),
      $raw,
      |GDK::Snapshot.getTypePair
    );
  }

  method gtkpaintable_get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_paintable_get_type, $n, $t );
  }

}

our subset GdkPaintableAncestry is export of Mu
  where GdkPaintable | GObject;

class GDK::Paintable {
  also does GLib::Roles::Object;
  also does GDK::Roles::Paintable;

  submethod BUILD ( :$gdk-paintable ) {
    self.setGdkPaintable($gdk-paintable) if $gdk-paintable
  }

  method setGdkPaintable (GdkPaintableAncestry $_) {
    my $to-parent;

    $!gdk-p = do {
      when GdkPaintable {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkPaintable, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdkPaintableAncestry $gdk-paintable, :$ref = True) {
    return unless $gdk-paintable;

    my $o = self.bless( :$gdk-paintable );
    $o.ref if $ref;
    $o;
  }

  method get_type {
    self.gtkpaintable_get_type;
  }

}
