use v6.c;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Monitor:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkMonitorAncestry is export of Mu
  where GdkMonitor | GObject;

class GDK::Monitor:ver<4> {
  also does GLib::Roles::Object;

  has GdkMonitor $!gdk-m is implementor;

  submethod BUILD ( :$gdk-monitor ) {
    self.setGdkMonitor($gdk-monitor) if $gdk-monitor
  }

  method setGdkMonitor (GdkMonitorAncestry $_) {
    my $to-parent;

    $!gdk-m = do {
      when GdkMonitor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkMonitor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkMonitor
  { $!gdk-m }

  multi method new (GdkMonitorAncestry $gdk-monitor, :$ref = True) {
    return unless $gdk-monitor;

    my $o = self.bless( :$gdk-monitor );
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
      STORE => -> $,  $val is copy {
        $gv.GDKDisplay = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: string
  method manufacturer is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('manufacturer', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'manufacturer does not allow writing'
      }
    );
  }

  # Type: string
  method model is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('model', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'model does not allow writing'
      }
    );
  }

  # Type: string
  method connector is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('connector', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        warn 'connector does not allow writing'
      }
    );
  }

  # Type: int
  method scale-factor is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('scale-factor', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'scale-factor does not allow writing'
      }
    );
  }

  # Type: GDKRectangle
  method geometry is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('geometry', $gv);
        cast(GdkRectangle, $gv.boxed);
      },
      STORE => -> $,  $val is copy {
        warn 'geometry does not allow writing'
      }
    );
  }

  # Type: int
  method width-mm is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width-mm', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'width-mm does not allow writing'
      }
    );
  }

  # Type: int
  method height-mm is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height-mm', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height-mm does not allow writing'
      }
    );
  }

  # Type: int
  method refresh-rate is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('refresh-rate', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'refresh-rate does not allow writing'
      }
    );
  }

  # Type: GDKSubpixelLayout
  method subpixel-layout ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkSubpixelLayout) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('subpixel-layout', $gv);
        GdkSubpixelLayout(
          $gv.valueFromEnum(GdkSubpixelLayout)
        )
      },
      STORE => -> $, $val is copy {
        warn 'subpixel-layout does not allow writing'
      }
    );
  }

  # Type: boolean
  method valid is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('valid', $gv);
        $gv.boolean;
      },
      STORE => -> $, $val is copy {
        warn 'valid does not allow writing'
      }
    );
  }

  method get_connector {
    gdk_monitor_get_connector($!gdk-m);
  }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gdk_monitor_get_display($!gdk-m),
      $raw;
      |::('GDK::Display').getTypePair
    );
  }

  multi method get_geometry (|)
  { * }

  multi method get_geometry {
    samewith(GdkRectangle.new);
  }
  multi method get_geometry (GdkRectangle() $geometry) {
    gdk_monitor_get_geometry($!gdk-m, $geometry);
  }

  method get_height_mm {
    gdk_monitor_get_height_mm($!gdk-m);
  }

  method get_manufacturer {
    gdk_monitor_get_manufacturer($!gdk-m);
  }

  method get_model {
    gdk_monitor_get_model($!gdk-m);
  }

  method get_refresh_rate {
    gdk_monitor_get_refresh_rate($!gdk-m);
  }

  method get_scale_factor {
    gdk_monitor_get_scale_factor($!gdk-m);
  }

  method get_subpixel_layout {
    gdk_monitor_get_subpixel_layout($!gdk-m);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_monitor_get_type, $n, $t );
  }

  method get_width_mm {
    gdk_monitor_get_width_mm($!gdk-m);
  }

  method is_valid {
    so gdk_monitor_is_valid($!gdk-m);
  }

  method fullInfo {
    qq:to/INFO/.chomp;
      Manufacturer: { self.manufacturer }
      Model:        { self.model }
      Resolution:   { self.geometry.width } x { self.geometry.height }
      Refresh Rate: { self.refresh-rate }
      Scale Factor: { self.scale-factor }
      Aspect Ratio: { self.width-mm div 100 }:{ self.height-mm div 100 }
      INFO
  }

}
