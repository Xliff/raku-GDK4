use v6.c;

use Cairo;
use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GDK::Raw::Definitions:ver<4>;

constant gdk4 is export = 'gtk-4';

#constant cairo_content_t is export := Cairo::cairo_content_t;
#constant cairo_region_t  is export := Cairo::cairo_region_t;
constant cairo_surface_t is export := Cairo::cairo_surface_t;

class GdkAppLaunchContext      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkClipboard             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkCairoContext          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkCursor                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDevice                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDeviceTool            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkPixbuf                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFrameClock            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFrameTimings          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDisplay               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkGLContext             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkMonitor               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkSurface               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkTexture               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkVulkanContext         is repr<CPointer> does GLib::Roles::Pointers is export { }

class GdkEvent                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentFormats        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentFormatsBuilder is repr<CPointer> does GLib::Roles::Pointers is export { }
