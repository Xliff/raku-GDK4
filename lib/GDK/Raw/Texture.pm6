use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Pixbuf::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Texture:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdktexture.h

sub gdk_texture_download (
  GdkTexture $texture,
  Str        $data,
  gsize      $stride
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_error_quark
  returns GQuark
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_get_height (GdkTexture $texture)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_get_width (GdkTexture $texture)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_new_for_pixbuf (GdkPixbuf $pixbuf)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_new_from_bytes (
  GBytes                  $bytes,
  CArray[Pointer[GError]] $error
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_new_from_file (
  GFile                   $file,
  CArray[Pointer[GError]] $error
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_new_from_filename (
  Str                     $path,
  CArray[Pointer[GError]] $error
)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_new_from_resource (Str $resource_path)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_save_to_png (
  GdkTexture $texture,
  Str        $filename
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_save_to_png_bytes (GdkTexture $texture)
  returns GBytes
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_save_to_tiff (
  GdkTexture $texture,
  Str        $filename
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_save_to_tiff_bytes (GdkTexture $texture)
  returns GBytes
  is      native(gdk4)
  is      export
{ * }
