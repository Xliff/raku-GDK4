use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Content::Formats:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

class GDK::Contents::Formats::Builder { ... }

our subset GdkContentFormatsAncestry is export of Mu
  where GdkContentFormats | GObject;

class GDK::Content::Formats {
  also does GLib::Roles::Object;

  has GdkContentFormats $!gdk-cf is implementor;

  submethod BUILD ( :$gdk-formats ) {
    self.setGdkContentFormats($gdk-formats) if $gdk-formats
  }

  method setGdkContentFormats (GdkContentFormatsAncestry $_) {
    my $to-parent;

    $!gdk-cf = do {
      when GdkContentFormats {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkContentFormats, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkContentFormats
    is also<GdkContentFormats>
  { $!gdk-cf }

  multi method new (GdkContentFormatsAncestry $gdk-formats, :$ref = True) {
    return unless $gdk-formats;

    my $o = self.bless( :$gdk-formats );
    $o.ref if $ref;
    $o;
  }
  multi method new (@mime_types) {
    samewith( ArrayToCArray(Str, @mime_types), @mime_types.elems );
  }
  multi method new (CArray[Str] $mime_types, Int() $n_mime_types) {
    my guint $n = $n_mime_types;

    my $gdk-content-formats = gdk_content_formats_new($mime_types, $n);

    $gdk-content-formats ?? self.bless( :$gdk-content-formats ) !! Nil;
  }

  method new_for_gtype (Int() $type) is also<new-for-gtype> {
    my GType $t = $type;

    my $gdk-content-formats = gdk_content_formats_new_for_gtype($!gdk-cf, $t);

    $gdk-content-formats ?? self.bless( :$gdk-content-formats ) !! Nil;
  }

  method parse (Str() $desc) {
    my $gdk-content-formats = gdk_content_formats_parse($desc);

    $gdk-content-formats ?? self.bless( :$gdk-content-formats ) !! Nil;
  }

  method contain_gtype (Int() $type) is also<contain-gtype> {
    my GType $t = $type;

    so gdk_content_formats_contain_gtype($!gdk-cf, $t);
  }

  method contain_mime_type (Str() $mime_type) is also<contain-mime-type> {
    so gdk_content_formats_contain_mime_type($!gdk-cf, $mime_type);
  }

  proto method get_gtypes (|)
    is also<get-gtypes>
  { *  }

  multi method get_gtypes ( :$carray = False ) {
    samewith($, :$carray)
  }
  multi method get_gtypes ($n_gtypes is rw, :$carray = False) {
    my guint $n = 0;

    my $ta = gdk_content_formats_get_gtypes($!gdk-cf, $n);
    $n_gtypes = $n;
    return $ta if $carray;
    CArrayToArray($ta, $n);
  }

  proto method get_mime_types (|)
    is also<get-mime-types>
  { * }

  multi method get_mime_types ( :$carray = False ) {
    samewith($, :$carray);
  }
  multi method get_mime_types (
     $n_mime_types is rw,
    :$carray              = False
  ) {
    my gsize $n = 0;

    my $sa = gdk_content_formats_get_mime_types($!gdk-cf, $n);
    $n_mime_types = $n;
    return $sa if $carray;
    CArrayToArray($sa, $n);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_content_formats_get_type, $n, $t );
  }

  method match (GdkContentFormats() $second) {
    so gdk_content_formats_match($!gdk-cf, $second);
  }

  method match_gtype (GdkContentFormats() $second) is also<match-gtype> {
    gdk_content_formats_match_gtype($!gdk-cf, $second);
  }

  method match_mime_type (GdkContentFormats() $second)
    is also<match-mime-type>
  {
    gdk_content_formats_match_mime_type($!gdk-cf, $second);
  }

  proto method print (|)
  { * }

  multi method print ( :$gstring = False ) {
    samewith( my $s = GLib::String.new );
    return $s if $gstring;
    $s.Str;
  }
  multi method print (GString() $string) {
    gdk_content_formats_print($!gdk-cf, $string);
  }

  method ref {
    gdk_content_formats_ref($!gdk-cf);
    self
  }

  method to_string
    is also<
      to-string
      Str
    >
  {
    gdk_content_formats_to_string($!gdk-cf);
  }

  method union (GdkContentFormats() $second, :$raw = False) {
    propReturnObject(
      gdk_content_formats_union($!gdk-cf, $second),
      $raw,
      |self.getTypePair
    );
  }

  method unref {
    gdk_content_formats_unref($!gdk-cf);
  }

  method union_serialize_gtypes ( :$raw = False ) {
    propReturnObject(
      gdk_content_formats_union_serialize_gtypes($!gdk-cf),
      $raw,
      |self.getTypePair
    );
  }

  method union_serialize_mime_types ( :$raw = False ) {
    propReturnObject(
      gdk_content_formats_union_serialize_mime_types($!gdk-cf),
      $raw,
      |self.getTypePair
    )
  }

  method union_deserialize_gtypes ( :$raw = False ) {
    propReturnObject(
      gdk_content_formats_union_deserialize_gtypes($!gdk-cf),
      $raw,
      |self.getTypePair
    );
  }

  method union_deserialize_mime_types ( :$raw = False ) {
    propReturnObject(
      gdk_content_formats_union_deserialize_mime_types($!gdk-cf),
      $raw,
      |self.getTypePair
    );
  }

}


our subset GdkContentFormatsBuilderAncestry is export of Mu
  where GdkContentFormatsBuilder | GObject;

class GDK::Contents::Formats::Builder {
  also does GLib::Roles::Object;

  has GdkContentFormatsBuilder $!gdk-cfb is implementor;

  submethod BUILD ( :$gdk-formats-builder ) {
    self.setGdkContentFormatsBuilder($gdk-formats-builder)
      if $gdk-formats-builder
  }

  method setGdkContentFormatsBuilder (GdkContentFormatsBuilderAncestry $_) {
    my $to-parent;

    $!gdk-cfb = do {
      when GdkContentFormatsBuilder {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkContentFormatsBuilder, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkContentFormatsBuilder
    is also<GdkContentFormatsBuilder>
  { $!gdk-cfb }

  multi method new (
    GdkContentFormatsBuilderAncestry  $gdk-formats-builder,
                                     :$ref                  = True
  ) {
    return unless $gdk-formats-builder;

    my $o = self.bless( :$gdk-formats-builder );
    $o.ref if $ref;
    $o;
  }
  multi method new {
    my $gdk-formats-builder = gdk_content_formats_builder_new();

    $gdk-formats-builder ?? self.bless( :$gdk-formats-builder ) !! Nil;
  }

  method add_formats (GdkContentFormats() $formats) is also<add-formats> {
    gdk_content_formats_builder_add_formats($!gdk-cfb, $formats);
  }

  method add_gtype (Int() $type) is also<add-gtype> {
    my GType $t = $type;

    gdk_content_formats_builder_add_gtype($!gdk-cfb, $t);
  }

  method add_mime_type (Str() $mime_type) is also<add-mime-type> {
    gdk_content_formats_builder_add_mime_type($!gdk-cfb, $mime_type);
  }

  method free_to_formats ( :$raw = False ) is also<free-to-formats> {
    propReturnObject(
      gdk_content_formats_builder_free_to_formats($!gdk-cfb),
      $raw,
      |GDK::Content::Formats.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdk_content_formats_builder_get_type,
      $n,
      $t
    );
  }

  method ref {
    gdk_content_formats_builder_ref($!gdk-cfb);
    self
  }

  method to_formats ( :$raw = False ) is also<to-formats> {
    propReturnObject(
      gdk_content_formats_builder_to_formats($!gdk-cfb),
      $raw,
      |GDK::Content::Formats.getTypePair
    );
  }

  method unref {
    gdk_content_formats_builder_unref($!gdk-cfb);
  }

}




  # method gdk_intern_mime_type {
  #   gdk_intern_mime_type($!gdk-cf);
  # }
