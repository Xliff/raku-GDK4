use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;

unit package GDK::Raw::Structs:ver<4>;

class GdkContentProvider is repr<CStruct> is export {
	HAS GObject $.parent;
}

class gdk_key is repr<CStruct> is export {
	has guint $.keyval;
	has guint $.offset;
}

class GdkKeymapKey is repr<CStruct> is export {
	has guint  $.keycode;
	has gint   $.group  ;
	has gint   $.level  ;
}

class GdkRGBA is repr<CStruct> is export {
	has gfloat $.red   is rw;
	has gfloat $.green is rw;
	has gfloat $.blue  is rw;
	has gfloat $.alpha is rw;
}

class GdkRectangle is repr<CStruct> is export {
	has gint $.x      is rw;
	has gint $.y      is rw;
	has gint $.width  is rw;
	has gint $.height is rw;
}

class GdkSeat is repr<CStruct> is export {
	HAS GObject $.parent;
}
