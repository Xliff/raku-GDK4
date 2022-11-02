use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Events:ver<4>;

use GDK::Device:ver<4>;
use GDK::Device::Tool:ver<4>;
use GDK::Drop:ver<4>;
use GDK::Seat:ver<4>;
use GDK::Surface:ver<4>;

class GDK::Event:ver<4> {
  has GdkEvent $!gdk-e is implementor;

  submethod BUILD ( :$gdk-event is copy ) {
    if $gdk-event {
      $gdk-event = cast(GdkEvent, $gdk-event) unless $gdk-event ~~ GdkEvent;
      $!gdk-e = $gdk-event
    }
  }

  method new (GdkEvent $e) {
    $e ?? self.bless( gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkEvent
    is also<GdkEvent>
  { $!gdk-e }

  proto method get_angle (|)
    is also<get-angle>
  { * }

  multi method get_angle (GdkEvent() $event2) {
    return-with-all(
      samewith($event2, $, :all);
    )
  }
  multi method get_angle (
    GdkEvent()  $event2,
                $angle   is rw,
               :$all            = False
  ) {
    my gdouble $a = 0e0;

    my $rv = gdk_events_get_angle(self.GdkEvent, $event2, $a);
    $angle = $a;
    $all.not ?? $rv !! ($rv, $angle)
  }

  proto method get_center (|)
    is also<get-center>
  { * }

  multi method get_center (GdkEvent() $event2) {
    return-with-all(
      samewith($event2, $, $, :all)
    )
  }
  multi method get_center (
    GdkEvent()  $event2,
                $x       is rw,
                $y       is rw,
               :$all            = False
  ) {
    my gdouble ($cx, $cy) = 0e0 xx 2;

    my $rv = gdk_events_get_center(self.GdkEvent, $event2, $cx, $cy);
    ($x, $y) = ($cx, $cy);
    $all.not ?? $rv !! ( $rv, $x, $y);
  }

  proto method get_distance (|)
    is also<get-distance>
  { * }

  multi method get_distance (GdkEvent() $event2) {
    return-with-all(
      samewith($event2, $)
    );
  }
  multi method get_distance (
    GdkEvent()  $event2,
                $distance is rw,
               :$all            = False
  ) {
    my gdouble $d = 0e0;

    my $rv = gdk_events_get_distance(self.GdkEvent, $event2, $d);
    $distance = $d;
    $all.not ?? $rv !! ($rv, $distance);
  }

  proto method get_axes (|)
    is also<get-axes>
  { * }

  multi method get_axes ( :$carray = False ) is also<axes> {
    return-with-all(
      samewith( newCArray( CArray[gdouble] ), $, :all, :$carray )
    );
  }
  multi method get_axes (
    CArray[CArray[gdouble]]  $axes   is copy,
                             $n_axes is rw,
                            :$all             = False,
                            :$carray          = True
  ) {
    my guint $n = 0;

    my $rv = gdk_event_get_axes(self.GdkEvent, $axes, $n);
    $n_axes = $n;
    if $rv {
      $axes = ArrayToCArray($axes, $n_axes) unless $carray;
    }
    $all.not ?? $rv !! ($axes, $n_axes);
  }

  proto method get_axis (|)
    is also<get-axis>
  { * }

  multi method get_axis is also<axis> {
    samewith($, $);
  }
  multi method get_axis ($axis_use is rw, $value is rw) {
    my GdkAxisUse $a = 0;
    my gdouble    $v = 0e0;

    gdk_event_get_axis(self.GdkEvent, $a, $v);
    ($axis_use, $value) = ($a, $v);
  }

  method get_device ( :$raw = False )
    is also<
      get-device
      device
    >
  {
    propReturnObject(
      gdk_event_get_device(self.GdkEvent),
      $raw,
      |GDK::Device.getTypePair
    );
  }

  method get_device_tool ( :$raw = False )
    is also<
      get-device-tool
      device_tool
      device-tool
    >
  {
    propReturnObject(
      gdk_event_get_device_tool(self.GdkEvent),
      $raw,
      |GDK::Device::Tool.getTypePair
    );
  }

  method get_display ( :$raw = False )
    is also<
      get-display
      display
    >
  {
    propReturnObject(
      gdk_event_get_display(self.GdkEvent),
      $raw,
      |GDK::Device.getTypePair
    );
  }

  method get_event_sequence
    is also<
      get-event-sequence
      event_sequence
      event-sequence
    >
  {
    gdk_event_get_event_sequence(self.GdkEvent);
  }

  proto method get_event_type (|)
    is also<get-event-type>
  { * }

  multi method get_event_type ( :$enum = True )
    is also<
      event_type
      event-type
    >
  {
    ::?CLASS.get_event_type($!gdk-e);
  }
  multi method get_event_type (GDK::Event:U: GdkEvent $e, :$enum = True) {
    my $et = gdk_event_get_event_type($e);
    return $et unless $enum;
    GdkEventType($et);
  }

  proto method get_history (|)
    is also<get-history>
  { * }

  multi method get_history ( :$carray = False ) is also<history> {
    samewith($, :$carray)
  }
  multi method get_history ($out_n_coords is rw, :$carray = False) {
    my guint $n = 0;

    my $h = gdk_event_get_history(self.GdkEvent, $n);
    $out_n_coords = $n;
    $carray ?? $h !! CArrayToArray($h, $n);
  }

  method get_modifier_state ( :$enum = True )
    is also<
      get-modifier-state
      modifier_state
      modifier-state
    >
  {
    my $v = gdk_event_get_modifier_state(self.GdkEvent);
    return $v unless $enum;
    GdkModifierTypeEnum( $v );
  }

  method get_pointer_emulated
    is also<
      get-pointer-emulated
      pointer_emulated
      pointer-emulated
    >
  {
    so gdk_event_get_pointer_emulated(self.GdkEvent);
  }

  proto method get_position (|)
    is also<get-position>
  { * }

  multi method get_position is also<position> {
    samewith($, $);
  }
  multi method get_position ($x is rw, $y is rw) {
    my gdouble ($xx, $yy) = 0e0;

    gdk_event_get_position(self.GdkEvent, $xx, $yy);
    ($x, $y) = ($xx, $yy);
  }

  method get_seat ( :$raw = False )
    is also<
      get-seat
      seat
    >
  {
    propReturnObject(
      gdk_event_get_seat(self.GdkEvent),
      $raw,
      |GDK::Seat.getTypePair
    );
  }

  method get_surface ( :$raw = False )
    is also<
      get-surface
      surface
    >
  {
    propReturnObject(
      gdk_event_get_surface(self.GdkEvent),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_time
    is also<
      get-time
      time
    >
  {
    gdk_event_get_time(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_event_get_type, $n, $t );
  }

  method ref {
    gdk_event_ref(self.GdkEvent);
    self;
  }

  method triggers_context_menu is also<triggers-context-menu> {
    so gdk_event_triggers_context_menu(self.GdkEvent);
  }

  method unref {
    gdk_event_unref(self.GdkEvent);
  }
}


class GDK::Event::Button:ver<4> is GDK::Event {
  has GdkButtonEvent $!gdk-e-b;

  submethod BUILD ( :$gdk-button-event ) {
    $!gdk-e-b = $gdk-button-event
  }

  method new (GdkButtonEvent $e) {
    $e ?? self.bless( gdk-button-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkButtonEvent
    is also<GdkButtonEvent>
  { $!gdk-e-b }

  method get_button
    is also<
      get-button
      button
    >
  {
    gdk_button_event_get_button(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_button_event_get_type, $n, $t );
  }
}

class GDK::Event::Crossing:ver<4> is GDK::Event {
  has GdkCrossingEvent $!gdk-e-c;

  submethod BUILD ( :$gdk-crossing-event ) {
    $!gdk-e-c = $gdk-crossing-event
  }

  method new (GdkCrossingEvent $e) {
    $e ?? self.bless( gdk-crossing-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkCrossingEvent
    is also<GdkCrossingEvent>
  { $!gdk-e-c }

  method get_detail
    is also<
      get-detail
      detail
    >
  {
    gdk_crossing_event_get_detail(self.GdkEvent);
  }

  method get_focus
    is also<
      get-focus
      focus
    >
  {
    gdk_crossing_event_get_focus(self.GdkEvent);
  }

  method get_mode
    is also<
      get-mode
      mode
    >
  {
    gdk_crossing_event_get_mode(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_crossing_event_get_type, $n, $t );
  }
}

class GDK::Event::Delete:ver<4> is GDK::Event {
  has GdkDeleteEvent $!gdk-e-d;

  submethod BUILD ( :$gdk-delete-event ) {
    $!gdk-e-d = $gdk-delete-event
  }

  method new (GdkDeleteEvent $e) {
    $e ?? self.bless( gdk-delete-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkDeleteEvent
    is also<GdkDeleteEvent>
  { $!gdk-e-d }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_delete_event_get_type, $n, $t );
  }
}

class GDK::Events::DnD:ver<4> is GDK::Event {
  has GdkDndEvent $!gdk-e-dnd;

  submethod BUILD ( :$gdk-dnd-event ) {
    $!gdk-e-dnd = $gdk-dnd-event
  }

  method new (GdkDndEvent $e) {
    $e ?? self.bless( gdk-dnd-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkDndEvent
    is also<GdkDndEvent>
  { $!gdk-e-dnd }

  method get_drop ( :$raw = False )
    is also<
      get-drop
      drop
    >
  {
    propReturnObject(
      gdk_dnd_event_get_drop(self.GdkEvent),
      $raw,
      |GDK::Drop.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_dnd_event_get_type, $n, $t );
  }
}

class GDK::Event::Focus:ver<4> is GDK::Event {
  has GdkFocusEvent $!gdk-e-f;

  submethod BUILD ( :$gdk-focus-event ) {
    $!gdk-e-f = $gdk-focus-event
  }

  method new (GdkFocusEvent $e) {
    $e ?? self.bless( gdk-focus-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkFocusEvent
    is also<GdkFocusEvent>
  { $!gdk-e-f }

  method get_in
    is also<
      get-in
      in
    >
  {
    gdk_focus_event_get_in(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_focus_event_get_type, $n, $t );
  }
}


class GDK::Event::GrabBroken:ver<4> is GDK::Event {
  has GdkGrabBrokenEvent $!gdk-e-gb;

  submethod BUILD ( :$gdk-grab-event ) {
    $!gdk-e-gb = $gdk-grab-event
  }

  method new (GdkGrabBrokenEvent $e) {
    $e ?? self.bless( gdk-grab-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkGrabBrokenEvent
    is also<GdkGrabBrokenEvent>
  { $!gdk-e-gb }

  method get_grab_surface ( :$raw = False )
    is also<
      get-grab-surface
      grab_surface
      grab-surface
    >
  {
    propReturnObject(
      gdk_grab_broken_event_get_grab_surface(self.GdkEvent),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_implicit
    is also<
      get-implicit
      implicit
    >
  {
    so gdk_grab_broken_event_get_implicit(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_grab_broken_event_get_type, $n, $t );
  }
}


class GDK::Event::Key:ver<4> is GDK::Event {
  has GdkKeyEvent $!gdk-e-k;

  submethod BUILD ( :$gdk-key-event ) {
    $!gdk-e-k = $gdk-key-event
  }

  method new (GdkKeyEvent $e) {
    $e ?? self.bless( gdk-key-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkKeyEvent
    is also<GdkKeyEvent>
  { $!gdk-e-k }

  method get_consumed_modifiers ( :flags(:$set) = True )
    is also<
      get-consumed-modifiers
      consumed_modifiers
      consumed-modifiers
    >
  {
    my $m = gdk_key_event_get_consumed_modifiers(self.GdkEvent);
    return $m unless $set;
    getFlags(GdkModifierTypeEnum, $m);
  }

  method get_keycode
    is also<
      get-keycode
      keycode
    >
  {
    gdk_key_event_get_keycode(self.GdkEvent);
  }

  method get_keyval
    is also<
      get-keyval
      keyval
    >
  {
    gdk_key_event_get_keyval(self.GdkEvent);
  }

  method get_layout
    is also<
      get-layout
      layout
    >
  {
    gdk_key_event_get_layout(self.GdkEvent);
  }

  method get_level
    is also<
      get-level
      level
    >
  {
    gdk_key_event_get_level(self.GdkEvent);
  }

  proto method get_match (|)
  { * }

  multi method get_match ( :flags(:$set) = True ) {
    return-with-all( samewith($, $, :$set) )
  }
  multi method get_match (
     $keyval      is rw,
     $modifiers   is rw,
    :flags(:$set)        = True,
    :$all                = False
  )
    is also<get-match>
  {
    my guint           $k = 0;
    my GdkModifierType $m = 0;

    my $rv = gdk_key_event_get_match(self.GdkEvent, $k, $m);
    $m = getFlags(GdkModifierTypeEnum, $m) if $set;
    ($keyval, $modifiers) = ($k, $m);
    $all.not ?? $rv !! ($rv, $keyval, $modifiers);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_key_event_get_type, $n, $t );
  }

  method is_modifier is also<is-modifier> {
    so gdk_key_event_is_modifier(self.GdkEvent);
  }

  multi method matches ( :flags(:$set) = True ) {
    samewith($, $, :$set);
  }
  multi method matches (
     $keyval       is rw,
     $modifiers    is rw,
    :flags(:$set)         = True,
    :$enum                = True
  ) {
    my guint           $k = 0;
    my GdkModifierType $m = 0;

    my $rv = gdk_key_event_matches(self.GdkEvent, $k, $m);
    $rv = GdkKeyMatchEnum($rv) if $enum;
    $m = getFlags(GdkModifierTypeEnum, $m) if $set;
    ($keyval, $modifiers) = ($k, $m);
    ($rv, $keyval, $modifiers)
  }

}

class GDK::Event::Motion:ver<4> is GDK::Event {
  has GdkMotionEvent $!gdk-e-m;

  submethod BUILD ( :$gdk-motion-event ) {
    $!gdk-e-m = $gdk-motion-event
  }

  method new (GdkMotionEvent $e) {
    $e ?? self.bless( gdk-motion-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkMotionEvent
    is also<GdkMotionEvent>
  { $!gdk-e-m }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_motion_event_get_type, $n, $t );
  }
}

class GDK::Event::Pad:ver<4> is GDK::Event {
  has GdkPadEvent $!gdk-e-p;

  submethod BUILD ( :$gdk-pad-event ) {
    $!gdk-e-p = $gdk-pad-event
  }

  method new (GdkPadEvent $e) {
    $e ?? self.bless( gdk-pad-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkPadEvent
    is also<GdkPadEvent>
  { $!gdk-e-p }

  proto method get_axis_value (|)
  { * }

  multi method get_axis_value {
    samewith($, $);
  }
  multi method get_axis_value ($index is rw, $value is rw)
    is also<
      get-axis-value
      axis_value
      axis-value
    >
  {
    my guint   $i = 0;
    my gdouble $v = 0e0;

    gdk_pad_event_get_axis_value(self.GdkEvent, $i, $v);
    ($index, $value) = ($i, $v);
  }

  method get_button
    is also<
      get-button
      button
    >
  {
    gdk_pad_event_get_button(self.GdkEvent);
  }

  proto method get_group_mode (|)
  { * }

  multi method get_group_mode {
    samewith($, $);
  }
  multi method get_group_mode ($group is rw, $mode is rw)
    is also<
      get-group-mode
      group_mode
      group-mode
    >
  {
    my guint ($g, $m) = 0 xx 2;

    gdk_pad_event_get_group_mode(self.GdkEvent, $g, $m);
    ($group, $mode) = ($g, $m);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_pad_event_get_type, $n, $t );
  }
}

class GDK::Event::Proximity:ver<4> is GDK::Event {
  has GdkProximityEvent $!gdk-e-prox;

  submethod BUILD ( :$gdk-prox-event ) {
    $!gdk-e-prox = $gdk-prox-event
  }

  method new (GdkProximityEvent $e) {
    $e ?? self.bless( gdk-prox-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkProximityEvent
    is also<GdkProximityEvent>
  { $!gdk-e-prox }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_proximity_event_get_type, $n, $t );
  }
}

class GDK::Event::Scroll:ver<4> is GDK::Event {
  has GdkScrollEvent $!gdk-e-s;

  submethod BUILD ( :$gdk-scroll-event ) {
    $!gdk-e-s = $gdk-scroll-event
  }

  method new (GdkScrollEvent $e) {
    $e ?? self.bless( gdk-scroll-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkScrollEvent
    is also<GdkScrollEvent>
  { $!gdk-e-s }

  proto method get_deltas (|)
  { * }

  multi method get_deltas {
    samewith($, $);
  }
  multi method get_deltas ($delta_x is rw, $delta_y is rw)
    is also<
      get-deltas
      deltas
    >
  {
    my gdouble ($dx, $dy) = 0e0 xx 2;

    gdk_scroll_event_get_deltas(self.GdkEvent, $dx, $dy);
    ($delta_x, $delta_y) = ($dx, $dy);
  }

  method get_direction ( :$enum = True )
    is also<
      get-direction
      direction
    >
  {
    my $d = gdk_scroll_event_get_direction(self.GdkEvent);
    return $d unless $enum;
    GdkScrollDirectionEnum($d);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_scroll_event_get_type, $n, $t );
  }

  method get_unit ( :$enum = True )
    is also<
      get-unit
      unit
    >
  {
    my $u = gdk_scroll_event_get_unit(self.GdkEvent);
    return $u unless $enum;
    GdkScrollUnit($u);
  }

  method is_stop is also<is-stop> {
    so gdk_scroll_event_is_stop(self.GdkEvent);
  }
}

class GDK::Event::Touch:ver<4> is GDK::Event {
  has GdkTouchEvent $!gdk-e-t;

  submethod BUILD ( :$gdk-touch-event ) {
    $!gdk-e-t = $gdk-touch-event
  }

  method new (GdkTouchEvent $e) {
    $e ?? self.bless( gdk-touch-event => $e, gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkTouchEvent
    is also<GdkTouchEvent>
  { $!gdk-e-t }

  method get_emulating_pointer
    is also<
      get-emulating-pointer
      emulating_pointer
      emulating-pointer
    >
  {
    so gdk_touch_event_get_emulating_pointer(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_touch_event_get_type, $n, $t );
  }
}

class GDK::Event::Touchpad:ver<4> is GDK::Event {
  has GdkTouchpadEvent $!gdk-e-tp;

  submethod BUILD ( :$gdk-touchpad-event ) {
    $!gdk-e-tp = $gdk-touchpad-event
  }

  method new (GdkTouchpadEvent $e) {
    $e ?? self.bless( gdk-touchpad-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkTouchpadEvent
    is also<GdkTouchpadEvent>
  { $!gdk-e-tp }

  proto method get_deltas (|)
  { * }

  multi method get_deltas {
    samewith($, $);
  }
  multi method get_deltas ($deltax is rw, $deltay is rw)
    is also<
      get-deltas
      deltas
    >
  {
    my gdouble ($dx, $dy) = 0e0 xx 2;

    gdk_touchpad_event_get_deltas(self.GdkEvent, $dx, $dy);
    ($deltax, $deltay) = ($dx, $dy);
  }

  method get_gesture_phase ( :$enum = True )
    is also<
      get-gesture-phase
      gesture_phase
      gesture-phase
      phase
    >
  {
    my $p = gdk_touchpad_event_get_gesture_phase(self.GdkEvent);
    return $p unless $enum;
    GdkTouchpadGesturePhaseEnum($p);
  }

  method get_n_fingers
    is also<
      get-n-fingers
      n_fingers
      n-fingers
      elems
    >
  {
    gdk_touchpad_event_get_n_fingers(self.GdkEvent);
  }

  method get_pinch_angle_delta
    is also<
      get-pinch-angle-delta
      pinch_angle_delta
      pinch-angle-delta
      delta
    >
  {
    gdk_touchpad_event_get_pinch_angle_delta(self.GdkEvent);
  }

  method get_pinch_scale
    is also<
      get-pinch-scale
      pinch_scale
      pinch-scale
      scale
    >
  {
    gdk_touchpad_event_get_pinch_scale(self.GdkEvent);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_touchpad_event_get_type, $n, $t );
  }
}

our subset GdkAnyEvent is export of Mu where
  GdkEvent            | GdkButtonEvent      | GdkCrossingEvent    |
  GdkDeleteEvent      | GdkFocusEvent       | GdkGrabBrokenEvent  |
  GdkKeyEvent         | GdkMotionEvent      | GdkPadEvent         |
  GdkProximityEvent   | GdkScrollEvent      | GdkTouchEvent       |
  GdkTouchpadEvent;

class GDK::Events {

  my $button-types   = (GDK_BUTTON_PRESS, GDK_BUTTON_RELEASE).any;
  my $cross-types    = (GDK_ENTER_NOTIFY, GDK_LEAVE_NOTIFY).any;
  my $key-types      = (GDK_KEY_PRESS, GDK_KEY_RELEASE).any;
  my $prox-types     = (GDK_PROXIMITY_IN, GDK_PROXIMITY_OUT).any;
  my $drag-types     = (GDK_DRAG_ENTER,
                        GDK_DRAG_LEAVE, GDK_DRAG_MOTION, GDK_DROP_START).any;
  my $pad-types      = (GDK_PAD_BUTTON_PRESS, GDK_PAD_BUTTON_RELEASE,
                        GDK_PAD_RING, GDK_PAD_STRIP,GDK_PAD_GROUP_MODE).any;
  my $touch-types    = (GDK_TOUCH_BEGIN, GDK_TOUCH_UPDATE, GDK_TOUCH_END,
                        GDK_TOUCH_CANCEL).any;
  my $touchpad-types = (GDK_TOUCHPAD_SWIPE, GDK_TOUCHPAD_PINCH,
                        GDK_TOUCHPAD_HOLD).any;

  method new (GdkAnyEvent $e) {
    (
      do given GDK::Events.get_event_type($e) {
        when    $button-types     { GDK::Event::Button     }
        when    $cross-types      { GDK::Event::Crossing   }
        when    GDK_DELETE        { GDK::Event::Delete     }
        when    $drag-types       { GDK::Events::DnD       }
        when    GDK_FOCUS_CHANGE  { GDK::Event::Focus      }
        when    GDK_GRAB_BROKEN   { GDK::Event::GrabBroken }
        when    $key-types        { GDK::Event::Key        }
        when    GDK_MOTION_NOTIFY { GDK::Event::Motion     }
        when    $pad-types        { GDK::Event::Pad        }
        when    $prox-types       { GDK::Event::Proximity  }
        when    GDK_SCROLL        { GDK::Event::Scroll     }
        when    $touch-types      { GDK::Event::Touch      }
        when    $touchpad-types   { GDK::Event::Touchpad   }
        default                   { GDK::Event             }
      }
    ).new($e);
  }

}


class GDK::Event::Sequence:ver<4> {
  has GdkEventSequence $!gdk-es;

  method new (GdkEventSequence $e) {
    $e ?? self.bless( gdk-event => $e ) !! Nil;
  }

  method GDK::Raw::Definitions::GdkEventSequence
    is also<GdkEventSequence>
  { $!gdk-es }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_event_sequence_get_type, $n, $t );
  }
}
