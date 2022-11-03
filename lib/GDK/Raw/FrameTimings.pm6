use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Enums;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::FrameTimings:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkframetimings.h

sub gdk_frame_timings_get_complete (GdkFrameTimings $timings)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_frame_counter (GdkFrameTimings $timings)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_frame_time (GdkFrameTimings $timings)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_predicted_presentation_time (GdkFrameTimings $timings)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_presentation_time (GdkFrameTimings $timings)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_refresh_interval (GdkFrameTimings $timings)
  returns gint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_ref (GdkFrameTimings $timings)
  returns GdkFrameTimings
  is      native(gdk4)
  is      export
{ * }

sub gdk_frame_timings_unref (GdkFrameTimings $timings)
  is      native(gdk4)
  is      export
{ * }
