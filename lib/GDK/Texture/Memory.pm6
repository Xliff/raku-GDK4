use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GDK::Texture;

class GDK::Texture::Memory is GDK::Texture {
  has GdkMemoryTexture $!gdk-mt is implementor;

  our subset GBytesCompatible is export of Mu
    where Blob | CArray[uint8];

  multi method new (
    Int()   $width,
    Int()   $height,
    Str     $data,
    Int()   $stride,
    Int()  :$format   = GDK_MEMORY_DEFAULT,
           :$encoding = 'utf8'
  ) {
    samewith(
       $width,
       $height,
       $data.encode($encoding),
       $stride,
      :$format
    );
  }
  multi method new (
    Int()             $width,
    Int()             $height,
    GBytesCompatible  $bytes,
    Int()             $stride,
    Int()            :$format = GDK_MEMORY_DEFAULT
  ) {
    samewith(
      $width,
      $height,
      $format,
      GLib::Bytes.new($bytes, $height * $stride),
      $stride
    );
  }
  multi method new (
    Int()    $width,
    Int()    $height,
             $format  where *.^can('Int'),
    GBytes() $bytes,
    Int()    $stride
  ) {
    my gint            ($w, $h) = ($width, $height);
    my GdkMemoryFormat  $f      =  $format.Int;
    my gsize            $s      =  $stride;

    my $gdk-memory-texture = gdk_memory_texture_new($w, $h, $f, $bytes, $s);

    $gdk-memory-texture ?? self.bless( :$gdk-memory-texture ) !! Nil;
  }

  method get_type {
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
