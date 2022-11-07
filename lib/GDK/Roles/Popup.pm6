use v6.c;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Popup:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GDK::Roles::Popup:ver<4> {
  has GdkPopup $!gdk-pop is implementor;

  method roleInit-GdkPopup {
    return if $!gdk-pop;

    my \i = findProperImplementor(self.^attributes);
    $!gdk-pop = cast( GdkPopup, i.get_value(self) )
  }

  method GDK::Raw::Definitions::GdkPopup
  { $!gdk-pop }

  method GdkPopup { $!gdk-pop }

  method get_autohide {
    so gdk_popup_get_autohide($!gdk-pop);
  }

  method get_parent ( :$raw = False ) {
    propReturnObject(
      gdk_popup_get_parent($!gdk-pop),
      $raw,
      |GDK::Surface.getTypePair
    )
  }

  method get_position_x {
    gdk_popup_get_position_x($!gdk-pop);
  }

  method get_position_y {
    gdk_popup_get_position_y($!gdk-pop);
  }

  method get_rect_anchor ( :$enum = True ) {
    my $ra = gdk_popup_get_rect_anchor($!gdk-pop);
    return $ra unless $enum;
    GdkGravityEnum($ra);
  }

  method get_surface_anchor ( :$enum = True ) {
    my $sa = gdk_popup_get_surface_anchor($!gdk-pop);
    return $sa unless $enum;
    GdkGravityEnum($sa);
  }

  method present (
    Int()            $width,
    Int()            $height,
    GdkPopupLayout() $layout
  ) {
    my gint ($w, $h) = ($width, $height);

    so gdk_popup_present($!gdk-pop, $w, $h, $layout);
  }

}


our subset GdkPopupAncestry is export of Mu
  where GdkPopup | GObject;

class GDK::Popup:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Popup;

  submethod BUILD ( :$gdk-popup ) {
    self.setGdkPopup($gdk-popup) if $gdk-popup
  }

  method setGdkPopup (GdkPopupAncestry $_) {
    my $to-parent;

    $!gdk-pop = do {
      when GdkPopup {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkPopup, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdkPopupAncestry $gdk-popup, :$ref = True) {
    return unless $gdk-popup;

    my $o = self.bless( :$gdk-popup );
    $o.ref if $ref;
    $o;
  }

}
