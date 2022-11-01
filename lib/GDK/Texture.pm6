use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Texture:ver<4>;

use GLib::Bytes;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkTextureAncestry is export of Mu
  where GdkTexture | GObject;

class GDK::Texture:ver<4> {
  also does GLib::Roles::Object;

  has GdkTexture $!gdk-t is implementor;

  submethod BUILD ( :$gdk-texture ) {
    self.setGdkTexture($gdk-texture) if $gdk-texture
  }

  method setGdkTexture (GdkTextureAncestry $_) {
    my $to-parent;

    $!gdk-t = do {
      when GdkTexture {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkTexture, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkTexture
    is also<GdkTexture>
  { $!gdk-t }

  multi method new (GdkTextureAncestry $gdk-texture, :$ref = True) {
    return unless $gdk-texture;

    my $o = self.bless( :$gdk-texture );
    $o.ref if $ref;
    $o;
  }

  method new_for_pixbuf (GdkPixbuf() $pixbuf) is also<new-for-pixbuf> {
    my $gdk-texture = gdk_texture_new_for_pixbuf($!gdk-t, $pixbuf);

    $gdk-texture ?? self.bless( :$gdk-texture ) !! Nil
  }

  method new_from_bytes (
    GBytes()                $bytes,
    CArray[Pointer[GError]] $error  = gerror
  )
    is also<new-from-bytes>
  {
    clear_error;
    my $gdk-texture = gdk_texture_new_from_bytes($bytes, $error);
    set_error($error);

    $gdk-texture ?? self.bless( :$gdk-texture ) !! Nil
  }

  method new_from_file (
    GFile()                 $file,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-file>
  {
    clear_error;
    my $gdk-texture = gdk_texture_new_from_file($file, $error);
    set_error($error);

    $gdk-texture ?? self.bless( :$gdk-texture ) !! Nil
  }

  method new_from_filename (
    Str()                   $path,
    CArray[Pointer[GError]] $error = gerror
  )
    is also<new-from-filename>
  {
    clear_error;
    my $gdk-texture = gdk_texture_new_from_filename($path, $error);
    set_error($error);

    $gdk-texture ?? self.bless( :$gdk-texture ) !! Nil
  }

  method new_from_resource (Str() $resource_path) is also<new-from-resource> {
    my $gdk-texture = gdk_texture_new_from_resource($resource_path);

    $gdk-texture ?? self.bless( :$gdk-texture ) !! Nil
  }

  # Type: int
  method width is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('width', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('width', $gv);
      }
    );
  }

  # Type: int
  method height is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_INT );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('height', $gv);
        $gv.int;
      },
      STORE => -> $, Int() $val is copy {
        $gv.int = $val;
        self.prop_set('height', $gv);
      }
    );
  }

  method download (Str $data, Int() $stride) {
    my gsize $s = $stride;

    gdk_texture_download($!gdk-t, $data, $stride);
  }

  method error_quark is static is also<error-quark> {
    gdk_texture_error_quark();
  }

  method get_height is also<get-height> {
    gdk_texture_get_height($!gdk-t);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_texture_get_type, $n, $t );
  }

  method get_width is also<get-width> {
    gdk_texture_get_width($!gdk-t);
  }

  method save_to_png (Str() $filename) is also<save-to-png> {
    gdk_texture_save_to_png($!gdk-t, $filename);
  }

  method save_to_png_bytes ( :$raw = False) is also<save-to-png-bytes> {
    propReturnObject(
      gdk_texture_save_to_png_bytes($!gdk-t),
      $raw,
      |GLib::Bytes.getTypePair
    );
  }

  method save_to_tiff (Str() $filename) is also<save-to-tiff> {
    gdk_texture_save_to_tiff($!gdk-t, $filename);
  }

  method save_to_tiff_bytes ( :$raw = False ) is also<save-to-tiff-bytes> {
    propReturnObject(
      gdk_texture_save_to_tiff_bytes($!gdk-t),
      $raw,
      |GLib::Bytes.getTypePair
    );
  }

}
