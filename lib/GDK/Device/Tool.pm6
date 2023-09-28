use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkDeviceToolAncestry is export of Mu
  where GdkDeviceTool | GObject;

class GDK::Device::Tool:ver<4> {
  also does GLib::Roles::Object;

  has GdkDeviceTool $!gdk-dt is implementor;

  submethod BUILD ( :$gdk-device-tool ) {
    self.setGdkDeviceTool($gdk-device-tool) if $gdk-device-tool
  }

  method setGdkDeviceTool (GdkDeviceToolAncestry $_) {
    my $to-parent;

    $!gdk-dt = do {
      when GdkDeviceTool {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDeviceTool, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkDeviceTool
  { $!gdk-dt }

  multi method new (GdkDeviceToolAncestry $gdk-device-tool, :$ref = True) {
    return unless $gdk-device-tool;

    my $o = self.bless( :$gdk-device-tool );
    $o.ref if $ref;
    $o;
  }

  method get_axes ( :flags(:$set) = True ) {
    my $a = gdk_device_tool_get_axes($!gdk-dt);
    return $a unless $set;
    getFlags(GdkAxisFlags, $a);

  }

  method get_hardware_id {
    gdk_device_tool_get_hardware_id($!gdk-dt);
  }

  method get_serial {
    gdk_device_tool_get_serial($!gdk-dt);
  }

  method get_tool_type {
    GdkDeviceToolTypeEnum( gdk_device_tool_get_tool_type($!gdk-dt) )
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_device_tool_get_type, $n, $t );
  }

}

### /usr/src/gtk4/gdk/gdkdevicetool.h
sub gdk_device_tool_get_axes (GdkDeviceTool $tool)
  returns GdkAxisFlags
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_tool_get_hardware_id (GdkDeviceTool $tool)
  returns guint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_tool_get_serial (GdkDeviceTool $tool)
  returns guint64
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_tool_get_tool_type (GdkDeviceTool $tool)
  returns GdkDeviceToolType
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_tool_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
