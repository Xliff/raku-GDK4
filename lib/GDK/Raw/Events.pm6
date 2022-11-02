use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Definitions:ver<4>;
use GDK::Raw::Enums:ver<4>;
use GDK::Raw::Structs:ver<4>;

unit package GDK::Raw::Events:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkevents.h

sub gdk_button_event_get_button (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_button_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_crossing_event_get_detail (GdkEvent $event)
  returns GdkNotifyType
  is      native(gdk4)
  is      export
{ * }

sub gdk_crossing_event_get_focus (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_crossing_event_get_mode (GdkEvent $event)
  returns GdkCrossingMode
  is      native(gdk4)
  is      export
{ * }

sub gdk_crossing_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_delete_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_dnd_event_get_drop (GdkEvent $event)
  returns GdkDrop
  is      native(gdk4)
  is      export
{ * }

sub gdk_dnd_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_events_get_angle (
  GdkEvent $event1,
  GdkEvent $event2,
  gdouble  $angle   is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_events_get_center (
  GdkEvent $event1,
  GdkEvent $event2,
  gdouble  $x       is rw,
  gdouble  $y       is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_events_get_distance (
  GdkEvent $event1,
  GdkEvent $event2,
  gdouble  $distance is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_focus_event_get_in (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_focus_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_grab_broken_event_get_grab_surface (GdkEvent $event)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_grab_broken_event_get_implicit (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_grab_broken_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_consumed_modifiers (GdkEvent $event)
  returns GdkModifierType
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_keycode (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_keyval (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_layout (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_level (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_match (
  GdkEvent        $event,
  guint           $keyval    is rw,
  GdkModifierType $modifiers
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_is_modifier (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_key_event_matches (
  GdkEvent        $event,
  guint           $keyval,
  GdkModifierType $modifiers
)
  returns GdkKeyMatch
  is      native(gdk4)
  is      export
{ * }

sub gdk_motion_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_pad_event_get_axis_value (
  GdkEvent $event,
  guint    $index  is rw,
  gdouble  $value  is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_pad_event_get_button (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_pad_event_get_group_mode (
  GdkEvent $event,
  guint    $group  is rw,
  guint    $mode   is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_pad_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_proximity_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_scroll_event_get_deltas (
  GdkEvent $event,
  gdouble  $delta_x is rw,
  gdouble  $delta_y is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_scroll_event_get_direction (GdkEvent $event)
  returns GdkScrollDirection
  is      native(gdk4)
  is      export
{ * }

sub gdk_scroll_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_scroll_event_get_unit (GdkEvent $event)
  returns GdkScrollUnit
  is      native(gdk4)
  is      export
{ * }

sub gdk_scroll_event_is_stop (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_touch_event_get_emulating_pointer (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_touch_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_deltas (
  GdkEvent $event,
  gdouble  $dx     is rw,
  gdouble  $dy     is rw
)
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_gesture_phase (GdkEvent $event)
  returns GdkTouchpadGesturePhase
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_n_fingers (GdkEvent $event)
  returns guint
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_pinch_angle_delta (GdkEvent $event)
  returns gdouble
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_pinch_scale (GdkEvent $event)
  returns gdouble
  is      native(gdk4)
  is      export
{ * }

sub gdk_touchpad_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_axes (
  GdkEvent        $event,
  CArray[gdouble] $axes,
  guint           $n_axes is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_axis (
  GdkEvent   $event,
  GdkAxisUse $axis_use,
  gdouble    $value     is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_device (GdkEvent $event)
  returns GdkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_device_tool (GdkEvent $event)
  returns GdkDeviceTool
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_display (GdkEvent $event)
  returns GdkDisplay
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_event_sequence (GdkEvent $event)
  returns GdkEventSequence
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_event_type (GdkEvent $event)
  returns GdkEventType
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_history (
  GdkEvent $event,
  guint    $out_n_coords is rw
)
  returns GdkTimeCoord
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_modifier_state (GdkEvent $event)
  returns GdkModifierType
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_pointer_emulated (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_position (
  GdkEvent $event,
  gdouble  $x is rw,
  gdouble  $y is rw
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_seat (GdkEvent $event)
  returns GdkSeat
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_surface (GdkEvent $event)
  returns GdkSurface
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_time (GdkEvent $event)
  returns guint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_ref (GdkEvent $event)
  returns GdkEvent
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_sequence_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_triggers_context_menu (GdkEvent $event)
  returns uint32
  is      native(gdk4)
  is      export
{ * }

sub gdk_event_unref (GdkEvent $event)
  is      native(gdk4)
  is      export
{ * }
