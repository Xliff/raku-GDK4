use v6.c;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions;
use GDK::Raw::Enums;

unit package GDK::Raw::Seat;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkseat.h

sub gdk_seat_get_capabilities (GdkSeat $seat)
  returns GdkSeatCapabilities
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_devices (
  GdkSeat             $seat,
  GdkSeatCapabilities $capabilities
)
  returns GList
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_display (GdkSeat $seat)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_keyboard (GdkSeat $seat)
  returns GdkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_pointer (GdkSeat $seat)
  returns GdkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_tools (GdkSeat $seat)
  returns GList
  is      native(gdk4)
  is      export
{ * }

sub gdk_seat_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
