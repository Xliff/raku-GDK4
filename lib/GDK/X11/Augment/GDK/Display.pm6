use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::X11::Selection:ver<4>;

use GDK::Display:ver<4>;

use MONKEY-TYPING;

augment class GDK::Display {

  proto method string_to_compound_text (|)
  { * }

  multi method string_to_compound_text (Str() $str) {
    samewith(
      $str,
      newCArray(Str),
      newCArray(Str),
    );
  }
  multi method string_to_compound_text (
    Str()       $str,
    CArray[Str] $encoding,
    CArray[Str] $ctext,
  ) {
    return-with-all(
      samewith($str, $encoding, $, $ctext, $, :all)
    );
  }
  multi method string_to_compound_text (
    Str          $str,
    CArray[Str]  $encoding,
                 $format    is rw,
    CArray[Str]  $ctext,
                 $length    is rw,
                :$all              = False
  ) {
    my gint ($f, $l) = 0 xx 2;

    my $rv = gdk_x11_display_string_to_compound_text(
      self.GdkDisplay,
      $str,
      $encoding,
      $f,
      $ctext,
      $l
    );
    ($format, $length) = ($f, $l);
    my $return-ctext = CArrayToArray($ctext);
    self.free_text_list($ctext);
    $all.not ?? $rv
             !! ( ppr($encoding), $format, $return-ctext, $length );

  }

  proto method text_property_to_text_list (|)
  { * }

  multi method text_property_to_text_list (
    Str() $encoding,
    Int() $format,
    Str() $text,
    Int() $length
  ) {
    samewith(
      $encoding,
      $format,
      $text,
      $length,
      newCArray( CArray[Str] )
    );
  }
  multi method text_property_to_text_list (
    Str()               $encoding,
    Int()               $format,
    Str()               $text,
    Int()               $length,
    CArray[CArray[Str]] $list
  ) {
    my gint ($f, $l) = ($format, $length);

    my $li = gdk_x11_display_text_property_to_text_list(
      self.GdkDisplay,
      $encoding,
      $f,
      $text,
      $l,
      $list
    );
    my $r-l = CArrayToArray($list[0], $li);
    self.free_text_list($list[0]);
    $r-l;
  }

  proto method utf8_to_compound_text (|)
  { * }

  multi method utf8_to_compound_text (Str() $str) {
    samewith(
      $str,
      newCArray(Str),
      newCArray(Str)
    )
  }
  multi method utf8_to_compound_text (
    Str()       $str,
    CArray[Str] $encoding,
    CArray[Str] $ctext
  ) {
    return-with-all(
      samewith($str, $encoding, $ctext, :all)
    );
  }
  multi method utf8_to_compound_text (
    Str()        $str,
    CArray[Str]  $encoding,
                 $format    is rw,
    CArray[Str]  $ctext,
                 $length    is rw,
                :$all              = False
  ) {
    my gint ($f, $l) = ($format, $length);

    my $rv = gdk_x11_display_utf8_to_compound_text(
      self.GdkDisplay,
      $str,
      $encoding,
      $f,
      $ctext,
      $l
    );
    ($format, $length) = ($f, $l);
    my $return-ctext = $ctext[0];
    # cw: YYY - Potential SEGV! -
    self.free_compound_text($ctext[0]);
    $all.not ?? $rv
             !! ( ppr($encoding), $format, $return-ctext, $length );
  }

  # cw: Is there a C-Str type somewhere so we do not confuse this with
  #     a P6Opaque Str?
  method free_compound_text ($text) is static {
    gdk_x11_free_compound_text( cast(gpointer, $text) );
  }

  method free_text_list (CArray[Str] $list) is static {
    gdk_x11_free_text_list($list);
  }

}
