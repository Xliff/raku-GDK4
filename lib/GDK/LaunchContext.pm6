use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::LaunchContext;

use GIO::LaunchContext;

use GLib::Roles::Implementor;

our subset GdkAppLaunchContextAncestry is export of Mu
  where GdkAppLaunchContext | GAppLaunchContextAncestry;

class GDK::LaunchContext is GIO::LaunchContext {
  has GdkAppLaunchContext $!gdk-alc is implementor;

  submethod BUILD ( :$gdk-launch-context ) {
    self.setGdkAppLaunchContext($gdk-launch-context) if $gdk-launch-context
  }

  method setGdkAppLaunchContext (GdkAppLaunchContextAncestry $_) {
    my $to-parent;

    $!gdk-alc = do {
      when GdkAppLaunchContext {
        $to-parent = cast(GAppLaunchContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkAppLaunchContext, $_);
      }
    }
    self.setGAppLaunchContext($to-parent);
  }

  method GDK::Raw::Definitions::GdkAppLaunchContext
    is also<GdkAppLaunchContext>
  { $!gdk-alc }

  multi method new (
    GdkAppLaunchContextAncestry  $gdk-launch-context,
                                :$ref                 = True
  ) {
    return unless $gdk-launch-context;

    my $o = self.bless( :$gdk-launch-context );
    $o.ref if $ref;
    $o;
  }

  # Type: GDKDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Display').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject( $gv.object, $raw, |::('GDK::Display').getTypePair )
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_app_launch_context_get_display($!gdk-alc),
      $raw,
      ::('GDK::Display').getTypePair
    )
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_app_launch_context_get_type, $n, $t );
  }

  method set_desktop (Int() $desktop) is also<set-desktop> {
    my gint $d = $desktop;

    gdk_app_launch_context_set_desktop($!gdk-alc, $d);
  }

  method set_icon (GIcon() $icon) is also<set-icon> {
    gdk_app_launch_context_set_icon($!gdk-alc, $icon);
  }

  method set_icon_name (Str() $icon_name) is also<set-icon-name> {
    gdk_app_launch_context_set_icon_name($!gdk-alc, $icon_name);
  }

  method set_timestamp (Int() $timestamp) is also<set-timestamp> {
    my guint32 $t = $timestamp;

    gdk_app_launch_context_set_timestamp($!gdk-alc, $t);
  }

}
