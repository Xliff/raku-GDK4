use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::X11::Display:ver<4>;

use GDK::Display:ver<4>;
use GDK::Surface:ver<4>;
use GDK::Monitor:ver<4>;
use GDK::X11::Screen:ver<4>;

use GLib::Roles::Implementor;

our subset GdkX11DisplayAncestry is export of Mu
  where GdkX11Display | GdkDisplayAncestry;

class GDK::X11::Display is GDK::Display:ver<4> {
  has GdkX11Display $!gdk-x11d is implementor;

  submethod BUILD ( :$gdk-x11-display ) {
    self.setGdkX11Display($gdk-x11-display)
      if $gdk-x11-display
  }

  method setGdkX11Display (GdkX11DisplayAncestry $_) {
    my $to-parent;

    $!gdk-x11d = do {
      when GdkX11Display {
        $to-parent = cast(GdkDisplay, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkX11Display, $_);
      }
    }
    self.setGdkDisplay($to-parent);
  }

  method GDK::Raw::Definitions::GdkX11Display
    is also<GdkX11Display>
  { $!gdk-x11d }

  multi method new (GdkX11DisplayAncestry $gdk-x11-display, :$ref = True) {
    return unless $gdk-x11-display;

    my $o = self.bless( :$gdk-x11-display );
    $o.ref if $ref;
    $o;
  }

  multi method new ($display) {
    return self.open($display)            if $display ~~ Str;
    return self.lookup-xdisplay($display) if $display ~~ gpointer;

    return self.lookup-xdisplay($display.Pointer) if $display.^can('Pointer');
    return self.lookup-xdisplay($display.Display) if $display.^can('Display');

    self.open($display.Str);
  }
  method open (Str() $display) {
    my $gdk-x11-display = gdk_x11_display_open($display);

    $gdk-x11-display ?? self.bless( :$gdk-x11-display ) !! Nil;
  }

  method lookup_xdisplay (Display $xdisplay) is also<lookup-xdisplay> {
    my $gdk-x11-display = gdk_x11_lookup_xdisplay($xdisplay);

    $gdk-x11-display ?? self.bless( :$gdk-x11-display ) !! Nil;
  }

  method broadcast_startup_message (Str() $message_type)
    is also<broadcast-startup-message>
  {
    gdk_x11_display_broadcast_startup_message($!gdk-x11d, $message_type, Str);
  }

  method error_trap_pop is also<error-trap-pop> {
    gdk_x11_display_error_trap_pop($!gdk-x11d);
  }

  method error_trap_pop_ignored is also<error-trap-pop-ignored> {
    gdk_x11_display_error_trap_pop_ignored($!gdk-x11d);
  }

  method error_trap_push is also<error-trap-push> {
    gdk_x11_display_error_trap_push($!gdk-x11d);
  }

  method set_sm_client_id (Str() $sm-client-id)
    is static
    is also<set-sm-client-id>
  {
    gdk_x11_set_sm_client_id($sm-client-id);
  }

  method get_default_group ( :$raw = False )
    is also<
      get-default-group
      default_group
      default-group
    >
  {
    propReturnObject(
      gdk_x11_display_get_default_group($!gdk-x11d),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_primary_monitor ( :$raw = False )
    is also<
      get-primary-monitor
      primary_monitor
      primary-monitor
    >
  {
    propReturnObject(
      gdk_x11_display_get_primary_monitor($!gdk-x11d),
      $raw,
      |GDK::Monitor.getTypePair
    );

  }

  method get_screen (:$raw = False )
    is also<
      get-screen
      screen
    >
  {
    propReturnObject(
      gdk_x11_display_get_screen($!gdk-x11d),
      $raw,
      |GDK::X11::Screen.getTypePair
    );
  }

  method get_startup_notification_id
    is also<
      get-startup-notification-id
      startup_notification_id
      startup-notification-id
      startup_id
      startup-id
    >
  {
    gdk_x11_display_get_startup_notification_id($!gdk-x11d);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_x11_display_get_type, $n, $t );
  }

  method get_user_time
    is also<
      get-user-time
      user_time
      user-time
    >
  {
    gdk_x11_display_get_user_time($!gdk-x11d);
  }

  method get_xcursor (GdkCursor() $cursor)
    is also<
      get-xcursor
      xcursor
    >
  {
    gdk_x11_display_get_xcursor($!gdk-x11d, $cursor);
  }

  method get_xdisplay
    is also<
      get-xdisplay
      xdisplay
    >
  {
    gdk_x11_display_get_xdisplay($!gdk-x11d);
  }

  method get_xrootwindow
    is also<
      get-xrootwindow
      xrootwindow
      xroot
    >
  {
    gdk_x11_display_get_xrootwindow($!gdk-x11d);
  }

  method get_xscreen
    is also<
      get-xscreen
      xscreen
    >
  {
    gdk_x11_display_get_xscreen($!gdk-x11d);
  }

  method grab {
    gdk_x11_display_grab($!gdk-x11d);
  }

  method set_cursor_theme (Str() $theme, Int() $size) is also<set-cursor-theme> {
    my gint $s = $size;
    gdk_x11_display_set_cursor_theme($!gdk-x11d, $theme, $size);
  }

  method set_program_class (Str() $program_class) is also<set-program-class> {
    gdk_x11_display_set_program_class($!gdk-x11d, $program_class);
  }

  method set_startup_notification_id (Str() $startup_id) is also<set-startup-notification-id> {
    gdk_x11_display_set_startup_notification_id($!gdk-x11d, $startup_id);
  }

  method set_surface_scale (Int() $scale) is also<set-surface-scale> {
    my gint $s = $scale;

    gdk_x11_display_set_surface_scale($!gdk-x11d, $s);
  }

  method ungrab {
    gdk_x11_display_ungrab($!gdk-x11d);
  }

}
