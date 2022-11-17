use v6.c;

use Method::Also;

use NativeCall;

use Cairo;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;

use GDK::DrawContext;

use GLib::Roles::Implementor;

our subset GdkCairoContextAncestry is export of Mu
  where GdkCairoContext | GdkDrawContextAncestry;

class GDK::CairoContext:ver<4> is GDK::DrawContext {
  has GdkCairoContext $!gdk-cc is implementor;

  submethod BUILD ( :$gdk-cairo-context ) {
    self.setGdkCairoContext($gdk-cairo-context) if $gdk-cairo-context
  }

  method setGdkCairoContext (GdkCairoContextAncestry $_) {
    my $to-parent;

    $!gdk-cc = do {
      when GdkCairoContext {
        $to-parent = cast(GdkDrawContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkCairoContext, $_);
      }
    }
    self.setGdkDrawContext($to-parent);
  }

  method GDK::Raw::Definitions::GdkCairoContext
    is also<GdkCairoContext>
  { $!gdk-cc }

  multi method new (
    GdkCairoContextAncestry  $gdk-cairo-context,
                            :$ref                = True
  ) {
    return unless $gdk-cairo-context;

    my $o = self.bless( :$gdk-cairo-context );
    $o.ref if $ref;
    $o;
  }

  method cairo_create ( :$raw = False ) is also<cairo-create> {
    propReturnObject(
      gdk_cairo_context_cairo_create($!gdk-cc),
      $raw,
      cairo_t,
      Cairo::Context
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_cairo_context_get_type, $n, $t );
  }
}

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcairocontext.h

sub gdk_cairo_context_cairo_create (GdkCairoContext $self)
  returns cairo_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_cairo_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
