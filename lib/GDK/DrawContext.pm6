use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::DrawContext:ver<4>;

use GDK::Surface;
use GDK::Display;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkDrawContextAncestry is export of Mu
  where GdkDrawContext | GObject;

class GDK::DrawContext {
  also does GLib::Roles::Object;

  has GdkDrawContext $!gdk-dc is implementor;

  submethod BUILD ( :$gdk-draw-context ) {
    self.setGdkDrawContext($gdk-draw-context) if $gdk-draw-context
  }

  method setGdkDrawContext (GdkDrawContextAncestry $_) {
    my $to-parent;

    $!gdk-dc = do {
      when GdkDrawContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDrawContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDrawContext
    is also<GdkDrawContext>
  { $!gdk-dc }

  multi method new (GdkDrawContextAncestry $gdk-draw-context, :$ref = True) {
    return unless $gdk-draw-context;

    my $o = self.bless( :$gdk-draw-context );
    $o.ref if $ref;
    $o;
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
          |GDK::Display.getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
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

  method begin_frame (cairo_region_t() $region) is also<begin-frame> {
    gdk_draw_context_begin_frame($!gdk-dc, $region);
  }

  method end_frame is also<end-frame> {
    gdk_draw_context_end_frame($!gdk-dc);
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_draw_context_get_display($!gdk-dc),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_frame_region ( :$raw = False ) is also<get-frame-region> {
    propReturnObject(
      gdk_draw_context_get_frame_region($!gdk-dc),
      $raw,
      cairo_region_t,
      Cairo::Region
    );
  }

  method get_surface ( :$raw = False ) is also<get-surface> {
    propReturnObject(
      gdk_draw_context_get_surface($!gdk-dc),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_draw_context_get_type, $n, $t );
  }

  method is_in_frame is also<is-in-frame> {
    so gdk_draw_context_is_in_frame($!gdk-dc);
  }

}
