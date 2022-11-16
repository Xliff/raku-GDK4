use v6.c;

use Method::Also;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::X11::Screen:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkX11ScreenAncestry is export of Mu
  where GdkX11Screen | GObject;

class GDK::X11::Screen:ver<4> {
  also does GLib::Roles::Object;

  has GdkX11Screen $!gdk-x11s is implementor;

  submethod BUILD ( :$gdk-x11-screen ) {
    self.setGdkX11Screen($gdk-x11-screen)
      if $gdk-x11-screen
  }

  method setGdkX11Screen (GdkX11ScreenAncestry $_) {
    my $to-parent;

    $!gdk-x11s = do {
      when GdkX11Screen {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkX11Screen, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkX11Screen
    is also<GdkX11Screen>
  { $!gdk-x11s }

  multi method new (GdkX11ScreenAncestry $gdk-x11-screen, :$ref = True) {
    return unless $gdk-x11-screen;

    my $o = self.bless( :$gdk-x11-screen );
    $o.ref if $ref;
    $o;
  }

  method get_current_desktop
    is also<
      get-current-desktop
      current_desktop
      current-desktop
    >
  {
    gdk_x11_screen_get_current_desktop($!gdk-x11s);
  }

  method get_monitor_output (Int() $monitor_num)
    is also<
      get-monitor-output
      monitor_output
      monitor-output
    >
  {
    my gint $m = $monitor_num;

    gdk_x11_screen_get_monitor_output($!gdk-x11s, $m);
  }

  method get_number_of_desktops
    is also<
      get-number-of-desktops
      number_of_desktops
      number-of-desktops
      num_desktops
      num-desktops
      ndesks
    >
  {
    gdk_x11_screen_get_number_of_desktops($!gdk-x11s);
  }

  method get_screen_number
    is also<
      get-screen-number
      screen_number
      screen-number
    >
  {
    gdk_x11_screen_get_screen_number($!gdk-x11s);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_x11_screen_get_type, $n, $t );
  }

  method get_window_manager_name
    is also<
      get-window-manager-name
      window_manager_name
      window-manager-name
      wm_name
      wm-name
    >
  {
    gdk_x11_screen_get_window_manager_name($!gdk-x11s);
  }

  method get_xscreen
    is also<
      get-xscreen
      xscreen
    >
  {
    gdk_x11_screen_get_xscreen($!gdk-x11s);
  }

  method supports_net_wm_hint (Str() $property_name)
    is also<supports-net-wm-hint>
  {
    so gdk_x11_screen_supports_net_wm_hint($!gdk-x11s, $property_name);
  }

}
