use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;

unit package GDK::Raw::Structs:ver<4>;

class GdkContentProvider is repr<CStruct> is export {
	HAS GObject $.parent;
}

class GdkKeymapKey is repr<CStruct> is export {
	has guint $!keycode;
	has gint   $!group  ;
	has gint   $!level  ;
}

class GdkRGBA is repr<CStruct> is export {
	has gfloat $!red  ;
	has gfloat $!green;
	has gfloat $!blue ;
	has gfloat $!alpha;
}

class GdkRectangle is repr<CStruct> is export {
	has gint $!x     ;
	has gint $!y     ;
	has gint $!width ;
	has gint $!height;
}

class GdkSeat is repr<CStruct> is export {
	HAS GObject $.parent;
}
