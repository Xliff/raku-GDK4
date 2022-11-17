use v6.c;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Toplevel:ver<4>;

use GLib::GList;
use GDK::Surface:ver<4>;
use GDK::Texture:ver<4>;

role GDK::Roles::Toplevel:ver<4> {
  has GdkToplevel $!gdk-tl is implementor;

  method GDK::Raw::Definitions::GdkTopLevel
  { $!gdk-tl }

  method GdkToplevel
  { $!gdk-tl }

  method roleInit-GdkToplevel {
    return if $!gdk-tl;

    my \i = findProperImplementor(self.^attributes);
    $!gdk-tl = cast( GdkToplevel, i.get_value(self) );
  }

  # Type: GDKToplevelState
  method state ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkToplevelState) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('state', $gv);
        my $s = $gv.valueFromEnum(GdkToplevelState);
        return $s unless $enum;
        GdkToplevelStateEnum($s);
      },
      STORE => -> $,  $val is copy {
        warn 'state does not allow writing'
      }
    );
  }

  # Type: string
  method title is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('title', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('title', $gv);
      }
    );
  }

  # Type: string
  method startup-id is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_STRING );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('startup-id', $gv);
        $gv.string;
      },
      STORE => -> $, Str() $val is copy {
        $gv.string = $val;
        self.prop_set('startup-id', $gv);
      }
    );
  }

  # Type: GDKSurface
  method transient-for ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( GDK::Surface.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('transient-for', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |GDK::Surface.getTypePair
        );
      },
      STORE => -> $, GdkSurface() $val is copy {
        $gv.object = $val;
        self.prop_set('transient-for', $gv);
      }
    );
  }

  # Type: boolean
  method modal is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('modal', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('modal', $gv);
      }
    );
  }

  # Type: pointer (GList of GdkTexture)
  method icon-list ( :$raw = False, :$glist = False ) is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_POINTER );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('icon-list', $gv);
        returnGList(
          cast(GList, $gv.pointer),
          $raw,
          $glist,
          |GDK::Texture.getTypePair
        );
      },
      STORE => -> $, GList() $val is copy {
        $gv.pointer = $val;
        self.prop_set('icon-list', $gv);
      }
    );
  }

  # Type: boolean
  method decorated is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('decorated', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('decorated', $gv);
      }
    );
  }

  # Type: boolean
  method deletable is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('deletable', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        $gv.boolean = $val;
        self.prop_set('deletable', $gv);
      }
    );
  }

  # Type: GDKFullscreenMode
  method fullscreen-mode ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typefromEnum(GdkFullscreenMode) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('fullscreen-mode', $gv);
        my $m = $gv.valuefromEnum(GdkFullscreenMode);
        return $m unless $enum;
        GdkFullscreenModeEnum($m);
      },
      STORE => -> $, Int() $val is copy {
        $gv.valuefromEnum(GdkFullscreenMode) = $val;
        self.prop_set('fullscreen-mode', $gv);
      }
    );
  }

  # Type: boolean
  method shortcuts-inhibited is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shortcuts-inhibited', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'shortcuts-inhibited does not allow writing'
      }
    );
  }

  method begin_move (
    GdkDevice() $device,
    Int()       $button,
    Num()       $x,
    Num()       $y,
    Int()       $timestamp
  ) {
    my gint     $b        =  $button;
    my gdouble ($xx, $yy) = ($x, $y);
    my guint32  $t        =  $timestamp;

    gdk_toplevel_begin_move($!gdk-tl, $device, $b, $xx, $yy, $t);
  }

  method begin_resize (
    Int()       $edge,
    GdkDevice() $device,
    Int()       $button,
    Num()       $x,
    Num()       $y,
    Int()       $timestamp
  ) {
    my GdkSurfaceEdge  $e        =  $edge;
    my gint            $b        =  $button;
    my gdouble        ($xx, $yy) = ($x, $y);
    my guint32         $t        =  $timestamp;

    gdk_toplevel_begin_resize($!gdk-tl, $edge, $device, $button, $x, $y, $timestamp);
  }

  method focus (Int() $timestamp) {
    my guint32 $t = $timestamp;

    gdk_toplevel_focus($!gdk-tl, $timestamp);
  }

  method get_state ( :$enum = True ) {
    my $s = gdk_toplevel_get_state($!gdk-tl);
    return $s unless $enum;
    GdkToplevelState($s);
  }

  method inhibit_system_shortcuts (GdkEvent() $event) {
    gdk_toplevel_inhibit_system_shortcuts($!gdk-tl, $event);
  }

  method lower {
    so gdk_toplevel_lower($!gdk-tl);
  }

  method minimize {
    so gdk_toplevel_minimize($!gdk-tl);
  }

  method present (GdkToplevelLayout $layout) {
    gdk_toplevel_present($!gdk-tl, $layout);
  }

  method restore_system_shortcuts {
    gdk_toplevel_restore_system_shortcuts($!gdk-tl);
  }

  method set_decorated (Int() $decorated) {
    my gboolean $d = $decorated.so.Int;

    gdk_toplevel_set_decorated($!gdk-tl, $d);
  }

  method set_deletable (Int() $deletable) {
    my gboolean $d = $deletable.so.Int;

    gdk_toplevel_set_deletable($!gdk-tl, $d);
  }

  method set_icon_list (GList() $surfaces) {
    gdk_toplevel_set_icon_list($!gdk-tl, $surfaces);
  }

  method set_modal (Int() $modal) {
    my gboolean $m = $modal.so.Int;

    gdk_toplevel_set_modal($!gdk-tl, $m);
  }

  method set_startup_id (Str() $startup_id) {
    gdk_toplevel_set_startup_id($!gdk-tl, $startup_id);
  }

  method set_title (Str() $title) {
    gdk_toplevel_set_title($!gdk-tl, $title);
  }

  method set_transient_for (GdkSurface() $parent) {
    gdk_toplevel_set_transient_for($!gdk-tl, $parent);
  }

  method show_window_menu (GdkEvent() $event) {
    gdk_toplevel_show_window_menu($!gdk-tl, $event);
  }

  method supports_edge_constraints {
    so gdk_toplevel_supports_edge_constraints($!gdk-tl);
  }

  method titlebar_gesture (Int() $gesture) {
    my GdkTitlebarGesture $g = $gesture;

    so gdk_toplevel_titlebar_gesture($!gdk-tl, $g);
  }

}

our subset GdkToplevelAncestry is export of Mu
  where GdkToplevel | GdkSurfaceAncestry;

class GDK::Toplevel is GDK::Surface {
  also does GDK::Roles::Toplevel;

  submethod BUILD ( :$gdk-toplevel ) {
    self.setGdkToplevel($gdk-toplevel) if $gdk-toplevel
  }

  method setGdkToplevel (GdkToplevelAncestry $_) {
    my $to-parent;

    $!gdk-tl = do {
      when GdkToplevel {
        $to-parent = cast(GdkSurface, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkToplevel, $_);
      }
    }
    self.setGdkSurface($to-parent);
  }

  multi method new (GdkToplevelAncestry $gdk-toplevel, :$ref = True) {
    return unless $gdk-toplevel;

    my $o = self.bless( :$gdk-toplevel );
    $o.ref if $ref;
    $o;
  }

}
