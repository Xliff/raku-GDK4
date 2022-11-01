use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Cursor:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkCursorAncestry is export of Mu
  where GdkCursor | GObject;

class GDK::Cursor:ver<4> {
  also does GLib::Roles::Object;

  has GdkCursor $!gdk-c is implementor;

  submethod BUILD ( :$gdk-cursor ) {
    self.setGdkCursor($gdk-cursor) if $gdk-cursor
  }

  method setGdkCursor (GdkCursorAncestry $_) {
    my $to-parent;

    $!gdk-c = do {
      when GdkCursor {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkCursor, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkCursor
    is also<GdkCursor>
  { $!gdk-c }

  multi method new (GdkCursorAncestry $gdk-cursor, :$ref = True) {
    return unless $gdk-cursor;

    my $o = self.bless( :$gdk-cursor );
    $o.ref if $ref;
    $o;
  }

  method new_from_name (
    Str()       $name,
    GdkCursor() $fallback = GdkCursor
  )
    is also<new-from-name>
  {
    my $gdk-cursor = gdk_cursor_new_from_name($!gdk-c, $name, $fallback);

    $gdk-cursor ?? self.bless( :$gdk-cursor ) !! Nil;
  }

  method new_from_texture (
    GdkTexture() $texture,
    Int()        $hotspot_x,
    Int()        $hotspot_y,
    GdkCursor()  $fallback   = GdkCursor
  )
    is also<new-from-texture>
  {
    my gint ($hx, $hy) = ($hotspot_x, $hotspot_y);

    my $gdk-cursor =  gdk_cursor_new_from_texture(
      $texture,
      $hx,
      $hy,
      $fallback
    );

    $gdk-cursor ?? self.bless( :$gdk-cursor ) !! Nil;
  }

  # Type: GDKCursor
  method fallback ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( self.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fallback', $gv);
        propReturnObject( $gv.object, $raw, |self.getTypePair )
      },
      STORE => -> $, GdkCursor() $val is copy {
        $gv.object = $val;
        self.prop_set('fallback', $gv);
      }
    );
  }

  # Type: int
  method hotspot-x is rw  is g-property is also<hotspot_x> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hotspot-x', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('hotspot-x', $gv);
      }
    );
  }

  # Type: int
  method hotspot-y is rw  is g-property is also<hotspot_y> {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('hotspot-y', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('hotspot-y', $gv);
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

  # Type: GDKTexture
  method texture ( :$raw = False ) is rw is g-property {
    my $gv = GLib::Value.new( GDK::Texture.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('texture', $gv);
        propReturnObject( $gv.object, $raw, |GDK::Texture.getTypePair )
      },
      STORE => -> $, GdkTexture() $val is copy {
        $gv.object = $val;
        self.prop_set('texture', $gv);
      }
    );
  }

  method get_fallback ( :$raw = False ) is also<get-fallback> {
    propReturnObject(
      gdk_cursor_get_fallback($!gdk-c),
      $raw,
      |self.getTypePair
    );
  }

  method get_hotspot_x is also<get-hotspot-x> {
    gdk_cursor_get_hotspot_x($!gdk-c);
  }

  method get_hotspot_y is also<get-hotspot-y> {
    gdk_cursor_get_hotspot_y($!gdk-c);
  }

  method get_name is also<get-name> {
    gdk_cursor_get_name($!gdk-c);
  }

  method get_texture ( :$raw = False ) is also<get-texture> {
    propReturnObject(
      gdk_cursor_get_texture($!gdk-c),
      $raw,
      |GDK::Texture.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_cursor_get_type, $n, $t );
  }

}
