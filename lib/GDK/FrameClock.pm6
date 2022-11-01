use v6.c;

use Method::Also;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::FrameClock:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkFrameClockAncestry is export of Mu
  where GdkFrameClock | GObject;

class GDK::FrameClock:ver<4> {
  also does GLib::Roles::Object;

  has GdkFrameClock $!gdk-fc is implementor;

  submethod BUILD ( :$gdk-frame-clock ) {
    self.setGdkFrameClock($gdk-frame-clock) if $gdk-frame-clock
  }

  method setGdkFrameClock (GdkFrameClockAncestry $_) {
    my $to-parent;

    $!gdk-fc = do {
      when GdkFrameClock {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkFrameClock, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkFrameClock
    is also<GdkFrameClock>
  { $!gdk-fc }

  multi method new (GdkFrameClockAncestry $gdk-frame-clock, :$ref = True) {
    return unless $gdk-frame-clock;

    my $o = self.bless( :$gdk-frame-clock );
    $o.ref if $ref;
    $o;
  }

  method begin_updating is also<begin-updating> {
    gdk_frame_clock_begin_updating($!gdk-fc);
  }

  method end_updating is also<end-updating> {
    gdk_frame_clock_end_updating($!gdk-fc);
  }

  method get_current_timings is also<get-current-timings> {
    gdk_frame_clock_get_current_timings($!gdk-fc);
  }

  method get_fps is also<get-fps> {
    gdk_frame_clock_get_fps($!gdk-fc);
  }

  method get_frame_counter is also<get-frame-counter> {
    gdk_frame_clock_get_frame_counter($!gdk-fc);
  }

  method get_frame_time is also<get-frame-time> {
    gdk_frame_clock_get_frame_time($!gdk-fc);
  }

  method get_history_start is also<get-history-start> {
    gdk_frame_clock_get_history_start($!gdk-fc);
  }

  proto method get_refresh_info (|)
    is also<get-refresh-info>
  { * }

  multi method get_refresh_info (Int() $base_time) {
    samewith($base_time, $, $);
  }
  multi method get_refresh_info (
    Int() $base_time,
          $refresh_interval_return  is rw,
          $presentation_time_return is rw
  ) {
    my gint64  $b      = $base_time;
    my gint64 ($r, $p) = 0e0 xx 2;

    gdk_frame_clock_get_refresh_info($!gdk-fc, $b, $r, $p);
    ($refresh_interval_return, $presentation_time_return) = ($r, $p);
  }

  method get_timings (Int() $frame_counter, :$raw = False)
    is also<get-timings>
  {
    my gint64 $f = $frame_counter;

    propReturnObject(
      gdk_frame_clock_get_timings($!gdk-fc, $frame_counter),
      $raw,
      |::('GDK::FrameTimings').getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_frame_clock_get_type, $n, $t );
  }

  proto method request_phase (|)
    is also<request-phase>
  { * }

  multi method request_phase ( :$enum = True ) {
    samewith($, :$enum);
  }
  multi method request_phase ($phase is rw, :$enum = True) {
    my GdkFrameClockPhase $p = 0;

    gdk_frame_clock_request_phase($!gdk-fc, $p);
    $p = GdkFrameClockPhaseEnum($p) if $enum;
    $phase = $p;
  }

}
