use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Display:ver<4>;

use GLib::GList;
use GDK::Clipboard:ver<4>;
use GDK::LaunchContext:ver<4>;
use GDK::Monitor:ver<4>;
use GDK::Seat:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

use GLib::Roles::TypedArray;
use GIO::Roles::ListModel;
use GDK::Roles::Signals::Generic:ver<4>;

our subset GdkDisplayAncestry is export of Mu
  where GdkDisplay | GObject;

class GDK::Display:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Signals::Generic;

  has GdkDisplay $!gdk-d is implementor;

  submethod BUILD ( :$gdk-display ) {
    self.setGdkDisplay($gdk-display) if $gdk-display
  }

  method setGdkDisplay (GdkDisplayAncestry $_) {
    my $to-parent;

    $!gdk-d = do {
      when GdkDisplay {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDisplay, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDisplay
    is also<GdkDisplay>
  { $!gdk-d }

  multi method new (GdkDisplayAncestry $gdk-display, :$ref = True) {
    return unless $gdk-display;

    my $o = self.bless( :$gdk-display );
    $o.ref if $ref;
    $o;
  }

  method open (Str() $name) {
    my $gdk-display = gdk_display_open($name);

    $gdk-display ?? self.bless( :$gdk-display ) !! Nil;
  }

  # Type: boolean
  method composited is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('composited', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'composited does not allow writing'
      }
    );
  }

  # Type: boolean
  method rgba is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('rgba', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'rgba does not allow writing'
      }
    );
  }

  # Type: boolean
  method input-shapes is rw  is g-property is also<input_shapes> {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('input-shapes', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'input-shapes does not allow writing'
      }
    );
  }

  method opened {
    self.connect-display('opened', $!gdk-d)
  }

  method closed {
    self.connect-display-rbool('closed', $!gdk-d);
  }

  method beep {
    gdk_display_beep($!gdk-d);
  }

  method close {
    gdk_display_close($!gdk-d);
  }

  method create_gl_context (
    GdkDisplay()            $self,
    CArray[Pointer[GError]] $error
  )
    is also<create-gl-context>
  {
    gdk_display_create_gl_context($!gdk-d, $error);
  }

  method device_is_grabbed (
    GdkDisplay() $display,
    GdkDevice()  $device
  )
    is also<device-is-grabbed>
  {
    so gdk_display_device_is_grabbed($!gdk-d, $device);
  }

  method flush {
    gdk_display_flush($!gdk-d);
  }

  method get_app_launch_context ( :$raw = False )
    is also<
      get-app-launch-context
      get_launch_context
      get-launch-context
    >
  {
    propReturnObject(
      gdk_display_get_app_launch_context($!gdk-d),
      $raw,
      |GDK::LaunchContext.getTypePair
    );
  }

  method get_clipboard ( :$raw = False ) is also<get-clipboard> {
    propReturnObject(
      gdk_display_get_clipboard($!gdk-d),
      $raw,
      |GDK::Clipboard.getTypePair
    );
  }

  method get_default ( :$raw = False ) is also<get-default> {
    propReturnObject(
      gdk_display_get_default(),
      $raw,
      |self.getTypePair
    );
  }

  method get_default_seat ( :$raw = False ) is also<get-default-seat> {
    propReturnObject(
      gdk_display_get_default_seat($!gdk-d),
      $raw,
      |self.geTypePair
    );
  }

  method get_monitor_at_surface (
    GdkDisplay()  $display,
    GdkSurface()  $surface,
                 :$raw      = False
  )
    is also<get-monitor-at-surface>
  {
    propReturnObject(
      gdk_display_get_monitor_at_surface($!gdk-d, $surface),
      $raw,
      |GDK::Monitor.getTypePair
    );
  }

  method get_monitors ( :$raw = False, :$model = False )
    is also<get-monitors>
  {
    my $ml = propReturnObject(
      gdk_display_get_monitors($!gdk-d),
      $raw,
      |GIO::ListModel.getTypePair
    );
    return $ml if $model;
    $ml.to_array( $raw, |GDK::Monitor.getTypePair )
  }

  method get_name is also<get-name> {
    gdk_display_get_name($!gdk-d);
  }

  method get_primary_clipboard ( :$raw = False )
    is also<get-primary-clipboard>
  {
    propReturnObject(
      gdk_display_get_primary_clipboard($!gdk-d),
      $raw,
      |GDK::Clipboard.getTypePair
    );
  }

  method get_setting (
    GdkDisplay() $display,
    Str()        $name,
    GValue()     $value
  )
    is also<get-setting>
  {
    so gdk_display_get_setting($!gdk-d, $name, $value);
  }

  method get_startup_notification_id is also<get-startup-notification-id> {
    gdk_display_get_startup_notification_id($!gdk-d);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_display_get_type, $n, $t );
  }

  method is_closed is also<is-closed> {
    so gdk_display_is_closed($!gdk-d);
  }

  method is_composited is also<is-composited> {
    so gdk_display_is_composited($!gdk-d);
  }

  method is_rgba is also<is-rgba> {
    so gdk_display_is_rgba($!gdk-d);
  }

  method list_seats ( :$raw = False, :$glist = False ) is also<list-seats> {
    returnGList(
      gdk_display_list_seats($!gdk-d),
      $raw,
      $glist,
      |GDK::Seat.getTypePair
    );
  }

  proto method map_keycode (|)
    is also<map-keycode>
  { * }

  multi method map_keycode (Int() $keycode) {
    return-with-all(
      samewith(
        $keycode,
        newCArray( CArray[GdkKeymapKey] ),
        newCArray( CArray[guint]        ),
        $,
        :all
      )
    );
  }
  multi method map_keycode (
    Int()                         $keycode,
    CArray[CArray[GdkKeymapKey]]  $keys,
    CArray[CArray[guint]]         $keyvals,
                                  $n_entries is rw,
                                 :$all              = False
  ) {
    my gint ($kc, $n) = ($keycode, 0);

    my $rv = gdk_display_map_keycode($!gdk-d, $kc, $keys, $keyvals, $n);
    $n_entries = $n;

    my $keys-out = CArrayToArray( ppr(    $keys[0] ), $n );
    my $kv-out   = CArrayToArray( ppr( $keyvals[0] ), $n );

    $all.not ?? $rv !! ($rv, $keys-out, $kv-out, $n_entries);
  }

  proto method map_keyval (|)
    is also<map-keyval>
  { * }

  multi method map_keyval (Int() $keyval) {
    return-with-all(
      samewith(
        $keyval,
        newCArray( CArray[GdkKeymapKey] ),
        $,
        :all
      )
    )
  }
  multi method map_keyval (
    Int()                         $keyval,
    CArray[CArray[GdkKeymapKey]]  $keys,
                                  $n_keys is rw,
                                 :$all           = False

  ) {
    my guint ($kc, $n) = ($keyval, 0);

    my $rv = gdk_display_map_keyval($!gdk-d, $keyval, $keys, $n);
    $n_keys =  $n;

    my $keys-out = CArrayToArray( ppr( $keys[0] ), $n );

    $all.not ?? $rv !! ($rv, $keys, $n_keys)
  }

  method notify_startup_complete (Str() $startup_id)
    is also<notify-startup-complete>
  {
    gdk_display_notify_startup_complete($!gdk-d, $startup_id);
  }

  method prepare_gl (CArray[Pointer[GError]] $error = gerror)
    is also<prepare-gl>
  {
    clear_error;
    my $rv = gdk_display_prepare_gl($!gdk-d, $error);
    set_error($error);
    $rv;
  }

  method put_event (
    GdkDisplay() $display,
    GdkEvent()   $event
  )
    is also<put-event>
  {
    gdk_display_put_event($!gdk-d, $event);
  }

  method supports_input_shapes is also<supports-input-shapes> {
    so gdk_display_supports_input_shapes($!gdk-d);
  }

  method sync {
    gdk_display_sync($!gdk-d);
  }

  proto method translate_key (|)
    is also<translate-key>
  { * }

  multi method translate_key (Int() $keycode, Int() $state, Int() $group) {
    return-with-all(
      samewith($keycode, $state, $group, $, $, $, $, :all)
    );
  }
  multi method translate_key (
    Int() $keycode,
    Int() $state,
    Int() $group,
          $keyval          is rw,
          $effective_group is rw,
          $level           is rw,
          $consumed        is rw,
         :$all                    = False
  ) {
    my guint             $k      = $keycode;
    my GdkModifierType   $s      = $state;
    my gint              $g      = $group;

    my guint             $kv     = 0;
    my gint             ($e, $l) = 0 xx 2;
    my GdkModifierType   $c      = 0;

    my $rv = gdk_display_translate_key(
      $!gdk-d,
      $keycode,
      $state,
      $group,
      $k,
      $e,
      $l,
      $c
    );
    ($keyval, $effective_group, $level, $consumed) = ($k, $e, $l, $c);
    $all.not ?? $rv !! ($rv, $keyval, $effective_group, $level, $consumed);
  }

  method get_egl_display is also<get-egl-display> {
    gdk_x11_display_get_egl_display($!gdk-d);
  }

  proto method get_egl_version (|)
    is also<get-egl-version>
  { * }

  multi method get_egl_version {
    samewith($, $);
  }
  multi method get_egl_version ($major is rw, $minor is rw) {
    my gint ($j, $n) = 0 xx 2;
    gdk_x11_display_get_egl_version($!gdk-d, $j, $n);
    ($major, $minor) = ($j, $n);
  }

  proto method get_glx_version (|)
    is also<get-glx-version>
  { * }

  multi method get_glx_version {
    samewith($, $);
  }
  multi method get_glx_version ($major is rw, $minor is rw) {
    my gint ($j, $n) = 0 xx 2;
    gdk_x11_display_get_glx_version($!gdk-d, $j, $n);
    ($major, $minor) = ($j, $n);
  }

}
