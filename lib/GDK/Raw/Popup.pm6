use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::Popup:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkpopup.h

sub gdk_popup_get_autohide (GdkPopup $popup)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_get_parent (GdkPopup $popup)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_get_position_x (GdkPopup $popup)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_get_position_y (GdkPopup $popup)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_get_rect_anchor (GdkPopup $popup)
  returns GdkGravity
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_get_surface_anchor (GdkPopup $popup)
  returns GdkGravity
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_present (
  GdkPopup       $popup,
  gint           $width,
  gint           $height,
  GdkPopupLayout $layout
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
