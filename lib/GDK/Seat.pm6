use v6.c;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Seat:ver<4>;

use GLib::GList;
use GDK::Device::Tool;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GDK::Roles::Signals::Generic:ver<4>;

our subset GdkSeatAncestry is export of Mu
  where GdkSeat | GObject;

class GDK::Seat:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Signals::Generic;

  has GdkSeat $!gdk-s is implementor;

  submethod BUILD ( :$gdk-seat ) {
    self.setGdkSeat($gdk-seat) if $gdk-seat
  }

  method setGdkSeat (GdkSeatAncestry $_) {
    my $to-parent;

    $!gdk-s = do {
      when GdkSeat {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkSeat, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkSeat
  { $!gdk-s }

  multi method new (GdkSeatAncestry $gdk-seat, :$ref = True) {
    return unless $gdk-seat;

    my $o = self.bless( :$gdk-seat );
    $o.ref if $ref;
    $o;
  }

  # Type: GDKDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Display').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Display').getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  method device-added {
    self.connect-device($!gdk-s, 'device-added');
  }

  method device-removed {
    self.connect-device($!gdk-s, 'device-removed');
  }

  method tool-added {
    self.connect-device-tool($!gdk-s, 'tool-added');
  }

  method tool-removed {
    self.connect-device-tool($!gdk-s, 'tool-removed');
  }

  method get_capabilities ( :$set = True ) {
    my $c = gdk_seat_get_capabilities($!gdk-s);
    return $c unless $set;

    getFlags(GdkSeatCapabilitiesEnum, $c)
  }

  method get_devices (Int() $capabilities, :$raw = False, :$glist = False) {
    my GdkSeatCapabilities $c = $capabilities;

    returnGList(
      gdk_seat_get_devices($!gdk-s, $c),
      $raw,
      $glist,
      |::('GDK::Device').getTypePair
    );
  }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gdk_seat_get_display($!gdk-s),
      $raw,
      |::('GDK::Display').getTypePair
    )
  }

  method get_keyboard ( :$raw = False ) {
    propReturnObject(
      gdk_seat_get_keyboard($!gdk-s),
      $raw,
      |::('GDK::Device').getTypePair
    );
  }

  method get_pointer ( :$raw = False ) {
    propReturnObject(
      gdk_seat_get_pointer($!gdk-s),
      $raw,
      |::('GDK::Device').getTypePair
    );
  }

  method get_tools ( :$raw = False, :$glist = False ) {
    propReturnObject(
      gdk_seat_get_tools($!gdk-s),
      $raw,
      $glist,
      |GDK::Device::Tool.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_seat_get_type, $n, $t );
  }

}
