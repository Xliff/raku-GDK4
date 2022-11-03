use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Display::Manager:ver<4>;

use GLib::GSList;
use GDK::Display:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;


our subset GdkDisplayManagerAncestry is export of Mu
  where GdkDisplayManager | GObject;

class GDK::Display::Manager {
  also does GLib::Roles::Object;

  has GdkDisplayManager $!gdk-dm is implementor;

  submethod BUILD ( :$gdk-display-manager ) {
    self.setGdkDisplaymanager($gdk-display-manager)
      if $gdk-display-manager
  }

  method setGdkDisplaymanager (GdkDisplayManagerAncestry $_) {
    my $to-parent;

    $!gdk-dm = do {
      when GdkDisplayManager {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDisplayManager, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDisplayManager
    is also<GdkDisplayManager>
  { $!gdk-dm }

  multi method new (
    GdkDisplayManagerAncestry  $gdk-display-manager,
                              :$ref                  = True
  ) {
    return unless $gdk-display-manager;

    my $o = self.bless( :$gdk-display-manager );
    $o.ref if $ref;
    $o;
  }

  method set_allowed_backends (Str() $backends)
    is also<set-allowed-backends>
  {
    gdk_set_allowed_backends($backends);
  }

  method get {
    my $gdk-display-manager = gdk_display_manager_get();

    $gdk-display-manager ?? self.bless( :$gdk-display-manager ) !! Nil;
  }

  # Type: GDKDisplay
  method default-display ( :$raw = False )
    is rw
    is g-property
    is also<default_display>
  {
    my $gv = GLib::Value.new( GDK::Display.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('default-display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Display.getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('default-display', $gv);
      }
    );
  }


  method display-opened is also<display_opened> {
    self.connect($!gdk-dm, 'display-opened');
  }

  method get_default_display ( :$raw = False )
    is also<get-default-display>
  {
    propReturnObject(
      gdk_display_manager_get_default_display($!gdk-dm),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_display_manager_get_type, $n, $t );
  }

  method list_displays ( :$raw = False, :$glist = False ) is also<list-displays> {
    returnGSList(
      gdk_display_manager_list_displays($!gdk-dm),
      $raw,
      $glist,
      |GDK::Display.getTypePair
    );
  }

  method open_display (Str() $name, :$raw = False) is also<open-display> {
    propReturnObject(
      gdk_display_manager_open_display($!gdk-dm, $name),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method set_default_display (GdkDisplay() $display) is also<set-default-display> {
    gdk_display_manager_set_default_display($!gdk-dm, $display);
  }

}
