use v6.c;

use Method::Also;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::FrameTimings:ver<4>;

class GDK::FrameTimings {
  has GdkFrameTimings $!gdk-ft is implementor;

  submethod BUILD ( :$gdk-frame-timings ) {
    $!gdk-ft = $gdk-frame-timings if $gdk-frame-timings
  }

  method GDK::Raw::Definitions::GdkFrameTimings
    is also<GdkFrameTimings>
  { $!gdk-ft }

  method new (GdkFrameTimings $gdk-frame-timings, :$ref = True) {
    return Nil unless $gdk-frame-timings;

    my $o = self.bless( :$gdk-frame-timings );
    $o.ref if $ref;
    $o;
  }

  method get_complete
    is also<
      get-complete
      complete
    >
  {
    gdk_frame_timings_get_complete($!gdk-ft);
  }

  method get_frame_counter
    is also<
      get-frame-counter
      frame_counter
      frame-counter
    >
  {
    gdk_frame_timings_get_frame_counter($!gdk-ft);
  }

  method get_frame_time
    is also<
      get-frame-time
      frame_time
      frame-time
    >
  {
    gdk_frame_timings_get_frame_time($!gdk-ft);
  }

  method get_predicted_presentation_time
    is also<
      get-predicted-presentation-time
      predicted_presentation_time
      predicted-presentation-time
    >
  {
    gdk_frame_timings_get_predicted_presentation_time($!gdk-ft);
  }

  method get_presentation_time
    is also<
      get-presentation-time
      presentation_time
      presentation-time
    >
  {
    gdk_frame_timings_get_presentation_time($!gdk-ft);
  }

  method get_refresh_interval
    is also<
      get-refresh-interval
      refresh_interval
      refresh-interval
    >
  {
    gdk_frame_timings_get_refresh_interval($!gdk-ft);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_frame_timings_get_type, $n, $t );
  }

  method ref {
    gdk_frame_timings_ref($!gdk-ft);
    self
  }

  method unref {
    gdk_frame_timings_unref($!gdk-ft);
  }

}
