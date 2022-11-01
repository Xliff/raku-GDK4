use v6.c;

use GLib::Raw::Definitions;

use GLib::Roles::Pointers;

unit package GDK::Raw::Definitions:ver<4>;

constant gdk4 is export = 'gtk-4.0';

class GdkAppLaunchContext      is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkClipboard             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDevice                is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDeviceTool            is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkDisplay               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkGLContext             is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkMonitor               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkSurface               is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkTexture               is repr<CPointer> does GLib::Roles::Pointers is export { }

class GdkEvent                 is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentFormats        is repr<CPointer> does GLib::Roles::Pointers is export { }
class GdkContentFormatsBuilder is repr<CPointer> does GLib::Roles::Pointers is export { }
