use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Display:ver<4>;

### /usr/include/gtk-4.0/gdk/gdkdisplay.h

sub gdk_display_beep (GdkDisplay $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_close (GdkDisplay $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_create_gl_context (
  GdkDisplay              $self,
  CArray[Pointer[GError]] $error
)
  returns GdkGLContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_device_is_grabbed (GdkDisplay $display, GdkDevice $device)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_flush (GdkDisplay $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_app_launch_context (GdkDisplay $display)
  returns GdkAppLaunchContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_clipboard (GdkDisplay $display)
  returns GdkClipboard
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_default
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_default_seat (GdkDisplay $display)
  returns GdkSeat
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_monitor_at_surface (
  GdkDisplay $display,
  GdkSurface $surface
)
  returns GdkMonitor
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_monitors (GdkDisplay $self)
  returns GListModel
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_name (GdkDisplay $display)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_primary_clipboard (GdkDisplay $display)
  returns GdkClipboard
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_setting (
  GdkDisplay $display,
  Str        $name,
  GValue     $value
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_startup_notification_id (GdkDisplay $display)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_is_closed (GdkDisplay $display)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_is_composited (GdkDisplay $display)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_is_rgba (GdkDisplay $display)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_list_seats (GdkDisplay $display)
  returns GList
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_map_keycode (
  GdkDisplay                   $display,
  guint                        $keycode,
  CArray[CArray[GdkKeymapKey]] $keys,
  CArray[CArray[guint]]        $keyvals,
  gint                         $n_entries is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_map_keyval (
  GdkDisplay                    $display,
  guint                         $keyval,
  CArray[Pointer[GdkKeymapKey]] $keys,
  gint                          $n_keys   is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_notify_startup_complete (GdkDisplay $display, Str $startup_id)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_open (Str $display_name)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_prepare_gl (
  GdkDisplay              $self,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_put_event (
  GdkDisplay $display,
  GdkEvent   $event
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_supports_input_shapes (GdkDisplay $display)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_sync (GdkDisplay $display)
  is      native(gdk4)
  is      export
{ * }

sub gdk_display_translate_key (
  GdkDisplay      $display,
  guint           $keycode,
  GdkModifierType $state,
  gint            $group,
  guint           $keyval          is rw,
  gint            $effective_group is rw,
  gint            $level           is rw,
  GdkModifierType $consumed        is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }


## /usr/src/gtk4/gdk/x11/gdkx11glcontext.h

sub gdk_x11_display_get_egl_display (GdkDisplay $display)
  returns Pointer
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_egl_version (
  GdkDisplay $display,
  gint       $major is rw,
  gint       $minor is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_x11_display_get_glx_version (
  GdkDisplay $display,
  gint       $major is rw,
  gint       $minor is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
