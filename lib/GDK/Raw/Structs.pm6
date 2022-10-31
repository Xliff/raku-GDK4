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
	has int   $!group  ;
	has int   $!level  ;
}

class GdkRGBA is repr<CStruct> is export {
	has float $!red  ;
	has float $!green;
	has float $!blue ;
	has float $!alpha;
}

class GdkRectangle is repr<CStruct> is export {
	has int $!x     ;
	has int $!y     ;
	has int $!width ;
	has int $!height;
}

class GdkSeat is repr<CStruct> is export {
	HAS GObject $.parent;
}
