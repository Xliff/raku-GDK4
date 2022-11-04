use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Raw::Enums;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::GLContext:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkglcontext.h

sub gdk_gl_context_clear_current
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_error_quark
  returns GQuark
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_allowed_apis (GdkGLContext $self)
  returns GdkGLAPI
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_api (GdkGLContext $self)
  returns GdkGLAPI
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_current
  returns GdkGLContext
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_debug_enabled (GdkGLContext $context)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_display (GdkGLContext $context)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_forward_compatible (GdkGLContext $context)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_required_version (
  GdkGLContext $context,
  gint         $major is rw,
  gint         $minor is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_surface (GdkGLContext $context)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_use_es (GdkGLContext $context)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_get_version (
  GdkGLContext $context,
  gint         $major is rw,
  gint         $minor is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_is_legacy (GdkGLContext $context)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_is_shared (
  GdkGLContext $self,
  GdkGLContext $other
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_make_current (GdkGLContext $context)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_realize (
  GdkGLContext            $context,
  CArray[Pointer[GError]] $error
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_set_allowed_apis (
  GdkGLContext $self,
  GdkGLAPI     $apis
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_set_debug_enabled (
  GdkGLContext $context,
  gboolean     $enabled
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_set_forward_compatible (
  GdkGLContext $context,
  gboolean     $compatible
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_gl_context_set_required_version (
  GdkGLContext $context,
  gint         $major,
  gint         $minor
)
  is      native(gdk4)
  is      export
{ * }
