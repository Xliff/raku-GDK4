use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::PopupLayout:ver<4>;

use GLib::Roles::Implementor;

our subset GdkPopupLayoutAncestry is export of Mu
  where GdkPopupLayout | GObject;

class GDK::PopupLayout:ver<4> {
  also does GLib::Roles::Implementor;

  has GdkPopupLayout $!gdk-pul is implementor;

  submethod BUILD ( :$gdk-popup-layout ) {
    $!gdk-pul = $gdk-popup-layout if $gdk-popup-layout
  }

  method GDK::Raw::Definitions::GdkPopupLayout
    is also<GdkPopupLayout>
  { $!gdk-pul }

  multi method new (GdkPopupLayoutAncestry $gdk-popup-layout, :$ref = True) {
    return unless $gdk-popup-layout;

    my $o = self.bless( :$gdk-popup-layout );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GdkRectangle() $anchor_rect,
    Int()          $rect_anchor, 
    Int()          $surface_anchor
  ) {
    my GdkGravity ($ra, $sa) = ($rect_anchor, $surface_anchor);

    my $gdk-popup-layout = gdk_popup_layout_new($anchor_rect, $ra, $sa);

    $gdk-popup-layout ?? self.bless( :$gdk-popup-layout ) !! Nil;
  }

  method anchor_hints is also<anchor-hints> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_anchor_hints    },
      STORE => -> $, \v { self.set_anchor_hints(v) }
  }

  method anchor_rect is also<anchor-rect> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_anchor_rect    },
      STORE => -> $, \v { self.set_anchor_rect(v) }
  }

  method offset is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_offset    },
      STORE => -> $, \v { self.set_offset(v) }
  }

  method rect_anchor is also<rect-anchor> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_rect_anchor    },
      STORE => -> $, \v { self.set_rect_anchor(v) }
  }

  method shadow_width is also<shadow-width> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_shadow_width    },
      STORE => -> $, \v { self.set_shadow_width(v) }
  }

  method surface_anchor is also<surface-anchor> is rw is g-property {
    Proxy.new:
      FETCH => -> $     { self.get_surface_anchor    },
      STORE => -> $, \v { self.set_surface_anchor(v) }
  }

  method copy ( :$raw = False ) {
    propReturnObject(
      gdk_popup_layout_copy($!gdk-pul),
      $raw,
      |self.getTypePair
    );
  }

  method equal (GdkPopupLayout() $other) {
    so gdk_popup_layout_equal($!gdk-pul, $other);
  }

  method get_anchor_hints ( :flags(:$set) = True ) is also<get-anchor-hints> {
    my $h =gdk_popup_layout_get_anchor_hints($!gdk-pul);
    return $h unless $set;
    getFlags(GdkAnchorHintsEnum, $h);
  }

  method get_anchor_rect ( :$raw = False ) is also<get-anchor-rect> {
    propReturnObject(
      gdk_popup_layout_get_anchor_rect($!gdk-pul),
      $raw,
      |GDK::Rectangle.getTypePair
    );
  }

  proto method get_offset (|)
    is also<get-offset>
  { * }

  multi method get_offset {
    samewith($, $);
  }
  multi method get_offset (
    $dx is rw,
    $dy is rw
  ) {
    my gint ($ddx, $ddy) = 0 xx 2;

    gdk_popup_layout_get_offset($!gdk-pul, $ddx, $ddy);
    ($ddx, $ddy) = ($dx, $dy);
  }

  method get_rect_anchor ( :$enum = True ) is also<get-rect-anchor> {
    my $a = gdk_popup_layout_get_rect_anchor($!gdk-pul);
    return $a unless $enum;
    GdkGravityEnum($a);
  }

  proto method get_shadow_width (|)
    is also<get-shadow-width>
  { * }

  multi method get_shadow_width {
    samewith($, $, $, $);
  }
  multi method get_shadow_width (
    $left    is rw,
    $right   is rw,
    $top     is rw,
    $bottom  is rw
  ) {
    my gint ($l, $r, $t, $b) = 0 xx 4;

    gdk_popup_layout_get_shadow_width($!gdk-pul, $l, $r, $t, $b);
    ($left, $right, $top, $bottom) = ($l, $r, $t, $b);
  }

  method get_surface_anchor ( :$enum = True ) is also<get-surface-anchor> {
    my $sa = gdk_popup_layout_get_surface_anchor($!gdk-pul);
    return $sa if $enum;
    GdkGravityEnum($sa);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_popup_layout_get_type, $n, $t );
  }

  method ref {
    gdk_popup_layout_ref($!gdk-pul);
    self;
  }

  method set_anchor_hints (Int() $anchor_hints) is also<set-anchor-hints> {
    my GdkAnchorHints $a = $anchor_hints;

    gdk_popup_layout_set_anchor_hints($!gdk-pul, $a);
  }

  method set_anchor_rect (GdkRectangle() $anchor_rect)
    is also<set-anchor-rect>
  {
    gdk_popup_layout_set_anchor_rect($!gdk-pul, $anchor_rect);
  }

  method set_offset (Int() $dx, Int() $dy) is also<set-offset> {
    my gint ($ddx, $ddy) = ($dx, $dy);

    gdk_popup_layout_set_offset($!gdk-pul, $ddx, $ddy);
  }

  method set_rect_anchor (Int() $anchor) is also<set-rect-anchor> {
    my GdkGravity $a = $anchor;

    gdk_popup_layout_set_rect_anchor($!gdk-pul, $a);
  }

  method set_shadow_width (
    Int() $left,
    Int() $right,
    Int() $top,
    Int() $bottom
  )
    is also<set-shadow-width>
  {
    my gint ($l, $r, $t, $b) = ($left, $right, $top, $bottom);

    gdk_popup_layout_set_shadow_width($!gdk-pul, $l, $r, $t, $b);
  }

  method set_surface_anchor (Int() $anchor) is also<set-surface-anchor> {
    my GdkGravity $a = $anchor;

    gdk_popup_layout_set_surface_anchor($!gdk-pul, $a);
  }

  method unref {
    gdk_popup_layout_unref($!gdk-pul);
  }

}
