use v6.c;

use Method::Also;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GDK::Texture;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkGLTextureAncestry is export of Mu
  where GdkGLTexture | GdkTextureAncestry;

class GDK::GLTexture:ver<4> is GDK::Texture {
  has GdkGLTexture $!gdk-gt is implementor;

  submethod BUILD ( :$gdk-gl-texture ) {
    self.setGdkGLTexture($gdk-gl-texture) if $gdk-gl-texture
  }

  method setGdkGLTexture (GdkGLTextureAncestry $_) {
    my $to-parent;

    $!gdk-gt = do {
      when GdkGLTexture {
        $to-parent = cast(GdkTexture, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkGLTexture, $_);
      }
    }
    self.setGdkTexture($to-parent);
  }

  method GDK::Raw::Definitions::GdkGLTexture
    is also<GdkGLTexture>
  { $!gdk-gt }

  multi method new (GdkGLTextureAncestry $gdk-gl-texture, :$ref = True) {
    return unless $gdk-gl-texture;

    my $o = self.bless( :$gdk-gl-texture );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    GdkGLContext() $c,
    Int()          $id,
    Int()          $width,
    Int()          $height,
                   &destroy  = %DEFAULT-CALLBACKS<GDestroyNotify>,
    gpointer       $data     = gpointer
  ) {
    my gint  ($w, $h) = ($width, $height);
    my guint  $i      =  $id;

    my $gdk-gl-texture = gdk_gl_texture_new($c, $i, $w, $h, &destroy, $data);

    $gdk-gl-texture ?? self.bless( :$gdk-gl-texture ) !! Nil;
  }

  method release {
    gdk_gl_texture_release($!gdk-gt);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_gl_texture_get_type, $n, $t );
  }


}


### /usr/src/gtk4-4.8.1+ds/gdk/gdkgltexture.h

sub gdk_gl_texture_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_texture_new (
  GdkGLContext   $context,
  guint          $id,
  gint           $width,
  gint           $height,
  GDestroyNotify $destroy,
  gpointer       $data
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_texture_release (GdkGLTexture $self)
  is      native(gdk4)
  is      export
{ * }
