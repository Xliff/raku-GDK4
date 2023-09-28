use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Content::Provider:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkContentProviderAncestry is export of Mu
  where GdkContentProvider | GObject;

class GDK::Content::Provider {
  also does GLib::Roles::Object;

  has GdkContentProvider $!gdk-cp is implementor;

  submethod BUILD ( :$gdk-content-provider ) {
    self.setGdkContentProvider($gdk-content-provider)
      if $gdk-content-provider
  }

  method setGdkContentProvider (GdkContentProviderAncestry $_) {
    my $to-parent;

    $!gdk-cp = do {
      when GdkContentProvider {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkContentProvider, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkContentProvider
    is also<GdkContentProvider>
  { $!gdk-cp }

  multi method new (
    GdkContentProviderAncestry  $gdk-content-provider,
                               :$ref                   = True
  ) {
    return unless $gdk-content-provider;

    my $o = self.bless( :$gdk-content-provider );
    $o.ref if $ref;
    $o;
  }

  proto method new_typed (|)
  { * }

  method new_typed (
           $value,
          :$type    is copy,
          :$signed,
          :$double,
          :$direct
  )
    is also<new-typed>
  {
    my gint $t = $type;

    unless $t {
      $t = do if $value ~~ GLib::Object {
        $value.get_type
      } elsif $value ~~ GObject {
        G_TYPE_OBJECT
      } else {
        GLib::Value.gtypeFromType($value.WHAT) || G_TYPE_POINTER;
      }
    }

    samewith( $t, toPointer($v, :$signed, :$double, $direct) );
  }

  method new_typed (Int() $type, gpointer $value);
    my $gdk-content-provider = gdk_content_provider_new_typed(
      $t,
      $value
      Str
    );

    $gdk-content-provider ?? self.bless( :$gdk-content-provider ) !! Nil;
  }

  # Type: GDKContentFormats
  method formats ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Content::Formats').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Content::Formats').getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'formats does not allow writing'
      }
    );
  }

  # Type: GDKContentFormats
  method storable-formats ( :$raw = False )
    is rw
    is g-property
    is also<storable_formats>
 {
    my $gv = GLib::Value.new( ::('GDK::Content::Formats').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('storable-formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Content::Formats').getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'storable-formats does not allow writing'
      }
    );
  }

  method content-changed is also<content_changed> {
    self.connect($!gdk-cp, 'content-changed');
  }

  method emit_content_changed is also<emit-content-changed> {
    gdk_content_provider_content_changed($!gdk-cp);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_content_provider_get_type, $n, $t );
  }

  proto method get_value (|)
    is also<get-value>
  { * }

  multi method get_value (
    CArray[Pointer[GError]]  $error = gerror,
                            :$raw   = False
  )
    is also<value>
  {
    samewith(GValue.new, $error, :all, :$raw);
  }
  multi method get_value (
    GValue()                 $value is copy,
    CArray[Pointer[GError]]  $error          = gerror,
                            :$all            = False,
                            :$raw            = False
  ) {
    clear_error;
    my $rv = so gdk_content_provider_get_value($!gdk-cp, $value, $error);
    set_error($error);
    $value = GLib::Value.new($value) unless $raw;
    $all.not ?? $rv !! ($rv, $value);
  }

  method ref_formats ( :$raw = False ) is also<ref-formats> {
    propReturnObject(
      gdk_content_provider_ref_formats($!gdk-cp),
      $raw,
      |::('GDK::Content::Formats').getTypePair
    );
  }

  method ref_storable_formats ( :$raw = False ) is also<ref-storable-formats> {
    propReturnObject(
      gdk_content_provider_ref_storable_formats($!gdk-cp),
      $raw,
      |::('GDK::Content::Formats').getTypePair
    );
  }

  proto method write_mime_type_async (|)
    is also<write-mime-type-async>
  { * }

  multi method write_mime_type_async (
    Str()           $mime_type,
    GOutputStream() $stream,
                    &callback,
    gpointer        $user_data    = gpointer,
    Int()          :$io_priority  = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable  = GCancellable
  ) {
    samewith(
      $mime_type,
      $stream,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method write_mime_type_async (
    Str()           $mime_type,
    GOutputStream() $stream,
    Int()           $io_priority,
    GCancellable()  $cancellable,
                    &callback,
    gpointer        $user_data     = gpointer
  ) {
    my gint $i = $io_priority;

    gdk_content_provider_write_mime_type_async(
      $!gdk-cp,
      $mime_type,
      $stream,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method write_mime_type_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is also<write-mime-type-finish>
  {
    clear_error;
    my $rv = so gdk_content_provider_write_mime_type_finish(
      $!gdk-cp,
      $result,
      $error
    );
    set_error($error);
    $rv;
  }

}
