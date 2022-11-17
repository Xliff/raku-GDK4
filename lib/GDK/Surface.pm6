use v6.c;

use Method::Also;

use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Surface:ver<4>;

use GDK::Cursor;
use GDK::Display;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkSurfaceAncestry is export of Mu
  where GdkSurface | GObject;

class GDK::Surface:ver<4> {
  also does GLib::Roles::Object;
  also does GDK::Roles::Signals::Generic;

  has GdkSurface $!gdk-s is implementor;

  submethod BUILD ( :$gdk-surface ) {
    self.setGdkSurface($gdk-surface) if $gdk-surface
  }

  method setGdkSurface (GdkSurfaceAncestry $_) {
    my $to-parent;

    $!gdk-s = do {
      when GdkSurface {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkSurface, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkSurface
  { $!gdk-s }

  multi method new (GdkSurfaceAncestry $gdk-surface, :$ref = True) {
    return unless $gdk-surface;

    my $o = self.bless( :$gdk-surface );
    $o.ref if $ref;
    $o;
  }

  method new_popup (GdkSurface() $parent, Int() $autohide) is also<new-popup> {
    my gboolean $a = $autohide;

    gdk_surface_new_popup($parent, $a);
  }

  method new_toplevel (GdkDisplay() $display) is also<new-toplevel> {
    gdk_surface_new_toplevel($display);
  }

  # Type: GDKCursor
  method cursor ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Cursor.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('cursor', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Cursor.getTypePair
        );
      },
      STORE => -> $, GdkCursor() $val is copy {
        $gv.object = $val;
        self.prop_set('cursor', $gv);
      }
    );
  }

  # Type: GDKDisplay
  method display ( :$raw = False )  is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Display.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Display.getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: GDKFrameClock
  method frame-clock is rw  is g-property is also<frame_clock> {
    my $gv = GLib::Value.new( ::('GDK::FrameClock').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('frame-clock', $gv);
        $gv.GDKFrameClock;
      },
      STORE => -> $, GdkFrameClock() $val is copy {
        $gv.object = $val;
        self.prop_set('frame-clock', $gv);
      }
    );
  }

  # Type: boolean
  method mapped is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('mapped', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'mapped does not allow writing'
      }
    );
  }

  # Type: int
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'width does not allow writing'
      }
    );
  }

  # Type: int
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        warn 'height does not allow writing'
      }
    );
  }

  # Type: int
  method scale-factor is rw  is g-property is also<scale_factor> {
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

  method layout {
    self.connect-intint($!gdk-s, 'layout');
  }

  method render {
    self.connect-render($!gdk-s);
  }

  method event {
    self.connect-pointer-rbool($!gdk-s, 'event');
  }

  method enter-monitor is also<enter_monitor> {
    self.connect-monitor($!gdk-s, 'enter-monitor');
  }

  method leave-monitor is also<leave_monitor> {
    self.connect-monitor($!gdk-s, 'leave-monitor');
  }

  method beep {
    gdk_surface_beep($!gdk-s);
  }

  method create_cairo_context ( :$raw = False ) is also<create-cairo-context> {
    propReturnObject(
      gdk_surface_create_cairo_context($!gdk-s),
      $raw,
      |::('GDK::CairoContext').getTypePair
    );
  }

  method create_gl_context (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<create-gl-context>
  {
    clear_error
    my $rv = gdk_surface_create_gl_context($!gdk-s, $error);
    set_error($error);
    propReturnObject( $rv, $raw, |::('GDK::GLContext').getTypePair )
  }

  method create_similar_surface (
    cairo_content_t()  $content,
    Int()              $width,
    Int()              $height,
                      :$raw      = False
  )
    is also<create-similar-surface>
  {
    my gint ($w, $h) = ($width, $height);

    propReturnObject(
      gdk_surface_create_similar_surface($!gdk-s, $content, $width, $height),
      $raw,
      cairo_surface_t,
      Cairo::Surface
    );
  }

  method create_vulkan_context (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<create-vulkan-context>
  {
    clear_error;
    my $rv = gdk_surface_create_vulkan_context($!gdk-s, $error);
    set_error($error);
    propReturnObject( $rv, $raw, |::('GDK::VulkanContext').getTypePair )
  }

  method destroy {
    gdk_surface_destroy($!gdk-s);
  }

  method get_cursor ( :$raw = False ) is also<get-cursor> {
    propReturnObject(
      gdk_surface_get_cursor($!gdk-s),
      $raw,
      |GDK::Cursor.getTypePair
    );
  }

  method get_device_cursor (GdkDevice() $device, :$raw = False)
    is also<get-device-cursor>
  {
    propReturnObject(
      gdk_surface_get_device_cursor($!gdk-s, $device),
      $raw,
      |GDK::Cursor.getTypePair
    );
  }

  proto method get_device_position (|)
    is also<get-device-position>
  { * }

  multi method get_device_position (GdkDevice() $device) {
    return-with-all( samewith($device, $, $, $, :all) )
  }
  multi method get_device_position (
    GdkDevice() $device,
                $x       is rw,
                $y       is rw,
                $mask    is rw,
               :$all            = False

  ) {
    my gdouble          ($xx, $yy) = 0e0 xx 2;
    my GdkModifierType   $m        = 0;

    my $rv = gdk_surface_get_device_position($!gdk-s, $device, $xx, $yy, $m);
    ($x, $y, $mask) = ($xx, $yy, $mask);
    $all.not ?? $rv !! ($rv, $x, $y, $mask);
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_surface_get_display($!gdk-s),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_frame_clock ( :$raw = False ) is also<get-frame-clock> {
    propReturnObject(
      gdk_surface_get_frame_clock($!gdk-s),
      $raw,
      |::('GDK::FrameClock').getTypePair
    );
  }

  method get_height is also<get-height> {
    gdk_surface_get_height($!gdk-s);
  }

  method get_mapped is also<get-mapped> {
    so gdk_surface_get_mapped($!gdk-s);
  }

  method get_scale_factor is also<get-scale-factor> {
    gdk_surface_get_scale_factor($!gdk-s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_surface_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gdk_surface_get_width($!gdk-s);
  }

  method hide {
    gdk_surface_hide($!gdk-s);
  }

  method is_destroyed is also<is-destroyed> {
    so gdk_surface_is_destroyed($!gdk-s);
  }

  method queue_render is also<queue-render> {
    gdk_surface_queue_render($!gdk-s);
  }

  method request_layout is also<request-layout> {
    gdk_surface_request_layout($!gdk-s);
  }

  method set_cursor (GdkCursor() $cursor) is also<set-cursor> {
    gdk_surface_set_cursor($!gdk-s, $cursor);
  }

  method set_device_cursor (GdkDevice() $device, GdkCursor() $cursor)
    is also<set-device-cursor>
  {
    gdk_surface_set_device_cursor($!gdk-s, $device, $cursor);
  }

  method set_input_region (cairo_region_t() $region)
    is also<set-input-region>
  {
    gdk_surface_set_input_region($!gdk-s, $region);
  }

  method set_opaque_region (cairo_region_t() $region)
    is also<set-opaque-region>
  {
    gdk_surface_set_opaque_region($!gdk-s, $region);
  }

  proto method translate_coordinates (|)
    is also<translate-coordinates>
  { *}

  multi method translate_coordinates (GdkSurface() $to) {
    samewith($to, $, $);
  }
  multi method translate_coordinates (GdkSurface() $to, $x is rw, $y is rw) {
    my gdouble ($xx, $yy) = 0e0 xx 2;

    gdk_surface_translate_coordinates($!gdk-s, $to, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

}
