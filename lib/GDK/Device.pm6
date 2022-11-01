use v6.c;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Device:ver<4>;

use GDK::Device::Tool:ver<4>;
use GDK::Seat:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkDeviceAncestry is export of Mu
  where GdkDevice | GObject;

class GDK::Device:ver<4> {
  also does GLib::Roles::Object;

  has GdkDevice $!gdk-d is implementor;

  submethod BUILD ( :$gdk-device ) {
    self.setGdkDevice($gdk-device) if $gdk-device
  }

  method setGdkDevice (GdkDeviceAncestry $_) {
    my $to-parent;

    $!gdk-d = do {
      when GdkDevice {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDevice, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDevice
  { $!gdk-d }

  multi method new (GdkDeviceAncestry $gdk-device, :$ref = True) {
    return unless $gdk-device;

    my $o = self.bless( :$gdk-device );
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
        )
      },
      STORE => -> $,  $val is copy {
        $gv.GDKDisplay = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: string
  method name is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('name', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('name', $gv);
      }
    );
  }

  # Type: GDKInputSource
  method source ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkInputSource) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('source', $gv);
        my $r = $gv.valueFromEnum( GdkInputSource );
        $r = GdkInputSourceEnum($r) if $enum;
        $r
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdkInputSource) = $val;
        self.prop_set('source', $gv);
      }
    );
  }

  # Type: boolean
  method has-cursor is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-cursor', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('has-cursor', $gv);
      }
    );
  }

  # Type: uint
  method n-axes is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('n-axes', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        warn 'n-axes does not allow writing'
      }
    );
  }

  # Type: string
  method vendor-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('vendor-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('vendor-id', $gv);
      }
    );
  }

  # Type: string
  method product-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('product-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('product-id', $gv);
      }
    );
  }

  # Type: GDKSeat
  method seat ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Seat.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('seat', $gv);
        propReturnObject($gv.object, $raw, |GDK::Seat.getTypePair);
      },
      STORE => -> $,  $val is copy {
        $gv.GDKSeat = $val;
        self.prop_set('seat', $gv);
      }
    );
  }

  # Type: uint
  method num-touches is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_UINT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('num-touches', $gv);
        $gv.uint;
      },
      STORE => -> $, Int() $val is copy {
        $gv.uint = $val;
        self.prop_set('num-touches', $gv);
      }
    );
  }

  # Type: GDKDeviceTool
  method tool ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Device::Tool.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('tool', $gv);
        propReturnObject($gv.object,$raw, |GDK::Device::Tool.getTypePair)
      },
      STORE => -> $,  $val is copy {
        warn 'tool does not allow writing'
      }
    );
  }

  # Type: PangoDirection
  method direction is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(PangoDirection) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('direction', $gv);
        PangoDirectionEnum( $gv.valueFromEnum(PangoDirection) );
      },
      STORE => -> $,  $val is copy {
        warn 'direction does not allow writing'
      }
    );
  }

  # Type: boolean
  method has-bidi-layouts is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('has-bidi-layouts', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'has-bidi-layouts does not allow writing'
      }
    );
  }

  # Type: boolean
  method caps-lock-state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('caps-lock-state', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'caps-lock-state does not allow writing'
      }
    );
  }

  # Type: boolean
  method num-lock-state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('num-lock-state', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'num-lock-state does not allow writing'
      }
    );
  }

  # Type: boolean
  method scroll-lock-state is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scroll-lock-state', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scroll-lock-state does not allow writing'
      }
    );
  }

  # Type: GDKModifierType
  method modifier-state is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkModifierType) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('modifier-state', $gv);
        GdkModifierTypeEnum( $gv.valueFromEnum(GdkModifierType) )
      },
      STORE => -> $,  $val is copy {
        warn 'modifier-state does not allow writing'
      }
    );
  }

  method get_caps_lock_state {
    gdk_device_get_caps_lock_state($!gdk-d);
  }

  method get_device_tool ( :$raw = False ) {
    propReturnObject(
      gdk_device_get_device_tool($!gdk-d),
      $raw,
      |GDK::Device.getTypePair
    );
  }

  method get_direction {
    PangoDirectionEnum( gdk_device_get_direction($!gdk-d) );
  }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gdk_device_get_display($!gdk-d),
      $raw,
      |::('GDK::Display').getTypePair
    );
  }

  method get_has_cursor {
    so gdk_device_get_has_cursor($!gdk-d);
  }

  method get_modifier_state {
    GdkModifierTypeEnum( gdk_device_get_modifier_state($!gdk-d) );
  }

  method get_name {
    gdk_device_get_name($!gdk-d);
  }

  method get_num_lock_state {
    gdk_device_get_num_lock_state($!gdk-d);
  }

  method get_num_touches {
    gdk_device_get_num_touches($!gdk-d);
  }

  method get_product_id {
    gdk_device_get_product_id($!gdk-d);
  }

  method get_scroll_lock_state {
    gdk_device_get_scroll_lock_state($!gdk-d);
  }

  method get_seat ( :$raw = False ) {
    propReturnObject(
      gdk_device_get_seat($!gdk-d),
      $raw,
      |GDK::Seat.getTypePair
    );
  }

  method get_source ( :$enum = True ) {
    my $is = gdk_device_get_source($!gdk-d);
    return $is unless $enum;
    GdkInputSourceEnum($is)
  }

  proto method get_surface_at_position (|)
  { * }

  multi method get_surface_at_position {
    samewith($, $);
  }
  multi method get_surface_at_position (
     $win_x is rw,
     $win_y is rw,
    :$raw          = False
  ) {
    my gdouble ($wx, $wy) = 0e0 xx 2;

    my $s = gdk_device_get_surface_at_position($!gdk-d, $wx, $wy);
    ($win_x, $win_y) = ($wx, $wy);
    $s = propReturnObject( $s, $raw, |::('GDK::Surface').getTypePair );
    ($s, $win_x, $win_y);
  }

  method get_timestamp {
    gdk_device_get_timestamp($!gdk-d);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_device_get_type, $n, $t );
  }

  method get_vendor_id {
    gdk_device_get_vendor_id($!gdk-d);
  }

  method has_bidi_layouts {
    so gdk_device_has_bidi_layouts($!gdk-d);
  }

}
