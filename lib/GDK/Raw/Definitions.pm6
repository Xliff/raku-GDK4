use v6.c;

use Cairo;
use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GDK::Raw::Definitions:ver<4>;

constant gdk4 is export = 'gtk-4';

constant cairo_content_t is export := gpointer; # Cairo::cairo_content_t;
constant cairo_region_t  is export := gpointer; # Cairo::cairo_region_t;
constant cairo_surface_t is export := Cairo::cairo_surface_t;
constant cairo_t         is export := Cairo::cairo_t;
constant Screen          is export := gpointer;
constant XID             is export := gulong;

class GdkAppLaunchContext      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkCairoContext          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkClipboard             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkCursor                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDevice                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDeviceTool            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDisplay               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDisplayManager        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDrag                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDrawContext           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDrop                  is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkEventSequence         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFileList              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFrameClock            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFrameTimings          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkGLContext             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkMonitor               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkSurface               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkToplevelLayout        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkTexture               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkToplevelSize          is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkVulkanContext         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkX11Screen             is repr<CPointer> does GLib::Roles::Pointers is export { }

class GdkContentFormats        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentFormatsBuilder is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentSerializer     is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentDeserializer   is repr<CPointer> does GLib::Roles::Pointers is export { }

class GdkEvent                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkButtonEvent           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkCrossingEvent         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDeleteEvent           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDevicePad             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDndEvent              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDragSurface           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkFocusEvent            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkGrabBrokenEvent       is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkGLTexture             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkKeyEvent              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkMemoryTexture         is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkMotionEvent           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkPadEvent              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkPaintable             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkPopup                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkPopupLayout           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkProximityEvent        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkScrollEvent           is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkSnapshot              is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkTouchEvent            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkTouchpadEvent         is repr<CPointer> does GLib::Roles::Pointers is export { }
