use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdktoplevel.h

sub gdk_toplevel_begin_move (
  GdkToplevel $toplevel,
  GdkDevice   $device,
  gint        $button,
  gdouble     $x,
  gdouble     $y,
  guint32     $timestamp
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_begin_resize (
  GdkToplevel    $toplevel,
  GdkSurfaceEdge $edge,
  GdkDevice      $device,
  gint           $button,
  gdouble        $x,
  gdouble        $y,
  guint32        $timestamp
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_focus (
  GdkToplevel $toplevel,
  guint32     $timestamp
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_get_state (GdkToplevel $toplevel)
  returns GdkToplevelState
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_inhibit_system_shortcuts (
  GdkToplevel $toplevel,
  GdkEvent    $event
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_lower (GdkToplevel $toplevel)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_minimize (GdkToplevel $toplevel)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_present (
  GdkToplevel       $toplevel,
  GdkToplevelLayout $layout
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_restore_system_shortcuts (GdkToplevel $toplevel)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_decorated (
  GdkToplevel $toplevel,
  gboolean    $decorated
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_deletable (
  GdkToplevel $toplevel,
  gboolean    $deletable
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_icon_list (
  GdkToplevel $toplevel,
  GList       $surfaces
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_modal (
  GdkToplevel $toplevel,
  gboolean    $modal
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_startup_id (
  GdkToplevel $toplevel,
  Str         $startup_id
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_title (
  GdkToplevel $toplevel,
  Str         $title
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_set_transient_for (
  GdkToplevel $toplevel,
  GdkSurface  $parent
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_show_window_menu (
  GdkToplevel $toplevel,
  GdkEvent    $event
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_supports_edge_constraints (GdkToplevel $toplevel)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_toplevel_titlebar_gesture (
  GdkToplevel        $toplevel,
  GdkTitlebarGesture $gesture
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
