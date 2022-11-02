use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Drop:ver<4>;

use GLib::Value;
use GIO::InputStream;
use GDK::Device;
use GDK::Display;
use GDK::Surface;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkDropAncestry is export of Mu
  where GdkDrop | GObject;

class GDK::Drop:ver<4> {
  also does GLib::Roles::Object;

  has GdkDrop $!gdk-drop is implementor;

  submethod BUILD ( :$gdk-drop ) {
    self.setGdkDrop($gdk-drop) if $gdk-drop
  }

  method setGdkDrop (GdkDropAncestry $_) {
    my $to-parent;

    $!gdk-drop = do {
      when GdkDrop {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDrop, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDrop
    is also<GdkDrop>
  { $!gdk-drop }

  multi method new (GdkDropAncestry $gdk-drop, :$ref = True) {
    return unless $gdk-drop;

    my $o = self.bless( :$gdk-drop );
    $o.ref if $ref;
    $o;
  }

  # Type: GDKDragAction
  method actions ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::DragAction.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('actions', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          GDK::DragAction.getTypePair
        );
      },
      STORE => -> $, GdkDragAction() $val is copy {
        $gv.object = $val;
        self.prop_set('actions', $gv);
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
      STORE => -> $, GdkDevice() $val is copy {
        $gv.object = $val;
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
      STORE => -> $, $val is copy {
        warn 'display does not allow writing'
      }
    );
  }

  # Type: GDKDrag
  method drag ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Drag').getTypePair );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('drag', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Drag').getTypePair
        );
      },
      STORE => -> $, GdkDrag() $val is copy {
        $gv.object = $val;
        self.prop_set('drag', $gv);
      }
    );
  }

  # Type: GDKContentFormats
  method formats ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Content::Formats').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Content::Formats').getTypePair
        )
      },
      STORE => -> $, GdkContentFormats() $val is copy {
        $gv.object = $val;
        self.prop_set('formats', $gv);
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
          |GDK::Surface.getTypePair
        );
      },
      STORE => -> $, GdkSurface() $val is copy {
        $gv.object = $val;
        self.prop_set('surface', $gv);
      }
    );
  }

  method finish (GdkDragAction() $action) {
    gdk_drop_finish($!gdk-drop, $action);
  }

  method get_actions ( :flags(:$set) = True ) is also<get-actions> {
    my $a = gdk_drop_get_actions($!gdk-drop);
    return $a unless $set;
    getFlags(GdkDragActionEnum, $a);
  }

  method get_device ( :$raw = False ) is also<get-device> {
    propReturnObject(
      gdk_drop_get_device($!gdk-drop),
      $raw,
      |GDK::Device.getTypePair
    );
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_drop_get_display($!gdk-drop),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_drag ( :$raw = False ) is also<get-drag> {
    propReturnObject(
      gdk_drop_get_drag($!gdk-drop),
      $raw,
      |::('GDK::Drag').getTypePair
    );
  }

  method get_formats ( :$raw = False ) is also<get-formats> {
    propReturnObject(
      gdk_drop_get_formats($!gdk-drop),
      $raw,
      |::('GDK::Content::Formats');
    );
  }

  method get_surface( :$raw = False )  is also<get-surface> {
    propReturnObject(
      gdk_drop_get_surface($!gdk-drop),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_drop_get_type, $n,  $t );
  }

  proto method read_async (|)
    is also<read-async>
  { * }

  multi method read_async (
                  @mime_types,
                  &callback,
    gpointer      $user_data   = gpointer,
    GCancellable :$cancellable = GCancellable,
    gint         :$io_priority = G_PRIORITY_DEFAULT
  ) {
    samewith(
      ArrayToCArray(Str, @mime_types),
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method read_async (
    CArray[Str]         $mime_types,
    Int()               $io_priority,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data    = gpointer
  ) {
    my gint $i = $io_priority;

    gdk_drop_read_async(
      $!gdk-drop,
      $mime_types,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method read_finish (|)
    is also<read-finish>
  { * }

  multi method read_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$carray  = False,
                            :$raw     = False
  ) {
    samewith($result, newCArray(CArray[Str]), $error, :$carray);
  }
  multi method read_finish (
    GAsyncResult()           $result,
    CArray[Str]              $out_mime_type,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$carray         = False,
                            :$raw            = False
  ) {
    clear_error;
    my $is = gdk_drop_read_finish($!gdk-drop, $result, $out_mime_type, $error);
    set_error($error);
    my $oa = $out_mime_type;
    $oa = CArrayToArray($oa) unless $carray;
    $is = propReturnObject($is, $raw, |GIO::InputStream.getTypePair);
    ($is, $oa)
  }

  proto method read_value_async (|)
    is also<read-value-async>
  { * }

  multi method read_value_async (
    Int()           $type,
                    &callback,
    gpointer        $user_data   = gpointer,
    Int()          :$io_priority = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($type, $io_priority, $cancellable, &callback, $user_data);
  }
  multi method read_value_async (
    Int()          $type,
    Int()          $io_priority,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my GType $t = $type;
    my gint  $i = $io_priority;

    gdk_drop_read_value_async(
      $!gdk-drop,
      $t,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_value_finish (
    GAsyncResult()            $result,
    CArray[Pointer[GError]]   $error   = gerror,
                             :$raw     = False
  )
    is also<read-value-finish>
  {
    clear_error;
    my $v = gdk_drop_read_value_finish($!gdk-drop, $result, $error);
    set_error($error);
    propReturnObject($v, $raw, |GLib::Value.getTypePair);
  }

  method status (GdkDragAction() $actions, GdkDragAction() $preferred) {
    gdk_drop_status($!gdk-drop, $actions, $preferred);
  }

}
