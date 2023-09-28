use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::TextureDownloader:ver<4>;

use GDK::Texture:ver<4>;

use GLib::Roles::Implementor;

# BOXED

class GDK::Raw::Types:ver<4> {
  has GdkTextureDownloader $!gdk-td is implementor;

  submethod BUILD ( :$gdk-texture-downloader ) {
    $!gdk-td = $gdk-texture-downloader if $gdk-texture-downloader;
  }

  method GDK::Raw::Definitions::GdkTextureDownloader
  { $!gdk-td }

  method new (GdkTexture() $texture) {
    my $gdk-texture-downloader = gdk_texture_downloader_new($texture);

    $gdk-texture-downloader ?? self.bless( :$gdk-texture-downloader ) !! Nil;
  }

  method copy ( :$raw = False ) {
    my $c = gdk_texture_downloader_copy($!gdk-td);

    propReturnObject( $c, $raw, |self.getTypePair );
  }

  proto method download_bytes (|)
  { * }

  multi method download_bytes ( :$raw = False ) {
    samewith($, :all, :$raw);
  }
  multi method download_bytes (
     $out_stride is rw,
    :$all              = False,
    :$raw              = False
  ) {
    my gsize $o = 0;

    my $b = gdk_texture_downloader_download_bytes($!gdk-td, $o);
    propReturnObject($b, $raw, |GLib::Bytes.getTypePair);
    $out_stride = 0;
    $all.not ?? $b !! ($b, $out_stride);
  }

  method download_into (
    CArray[uint8] $data,
    Int()         $stride
  ) {
    my gsize $s = $stride;

    gdk_texture_downloader_download_into($!gdk-td, $data, $stride);
  }

  method free {
    gdk_texture_downloader_free($!gdk-td);
  }

  method get_format ( :$enum = True ) {
    my $f = gdk_texture_downloader_get_format($!gdk-td);
    return $f unless $enum;
    GdkMemoryFormatEnum($f);
  }

  method get_texture ( :$raw = False ) {
    propReturnObject(
      gdk_texture_downloader_get_texture($!gdk-td),
      $raw,
      |GDK::Texture.getTypePair
    );
  }

  method get_type {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdk_texture_downloader_get_type,
      $n,
      $t
    );
  }

  method set_format (Int() $format) {
    my GdkMemoryFormat $f = $format;

    gdk_texture_downloader_set_format($!gdk-td, $f);
  }

  method set_texture (GdkTexture() $texture) {
    gdk_texture_downloader_set_texture($!gdk-td, $texture);
  }

}
