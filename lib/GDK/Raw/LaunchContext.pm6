use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GIO::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::LaunchContext:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkapplaunchcontext.h

sub gdk_app_launch_context_get_display (GdkAppLaunchContext $context)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_app_launch_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_app_launch_context_set_desktop (
  GdkAppLaunchContext $context,
  gint                $desktop
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_app_launch_context_set_icon (
  GdkAppLaunchContext $context,
  GIcon               $icon
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_app_launch_context_set_icon_name (
  GdkAppLaunchContext $context,
  Str                 $icon_name
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_app_launch_context_set_timestamp (
  GdkAppLaunchContext $context,
  guint32             $timestamp
)
  is      native(gdk4)
  is      export
{ * }
