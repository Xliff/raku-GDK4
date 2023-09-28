use v6.c;

use NativeCall;
use Method::Also;

use GDK::Raw::Types:ver<4>;

use GDK::GLContext;

use GLib::Roles::Implementor;

our subset GdkX11GLContextAncestry is export of Mu
  where GdkX11GLContext | GdkGLContextAncestry;

class GDK::X11::GLContext:ver<4> is GDK::GLContext {
  has GdkX11GLContext $!gxgc is implementor;

  submethod BUILD ( :$gdk-gl-context ) {
    self.setGdkX11GLContext($gdk-gl-context) if $gdk-gl-context
  }

  method setGdkX11GLContext (GdkX11GLContextAncestry $_) {
    my $to-parent;

    $!gxgc = do {
      when GdkX11GLContext {
        $to-parent = cast(GdkGLContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkX11GLContext, $_);
      }
    }
    self.setGdkGLContext($to-parent);
  }

  method GDK::Raw::Definitions::GdkX11GLContext
    is also<GdkX11GLContext>
  { $!gxgc }

  multi method new (
     $gdk-gl-context where * ~~ GdkX11GLContextAncestry,

    :$ref = True
  ) {
    return unless $gdk-gl-context;

    my $o = self.bless( :$gdk-gl-context );
    $o.ref if $ref;
    $o;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_x11_gl_context_get_type, $n, $t );
  }

}

sub gdk_x11_gl_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
