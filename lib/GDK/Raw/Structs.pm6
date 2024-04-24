use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Object;
use GDK::Raw::Enums:ver<4>;

use GLib::Roles::Pointers;

unit package GDK::Raw::Structs:ver<4>;

class GdkContentProvider is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $.parent;
}

class gdk_key is repr<CStruct> does GLib::Roles::Pointers is export {
	has guint $.keyval;
	has guint $.offset;
}

class GdkKeymapKey is repr<CStruct> does GLib::Roles::Pointers is export {
	has guint  $.keycode;
	has gint   $.group  ;
	has gint   $.level  ;
}

class GdkRGBA is repr<CStruct> does GLib::Roles::Pointers is export {
	has gfloat $.red   is rw;
	has gfloat $.green is rw;
	has gfloat $.blue  is rw;
	has gfloat $.alpha is rw;
}

class GdkRectangle is repr<CStruct> does GLib::Roles::Pointers is export {
	has gint $.x      is rw is built;
	has gint $.y      is rw is built;
	has gint $.width  is rw is built;
	has gint $.height is rw is built;

	method size {
		($.width, $.height);
	}

	method new ($x, $y, $width, $height) {
		self.bless( :$x, :$y, :$width, :$height );
  }
}

class GdkSeat is repr<CStruct> does GLib::Roles::Pointers is export {
	HAS GObject $.parent;
}

class GdkTimeCoord is repr<CStruct> does GLib::Roles::Pointers is export {
	has guint        $.time;
	has GdkAxisFlags $.flags;
	HAS gdouble      @.gdouble[GDK_AXIS_LAST] is CArray;
}
