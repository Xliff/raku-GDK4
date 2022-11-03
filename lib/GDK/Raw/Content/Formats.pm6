use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::Contents::Format:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkcontentformats.h

sub gdk_content_formats_builder_add_formats (
  GdkContentFormatsBuilder $builder,
  GdkContentFormats        $formats
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_add_gtype (
  GdkContentFormatsBuilder $builder,
  GType                    $type
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_add_mime_type (
  GdkContentFormatsBuilder $builder,
  Str                      $mime_type
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_free_to_formats (
  GdkContentFormatsBuilder $builder
)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_new
  returns GdkContentFormatsBuilder
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_ref (GdkContentFormatsBuilder $builder)
  returns GdkContentFormatsBuilder
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_to_formats (GdkContentFormatsBuilder $builder)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_builder_unref (GdkContentFormatsBuilder $builder)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_contain_gtype (
  GdkContentFormats $formats,
  GType             $type
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_contain_mime_type (
  GdkContentFormats $formats,
  Str               $mime_type
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_file_list_get_files (GdkFileList $file_list)
  returns GSList
  is      native(gdk4)
  is      export
{ * }

sub gdk_file_list_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_file_list_new_from_array (
  CArray[GFile] $files,
  gsize         $n_files
)
  returns GdkFileList
  is      native(gdk4)
  is      export
{ * }

sub gdk_file_list_new_from_list (GSList $files)
  returns GdkFileList
  is      native(gdk4)
  is      export
{ * }

sub gdk_intern_mime_type (Str $string)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_get_gtypes (
  GdkContentFormats $formats,
  gsize             $n_gtypes
)
  returns CArray[GType]
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_get_mime_types (
  GdkContentFormats $formats,
  gsize             $n_mime_types
)
  returns CArray[Str]
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_match (
  GdkContentFormats $first,
  GdkContentFormats $second
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_match_gtype (
  GdkContentFormats $first,
  GdkContentFormats $second
)
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_match_mime_type (
  GdkContentFormats $first,
  GdkContentFormats $second
)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_new (
  CArray[Str] $mime_types,
  guint       $n_mime_types
)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_new_for_gtype (GType $type)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_parse (Str $string)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_print (
  GdkContentFormats $formats,
  GString           $string
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_ref (GdkContentFormats $formats)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_to_string (GdkContentFormats $formats)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_union (
  GdkContentFormats $first,
  GdkContentFormats $second
)
  returns GdkContentFormats
  is      native(gdk4)
  is      export
{ * }

sub gdk_content_formats_unref (GdkContentFormats $formats)
  is      native(gdk4)
  is      export
{ * }
