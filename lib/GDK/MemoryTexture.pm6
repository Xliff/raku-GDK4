use v6.c;

use Method::Also;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GDK::Texture:ver<4>;

our subset GdkMemoryTextureAncestry is export of Mu
  where GdkMemoryTexture | GdkTextureAncestry;

class GDK::MemoryTexture:ver<4> is GDK::Texture:ver<4> {
  has GdkMemoryTexture $!gdk-mt is implementor;

  submethod BUILD ( :$gdk-memory-texture ) {
    self.setGdkMemoryTexture($gdk-memory-texture) if $gdk-memory-texture
  }

  method setGdkMemoryTexture (GdkMemoryTextureAncestry $_) {
    my $to-parent;

    $!gdk-mt = do {
      when GdkMemoryTexture {
        $to-parent = cast(GdkTexture, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkMemoryTexture, $_);
      }
    }
    self.setGdkTexture($to-parent);
  }

  method GDK::Raw::Definitions::GdkMemoryTexture
    is also<GdkMemoryTexture>
  { $!gdk-mt }

  multi method new (
    GdkMemoryTextureAncestry  $gdk-memory-texture,
                             :$ref                  = True
  ) {
    return unless $gdk-memory-texture;

    my $o = self.bless( :$gdk-memory-texture );
    $o.ref if $ref;
    $o;
  }
  multi method new (
    Int()    $width,
    Int()    $height,
    Int()    $format,
    GBytes() $bytes,
    Int()    $stride
  ) {
    my gint            ($w, $h) = ($width, $height);
    my GdkMemoryFormat  $f      =  $format;
    my gsize            $s      =  $stride;

    my $gdk-memory-texture = gdk_memory_texture_new($w, $h, $f, $bytes, $s);

    $gdk-memory-texture ?? self.bless( :$gdk-memory-texture ) !! Nil;
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_memory_texture_get_type, $n, $t );
  }


}



### /usr/src/gtk4-4.8.1+ds/gdk/gdkmemorytexture.h

sub gdk_memory_texture_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_memory_texture_new (
  gint            $width,
  gint            $height,
  GdkMemoryFormat $format,
  GBytes          $bytes,
  gsize           $stride
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }
