use v6.c;

use NativeCall;
use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::GLContext:ver<4>;

use GDK::DrawContext:ver<4>;
use GDK::Display:ver<4>;
use GDK::Surface:ver<4>;

use GLib::Roles::Implementor;

our subset GdkGLContextAncestry is export of Mu
  where GdkGLContext | GdkDrawContextAncestry;

class GDK::GLContext:ver<4> is GDK::DrawContext:ver<4> {
  has GdkGLContext $!gdk-gc is implementor;

  submethod BUILD ( :$gdk-gl-context ) {
    self.setGdkGLContext($gdk-gl-context) if $gdk-gl-context
  }

  method setGdkGLContext (GdkGLContextAncestry $_) {
    my $to-parent;

    $!gdk-gc = do {
      when GdkGLContext {
        $to-parent = cast(GdkDrawContext, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkGLContext, $_);
      }
    }
    self.setGdkDrawContext($to-parent);
  }

  method GDK::Raw::Definitions::GdkGLContext
    is also<GdkGLContext>
  { $!gdk-gc }

  multi method new (GdkGLContextAncestry $gdk-gl-context, :$ref = True) {
    return unless $gdk-gl-context;

    my $o = self.bless( :$gdk-gl-context );
    $o.ref if $ref;
    $o;
  }

  method get_current is also<get-current> {
    my $gdk-gl-context = gdk_gl_context_get_current();

    $gdk-gl-context ?? self.bless( :$gdk-gl-context ) !! Nil;
  }

  # Type: GDKGlContext
  method shared-context ( :$raw = False )
    is rw
    is g-property
    is also<shared_context>
  {
    my $gv = GLib::Value.new( self.get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('shared-context', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |self.getTypePair
        );
      },
      STORE => -> $, GdkGLContext() $val is copy {
        $gv.object = $val;
        self.prop_set('shared-context', $gv);
      }
    );
  }

  # Type: GDKGlApi
  method allowed-apis ( :flags(:$set) = True )
    is rw
    is g-property
    is also<allowed_apis>
  {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkGLAPI) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('allowed-apis', $gv);
        my $a = $gv.valueFromEnum(GdkGLAPI);
        $a = getFlags(GdkGLAPIEnum, $a) if $set;
        $a;
      },
      STORE => -> $, Int() $val is copy {
        $gv.valueFromEnum(GdkGLAPI) = $val;
        self.prop_set('allowed-apis', $gv);
      }
    );
  }

  # Type: GDKGlApi
  method api ( :$enum = True ) is rw  is g-property {
    my $gv = GLib::Value.new( GLib::Value.typeFromEnum(GdkGLAPI) );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('api', $gv);
        my $a = $gv.valueFromEnum(GdkGLAPI);
        $a = GdkGLAPIEnum($a) if $enum;
        $a;
      },
      STORE => -> $,  $val is copy {
        warn 'api does not allow writing'
      }
    );
  }

  method clear_current is also<clear-current> is static {
    gdk_gl_context_clear_current();
  }

  method error_quark is static is also<error-quark> {
    gdk_gl_error_quark();
  }

  method get_allowed_apis ( :set(:$flags) = True ) is also<get-allowed-apis> {
    my $a = gdk_gl_context_get_allowed_apis($!gdk-gc);
    return $a unless $flags;
    getFlags(GdkGLAPIEnum, $a)
  }

  method get_api is also<get-api> {
    GdkGLAPIEnum( gdk_gl_context_get_api($!gdk-gc) );
  }

  method get_debug_enabled is also<get-debug-enabled> {
    so gdk_gl_context_get_debug_enabled($!gdk-gc);
  }

  method get_display ( :$raw = False ) is also<get-display> {
    propReturnObject(
      gdk_gl_context_get_display($!gdk-gc),
      $raw,
      |GDK::Display.getTypePair
    );
  }

  method get_forward_compatible is also<get-forward-compatible> {
    so gdk_gl_context_get_forward_compatible($!gdk-gc);
  }

  proto method get_required_version (|)
    is also<get-required-version>
  { * }

  multi method get_required_version ( :$parts = False ) {
    my ($maj, $min) = samewith($, $);
    return ($maj, $min) if $parts;
    Version.new("{ $maj }.{ $min }");
  }
  multi method get_required_version ($major is rw, $minor is rw) {
    my gint ($mj, $mn) = 0 xx 2;

    gdk_gl_context_get_required_version($!gdk-gc, $mj, $mn);
    ($major, $minor) = ($mj, $mn);
  }

  method get_surface ( :$raw = False ) is also<get-surface> {
    propReturnObject(
      gdk_gl_context_get_surface($!gdk-gc),
      $raw,
      |GDK::Surface.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_gl_context_get_type, $n, $t );
  }

  method get_use_es is also<get-use-es> {
    so gdk_gl_context_get_use_es($!gdk-gc);
  }

  proto method get_version (|)
    is also<get-version>
  { * }

  multi method get_version ( :$parts = False ) {
    my ($maj, $min) = samewith($, $);
    return ($maj, $min) if $parts;
    Version.new("{ $maj }.{ $min }");
  }
  multi method get_version (
    $major is rw,
    $minor is rw
  ) {
    my gint ($mj, $mn) = 0 xx 2;

    gdk_gl_context_get_version($!gdk-gc, $mj, $mn);
    ($major, $minor) = ($mj, $mn);
  }

  method is_legacy is also<is-legacy> {
    so gdk_gl_context_is_legacy($!gdk-gc);
  }

  method is_shared (GdkGLContext() $other) is also<is-shared> {
    so gdk_gl_context_is_shared($!gdk-gc, $other);
  }

  method make_current is also<make-current> {
    gdk_gl_context_make_current($!gdk-gc);
  }

  method realize (CArray[Pointer[GError]] $error = gerror) {
    clear_error;
    my $rv = so gdk_gl_context_realize($!gdk-gc, $error);
    set_error($error);
    $rv;
  }

  # cw: Should also accept Set/Array!
  method set_allowed_apis (Int() $apis) is also<set-allowed-apis> {
    my GdkGLAPI $a = $apis;

    gdk_gl_context_set_allowed_apis($!gdk-gc, $a);
  }

  method set_debug_enabled (Int() $enabled) is also<set-debug-enabled> {
    my gboolean $e = $enabled.so.Int;

    gdk_gl_context_set_debug_enabled($!gdk-gc, $e);
  }

  method set_forward_compatible (Int() $compatible)
    is also<set-forward-compatible>
  {
    my gboolean $c = $compatible.so.Int;

    gdk_gl_context_set_forward_compatible($!gdk-gc, $c);
  }

  method set_required_version (Int() $major, Int() $minor)
    is also<set-required-version>
  {
    my gint ($mj, $mn) = ($major, $minor);

    gdk_gl_context_set_required_version($!gdk-gc, $mj, $mn);
  }

}
