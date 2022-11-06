use v6.c;

use Method::Also;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GDK::Device;

use GLib::Roles::Implementor;

role GDK::Roles::Device::Pad {
  has GdkDevicePad $!gdk-dp is implementor;

  method GDK::Raw::Definitions::GdkDevicePad
  { $!gdk-dp }

  method GdkDevicePad
  { $!gdk-dp }

  method get_feature_group (
    Int() $feature,
    Int() $feature_idx
  )
    is also<get-feature-group>
  {
    my GdkDevicePadFeature $f = $feature;
    my gint                $i = $feature_idx;

    gdk_device_pad_get_feature_group($!gdk-dp, $f, $i);
  }

  method get_group_n_modes (Int() $group_idx) is also<get-group-n-modes> {
    my gint $g = $group_idx;

    gdk_device_pad_get_group_n_modes($!gdk-dp, $g);
  }

  method get_n_features (Int() $feature) is also<get-n-features> {
    my GdkDevicePadFeature $f = $feature;

    gdk_device_pad_get_n_features($!gdk-dp, $f);
  }

  method get_n_groups
    is also<
      get-n-groups
      n_groups
      n-groups
      elems
    >
  {
    gdk_device_pad_get_n_groups($!gdk-dp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_device_pad_get_type, $n, $t );
  }

}

our subset GdkDevicePadAncestry is export of Mu
  where GdkDevicePad | GObject;

class GDK::Device::Pad {
  also does GLib::Roles::Object;
  also does GDK::Roles::Device::Pad;

  submethod BUILD ( :$gdk-device-pad ) {
    self.setGdkDevicePad($gdk-device-pad) if $gdk-device-pad
  }

  method setGdkDevicePad (GdkDevicePadAncestry $_) {
    my $to-parent;

    $!gdk-dp = do {
      when GdkDevicePad {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDevicePad, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdkDevicePadAncestry $gdk-device-pad, :$ref = True) {
    return unless $gdk-device-pad;

    my $o = self.bless( :$gdk-device-pad );
    $o.ref if $ref;
    $o;
  }

}


### /usr/src/gtk4-4.8.1+ds/gdk/gdkdevicepad.h

sub gdk_device_pad_get_feature_group (
  GdkDevicePad        $pad,
  GdkDevicePadFeature $feature,
  gint                $feature_idx
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_pad_get_group_n_modes (
  GdkDevicePad $pad,
  gint         $group_idx
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_pad_get_n_features (
  GdkDevicePad        $pad,
  GdkDevicePadFeature $feature
)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_pad_get_n_groups (GdkDevicePad $pad)
  returns gint
  is      native(gdk4)
  is      export
{ * }

sub gdk_device_pad_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
