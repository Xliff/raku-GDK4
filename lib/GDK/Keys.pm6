use v6.c;

use Method::Also;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Keys:ver<4>;

use GLib::Roles::StaticClass;

class GDK::Keys:ver<4> {
  also does GLib::Roles::StaticClass;

  proto method convert_case (|)
    is also<convert-case>
  { * }

  multi method convert_case (Int() $symbol) {
    samewith($, $);
  }
  multi method convert_case (
    Int() $symbol,
          $lower is rw,
          $upper is rw
  ) {
    my guint  $s      = $symbol;
    my guint ($l, $u) = 0 xx 2;

    gdk_keyval_convert_case($s, $l, $u);
    ($lower, $upper) = ($l, $u);
  }

  method from_name (Str() $keyval_name) is also<from-name> {
    gdk_keyval_from_name($keyval_name);
  }

  method is_lower (Int() $keyval) is also<is-lower> {
    my guint $k = $keyval;

    gdk_keyval_is_lower($k);
  }

  method is_upper (Int() $keyval) is also<is-upper> {
    my guint $k = $keyval;

    gdk_keyval_is_upper($k);
  }

  method name (Int() $keyval) {
    my guint $k = $keyval;

    gdk_keyval_name($k);
  }

  method to_lower (Int() $keyval) is also<to-lower> {
    my guint $k = $keyval;

    gdk_keyval_to_lower($k);
  }

  method to_unicode (Int() $keyval) is also<to-unicode> {
    my guint $k = $keyval;

    gdk_keyval_to_unicode($k);
  }

  method to_upper (Int() $keyval) is also<to-upper> {
    my guint $k = $keyval;

    gdk_keyval_to_upper($k);
  }

  method unicode_to_keyval (Int() $wc) is also<unicode-to-keyval> {
    my guint $w = $wc;

    gdk_unicode_to_keyval($w);
  }

}

our constant GK is export := GDK::Keys;
