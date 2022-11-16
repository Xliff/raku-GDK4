use v6.c;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Toplevel::Layout:ver<4>;

# BOXED

use GLib::Roles::Implementor;

class GDK::Toplevel::Layout:ver<4> {
  also does GLib::Roles::Implementor;

  has GdkToplevelLayout $!gdk-tll is implementor;

  submethod BUILD ( :$gdk-top-layout ) {
    $!gdk-tll = $gdk-top-layout if $gdk-top-layout
  }

  method GDK::Raw::Definitions::GdkToplevelLayout
  { $!gdk-tll }

  multi method new (GdkToplevelLayout $gdk-top-layout, :$ref = True) {
    return Nil unless $gdk-top-layout;

    my $o = self.bless( :$gdk-top-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gdk-top-layout = gdk_toplevel_layout_new();

    $gdk-top-layout ?? self.bless( :$gdk-top-layout ) !! Nil;
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gdk_toplevel_layout_copy($!gdk-tll),
      $raw,
      |self.getTypePair
    );
  }

  method equal (GdkToplevelLayout() $other) {
    so gdk_toplevel_layout_equal($!gdk-tll, $other);
  }

  proto method get_fullscreen (|)
  { * }

  multi method get_fullscreen {
    return-with-all( samewith($, :all) );
  }
  multi method get_fullscreen ($fullscreen is rw, :$all = False) {
    my gboolean $f = 0;

    my $rv = so gdk_toplevel_layout_get_fullscreen($!gdk-tll, $f);
    $fullscreen = $f.so;
    $all.not ?? $rv !! ($rv, $fullscreen);
  }

  method get_fullscreen_monitor ( :$raw = False ) {
    propReturnObject(
      gdk_toplevel_layout_get_fullscreen_monitor($!gdk-tll),
      $raw,
      |GDK::Monitor.getTypePair
    );
  }

  proto method get_maximized (|)
  { * }

  multi method get_maximized {
    return-with-all( samewith($, :all) );
  }
  multi method get_maximized ($maximized is rw, :$all = False) {
    my gboolean $m = 0;

    my $rv = so gdk_toplevel_layout_get_maximized($!gdk-tll, $m);
    $maximized = $m;
    $all.not ?? $rv !! ($rv, $maximized);
  }

  method get_resizable {
    so gdk_toplevel_layout_get_resizable($!gdk-tll);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_toplevel_layout_get_type, $n, $t );
  }

  method ref {
    gdk_toplevel_layout_ref($!gdk-tll);
    self
  }

  method set_fullscreen (Int() $fullscreen, GdkMonitor() $monitor) {
    my gboolean $f = $fullscreen.so.Int;

    gdk_toplevel_layout_set_fullscreen($!gdk-tll, $f, $monitor);
  }

  method set_maximized (Int() $maximized) {
    my gboolean $m = $maximized.so.Int;

    gdk_toplevel_layout_set_maximized($!gdk-tll, $m);
  }

  method set_resizable (Int() $resizable) {
    my gboolean $r = $resizable.so.Int;

    gdk_toplevel_layout_set_resizable($!gdk-tll, $r);
  }

  method unref {
    gdk_toplevel_layout_unref($!gdk-tll);
  }

}
