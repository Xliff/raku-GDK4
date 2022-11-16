use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::PopupLayout:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkpopuplayout.h

sub gdk_popup_layout_copy (GdkPopupLayout $layout)
  returns GdkPopupLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_equal (GdkPopupLayout $layout, GdkPopupLayout $other)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_anchor_hints (GdkPopupLayout $layout)
  returns GdkAnchorHints
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_anchor_rect (GdkPopupLayout $layout)
  returns GdkRectangle
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_offset (
  GdkPopupLayout $layout,
  gint           $dx      is rw,
  gint           $dy      is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_rect_anchor (GdkPopupLayout $layout)
  returns GdkGravity
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_shadow_width (
  GdkPopupLayout $layout,
  gint           $left    is rw,
  gint           $right   is rw,
  gint           $top     is rw,
  gint           $bottom  is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_surface_anchor (GdkPopupLayout $layout)
  returns GdkGravity
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_new (
  GdkRectangle $anchor_rect,
  GdkGravity   $rect_anchor,
  GdkGravity   $surface_anchor
)
  returns GdkPopupLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_ref (GdkPopupLayout $layout)
  returns GdkPopupLayout
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_anchor_hints (
  GdkPopupLayout $layout,
  GdkAnchorHints $anchor_hints
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_anchor_rect (
  GdkPopupLayout $layout,
  GdkRectangle   $anchor_rect
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_offset (
  GdkPopupLayout $layout,
  gint           $dx,
  gint           $dy
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_rect_anchor (
  GdkPopupLayout $layout,
  GdkGravity     $anchor
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_shadow_width (
  GdkPopupLayout $layout,
  gint           $left,
  gint           $right,
  gint           $top,
  gint           $bottom
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_set_surface_anchor (
  GdkPopupLayout $layout,
  GdkGravity     $anchor
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_popup_layout_unref (GdkPopupLayout $layout)
  is      native(gdk4)
  is      export
{ * }
