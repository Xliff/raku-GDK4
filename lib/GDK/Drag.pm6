use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Drag:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkDragAncestry is export of Mu
  where GdkDrag | GObject;

class GDK::Drag:ver<4> {
  also does GLib::Roles::Object;

  has GdkDrag $!gdk-drag is implementor;

  submethod BUILD ( :$gdk-drag ) {
    self.setGdkDrag($gdk-drag) if $gdk-drag
  }

  method setGdkDrag (GdkDragAncestry $_) {
    my $to-parent;

    $!gdk-drag = do {
      when GdkDrag {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDrag, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDrag
    is also<GdkDrag>
  { $!gdk-drag }

  multi method new (GdkDragAncestry $gdk-drag, :$ref = True) {
    return unless $gdk-drag;

    my $o = self.bless( :$gdk-drag );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GdkDevice()          $device,
    GdkContentProvider() $content,
    GdkDragAction()      $actions,
    Num()                $dx,
    Num()                $dy
  ) {
    self.begin($device, $content, $actions, $dx, $dy);
  }

  method begin (
    GdkDevice()          $device,
    GdkContentProvider() $content,
    GdkDragAction()      $actions,
    Num()                $dx,
    Num()                $dy
  ) {
    my gdouble ($ddx, $ddy) = ($dx, $dy);

    my $gdk-drag = gdk_drag_begin(
      $!gdk-drag,
      $device,
      $content,
      $actions,
      $ddx,
      $ddy
    );

    $gdk-drag ?? self.bless( :$gdk-drag ) !! Nil
  }

  # Type: GDKContentProvider
  method content ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Content::Provider.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::Content::Provider.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GDKContentProvider = $val;
        self.prop_set('content', $gv);
      }
    );
  }

  # Type: GDKDevice
  method device ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Device.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('device', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::Device.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GDKDevice = $val;
        self.prop_set('device', $gv);
      }
    );
  }

  # Type: GDKDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Display.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::Display.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'display does not allow writing'
      }
    );
  }

  # Type: GDKContentFormats
  method formats ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Content::Formats.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::Content::Formats.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GDKContentFormats = $val;
        self.prop_set('formats', $gv);
      }
    );
  }

  # Type: GDKDragAction
  method selected-action ( :$enum = True ) is rw  is g-property
    is also<selected_action>
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkDragAction) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('selected-action', $gv);
        my $a = $gv.valueFromEnum(GdkDragAction);
        $a = GdkDragActionEnum($a) if $enum;
        $a;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdkDragAction) = $val;
        self.prop_set('selected-action', $gv);
      }
    );
  }

  # Type: GDKDragAction
  method actions is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkDragAction) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('actions', $gv);
        $gv.valueFromEnum(GdkDragAction);
      },
      STORE => -> $, $val is copy {
        $val = fromFlagish(GdkDragActionEnum, $val);
        die '$val must be an Int-compatible value when setting .actions!'
          unless $val ~~ Int;
        $gv.valueFromEnum(GdkDragAction) = $val;
        self.prop_set('actions', $gv);
      }
    );
  }

  # Type: GDKSurface
  method surface ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Surface.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('surface', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::Surface.getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        $gv.GDKSurface = $val;
        self.prop_set('surface', $gv);
      }
    );
  }

  method action_is_unique is also<action-is-unique> {
    so gdk_drag_action_is_unique($!gdk-drag);
  }

  method drop_done (GdkDrag() $drag, Int() $success) is also<drop-done> {
    my gboolean $s = $success.so.Int;

    gdk_drag_drop_done($!gdk-drag, $s);
  }

  method get_actions ( :flags(:$set) = True ) is also<get-actions> {
    my $a = gdk_drag_get_actions($!gdk-drag);
    return $a unless $set;
    getFlags(GdkDragAction, $a);
  }

  method get_content ( :$raw = False ) is also<get-content> {
    propReturnObject(
      gdk_drag_get_content($!gdk-drag),
      $raw,
      |GDK::Content::Provider.getTypePair
    )
  }

  method get_device ( :$raw = False ) is also<get-device> {
    propReturnObject(
      gdk_drag_get_device($!gdk-drag),
      $raw,
      |GDK::Device.getTypePair
    )
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_drag_get_display($!gdk-drag),
      $raw,
      |GDK::Display.getTypePair
    )
  }

  method get_drag_surface ( :$raw = False ) is also<get-drag-surface> {
    propReturnObject(
      gdk_drag_get_drag_surface($!gdk-drag),
      $raw,
      |GDK::Surface.getTypePair
    )
  }

  method get_formats ( :$raw = False ) is also<get-formats> {
    propReturnObject(
      gdk_drag_get_formats($!gdk-drag),
      $raw,
      |GDK::Content::Formats.getTypePair
    )
  }

  method get_selected_action ( :$enum = True ) is also<get-selected-action> {
    my $a = gdk_drag_get_selected_action($!gdk-drag);
    return $a unless $enum;
    GdkDragActionEnum($a);
  }

  method get_surface ( :$raw = False ) is also<get-surface> {
    propReturnObject(
      gdk_drag_get_surface($!gdk-drag),
      $raw,
      |GDK::Surface.getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_drag_get_type, $n, $t );
  }

  method set_hotspot (Int() $hot_x, Int() $hot_y) is also<set-hotspot> {
    my gint ($hx, $hy) = ($hot_x, $hot_y);

    gdk_drag_set_hotspot($!gdk-drag, $hx, $hy);
  }

}
