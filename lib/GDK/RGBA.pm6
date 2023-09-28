use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::RGBA:ver<4>;

use GLib::Roles::Implementor;

class GDK::RGBA {
  also does GLib::Roles::Implementor;

  has GdkRGBA $!gdk-rgba is implementor handles <red green blue alpha>;

  submethod BUILD ( :$!gdk-rgba ) { }

  method GDK::Raw::Structs::GdkRGBA
    is also<GdkRGBA>
  { $!gdk-rgba }

  multi method new (GdkRGBA $gdk-rgba) {
    return unless $gdk-rgba;

    self.bless( :$gdk-rgba );
  }

  multi method new (
    :r(:$red)    is copy = 0e0,
    :g(:$green)  is copy = 0e0,
    :b(:$blue)   is copy = 0e0,
    :a(:$alpha)  is copy = 0e0
  ) {
    for $red, $green, $blue, $alpha -> $_ is raw {
      $_   /= 255 if $_  ~~ Int;
      if $red !~~ Num {
        die "<{ $_ }> value must be Num compatible!" unless .^can('Num');
        $_ .= Num;
      }
    }

    samewith($red, $green, $blue, $alpha);
  }

  multi method new (Num() $red, Num() $green, Num() $blue, Num() $alpha) {
    my $gdk-rgba = GdkRGBA.new;
    my $o = ::?CLASS.new($gdk-rgba);

    return Nil unless $o;

    $o.r = $red;
    $o.g = $green;
    $o.b = $blue;
    $o.a = $alpha;
    $o;
  }

  method r       is rw { self.red        }
  method g       is rw { self.green      }
  method b       is rw { self.blue       }
  method a       is rw { self.alpha      }

  method gist          { $!gdk-rgba.gist }

  method copy {
    gdk_rgba_copy($!gdk-rgba);
  }

  method equal (GdkRGBA() $p2) {
    so gdk_rgba_equal($!gdk-rgba, $p2);
  }

  method free {
    gdk_rgba_free($!gdk-rgba);
  }

  method hash {
    gdk_rgba_hash($!gdk-rgba);
  }

  method is_clear {
    so gdk_rgba_is_clear($!gdk-rgba);
  }

  method is_opaque {
    so gdk_rgba_is_opaque($!gdk-rgba);
  }

  multi method parse (GDK::RGBA:U: Str() $spec) {
    samewith(GdkRGBA.new, $spec);
  }
  multi method parse (GDK::RGBA:U: GdkRGBA() $rgba, Str() $spec) {
    gdk_rgba_parse($rgba, $spec);
    $rgba;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_rgba_get_type, $n, $t );
  }

  method to_string {
    gdk_rgba_to_string($!gdk-rgba);
  }

}
