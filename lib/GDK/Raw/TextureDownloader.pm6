use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::TextureDownloader:ver<4>;

### /usr/src/gtk4/gdk/gdktexturedownloader.h

sub gdk_texture_downloader_copy (GdkTextureDownloader $self)
  returns GdkTextureDownloader
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_download_bytes (
  GdkTextureDownloader $self,
  gsize                $out_stride is rw
)
  returns GBytes
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_download_into (
  GdkTextureDownloader $self,
  CArray[uint8]        $data,
  gsize                $stride
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_free (GdkTextureDownloader $self)
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_get_format (GdkTextureDownloader $self)
  returns GdkMemoryFormat
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_get_texture (GdkTextureDownloader $self)
  returns GdkTexture
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_new (GdkTexture $texture)
  returns GdkTextureDownloader
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_set_format (
  GdkTextureDownloader $self,
  GdkMemoryFormat      $format
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_texture_downloader_set_texture (
  GdkTextureDownloader $self,
  GdkTexture           $texture
)
  is      native(gdk4)
  is      export
{ * }
