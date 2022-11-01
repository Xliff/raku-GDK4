use v6.c;

use NativeCall;

use GLib::Raw::ReturnedValue;

use GDK::Raw::Types:ver<4>;

use GLib::Roles::Signals::Generic;

role GDK::Roles::Signals::Generic:ver<4> {
  also does GLib::Roles::Signals::Generic;

  has %!signals-gdk;

  # GdkDevice, GdkDisplay, gpointer --> void
  method connect-display (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdk{$signal} //= do {
      my \ʂ = Supplier.new;
      $hid = g-connect-display($obj, $signal,
        -> $, $d, $ud {
          CATCH {
            default { ʂ.quit($_) }
          }

          ʂ.emit( [self, $d, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, ʂ), $obj, $hid];
    };
    %!signals-gdk{$signal}[0].tap(&handler) with &handler;
    %!signals-gdk{$signal}[0];
  }

  # GObject, GdkMonitor, gpointer --> void
  method connect-monitor (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdk{$signal} //= do {
      my \ʂ = Supplier.new;
      $hid = g-connect-monitor($obj, $signal,
        -> $, $m, $ud {
          CATCH {
            default { ʂ.quit($_) }
          }

          ʂ.emit( [self, $m, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, ʂ), $obj, $hid];
    };
    %!signals-gdk{$signal}[0].tap(&handler) with &handler;
    %!signals-gdk{$signal}[0];
  }

  # GdkDevice, GdkDisplay, gpointer --> gboolean
  method connect-display-rbool (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdk{$signal} //= do {
      my \ʂ = Supplier.new;
      $hid = g-connect-display($obj, $signal,
        -> $, $d, $ud --> gboolean {
          CATCH {
            default { ʂ.quit($_) }
          }

          my $r = ReturnedValue.new;
          ʂ.emit( [self, $d, $ud, $r] );
          $r.r
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, ʂ), $obj, $hid];
    };
    %!signals-gdk{$signal}[0].tap(&handler) with &handler;
    %!signals-gdk{$signal}[0];
  }

  # GdkDevice, GdkDeviceTool, gpointer --> void
  method connect-device (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdk{$signal} //= do {
      my \ʂ = Supplier.new;
      $hid = g-connect-device($obj, $signal,
        -> $, $d, $ud {
          CATCH {
            default { ʂ.quit($_) }
          }

          ʂ.emit( [self, $d, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, ʂ), $obj, $hid];
    };
    %!signals-gdk{$signal}[0].tap(&handler) with &handler;
    %!signals-gdk{$signal}[0];
  }

  # GdkDevice, GdkDeviceTool, gpointer --> void
  method connect-device-tool (
    $obj,
    $signal,
    &handler?
  ) {
    my $hid;
    %!signals-gdk{$signal} //= do {
      my \ʂ = Supplier.new;
      $hid = g-connect-device-tool($obj, $signal,
        -> $, $dt, $ud {
          CATCH {
            default { ʂ.quit($_) }
          }

          ʂ.emit( [self, $dt, $ud] );
        },
        Pointer, 0
      );
      [ self.create-signal-supply($signal, ʂ), $obj, $hid];
    };
    %!signals-gdk{$signal}[0].tap(&handler) with &handler;
    %!signals-gdk{$signal}[0];
  }
}

sub g-connect-display (
  Pointer $app,
  Str     $name,
          &handler (GObject, GdkDisplay, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-monitor (
  Pointer $app,
  Str     $name,
          &handler (GObject, GdkMonitor, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-display-rbool (
  Pointer $app,
  Str     $name,
          &handler (GObject, GdkDisplay, Pointer --> gboolean),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }

sub g-connect-device (
  Pointer $app,
  Str     $name,
          &handler (GObject, GdkDevice, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }


# GdkDevice, GdkDeviceTool, gpointer --> void
sub g-connect-device-tool(
  Pointer $app,
  Str     $name,
          &handler (GObject, GdkDeviceTool, Pointer),
  Pointer $data,
  uint32  $flags
)
  returns uint64
  is native('gobject-2.0')
  is symbol('g_signal_connect_object')
{ * }
