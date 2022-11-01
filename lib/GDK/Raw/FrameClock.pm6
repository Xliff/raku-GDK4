use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;

unit package GDK::Raw::FrameClock:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkframeclock.h

sub gdk_frame_clock_begin_updating (GdkFrameClock $frame_clock)
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_end_updating (GdkFrameClock $frame_clock)
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_current_timings (GdkFrameClock $frame_clock)
  returns GdkFrameTimings
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_fps (GdkFrameClock $frame_clock)
  returns gdouble
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_frame_counter (GdkFrameClock $frame_clock)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_frame_time (GdkFrameClock $frame_clock)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_history_start (GdkFrameClock $frame_clock)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_refresh_info (
  GdkFrameClock $frame_clock,
  gint64        $base_time,
  gint64        $refresh_interval_return  is rw,
  gint64        $presentation_time_return is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_timings (
  GdkFrameClock $frame_clock,
  gint64        $frame_counter
)
  returns GdkFrameTimings
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_clock_request_phase (
  GdkFrameClock      $frame_clock,
  GdkFrameClockPhase $phase
)
  is      native(gdk4)
  is      export
{ * }
