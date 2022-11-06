use v6.c;

use NativeCall;

use GDK::Raw::Types:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

role GDK::Roles::DragSurface {
  has GdkDragSurface $!gdk-ds is implementor;

  method present (Int() $width, Int() $height) {
    my gint ($w, $h) = ($width, $height);

    so gdk_drag_surface_present($!gdk-ds, $width, $height);
  }

  method GDK::Raw::Definitions::GdkDragSurface
  { $!gdk-ds }

  method GdkDragSurface { $!gdk-ds }

}


our subset GdkDragSurfaceAncestry is export of Mu
  where GdkDragSurface | GObject;

class GDK::DragSurface {
  also does GLib::Roles::Object;
  also does GDK::Roles::DragSurface;

  submethod BUILD ( :$gdk-drag-surface ) {
    self.setGdkDragSurface($gdk-drag-surface) if $gdk-drag-surface
  }

  method setGdkDragSurface (GdkDragSurfaceAncestry $_) {
    my $to-parent;

    $!gdk-ds = do {
      when GdkDragSurface {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkDragSurface, $_);
      }
    }
    self!setObject($to-parent);
  }

  multi method new (GdkDragSurfaceAncestry $gdk-drag-surface, :$ref = True) {
    return unless $gdk-drag-surface;

    my $o = self.bless( :$gdk-drag-surface );
    $o.ref if $ref;
    $o;
  }

}


### /usr/src/gtk4-4.8.1+ds/gdk/gdkdragsurface.h

sub gdk_drag_surface_present (
  GdkDragSurface $drag_surface,
  gint           $width,
  gint           $height
)
  returns uint32
  is      native(gdk4)
  is      export
{ * }
