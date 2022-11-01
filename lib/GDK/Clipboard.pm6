use v6.c;

use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Clipboard:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkClipboardAncestry is export of Mu
  where GdkClipboard | GObject;

class GDK::Clipboard:ver<4> {
  also does GLib::Roles::Object;

  has GdkClipboard $!gdk-c is implementor;

  submethod BUILD ( :$gdk-clipboard ) {
    self.setGdkClipboard($gdk-clipboard) if $gdk-clipboard
  }

  method setGdkClipboard (GdkClipboardAncestry $_) {
    my $to-parent;

    $!gdk-c = do {
      when GdkClipboard {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkClipboard, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkClipboard
  { $!gdk-c }

  multi method new (GdkClipboardAncestry $gdk-clipboard, :$ref = True) {
    return unless $gdk-clipboard;

    my $o = self.bless( :$gdk-clipboard );
    $o.ref if $ref;
    $o;
  }

  # Type: GDKDisplay
  method display ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::Display').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('display', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::Display').getTypePair
        );
      },
      STORE => -> $, GdkDisplay() $val is copy {
        $gv.object = $val;
        self.prop_set('display', $gv);
      }
    );
  }

  # Type: GDKContentFormats
  method formats ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::ContentFormats').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('formats', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::ContentFormats').getTypePair
        );
      },
      STORE => -> $,  $val is copy {
        warn 'formats does not allow writing'
      }
    );
  }

  # Type: boolean
  method local is rw  is g-property {
    my $gv = GLib::Value.new( G_TYPE_BOOLEAN );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('local', $gv);
        $gv.boolean;
      },
      STORE => -> $, Int() $val is copy {
        warn 'local does not allow writing'
      }
    );
  }

  # Type: GDKContentProvider
  method content ( :$raw = False ) is rw  is g-property {
    my $gv = GLib::Value.new( ::('GDK::ContentProvider').get_type );
    Proxy.new(
      FETCH => sub ($) {
        self.prop_get('content', $gv);
        propReturnObject(
          $gv.object,
          $raw,
          |::('GDK::ContentProvider').getTypePair
        )
      },
      STORE => -> $,  $val is copy {
        warn 'content does not allow writing'
      }
    );
  }

  method get_content ( :$raw = False ) {
    propReturnObject(
      gdk_clipboard_get_content($!gdk-c),
      $raw,
      |::('GDK::Content::Provider').getTypePair
    );
  }

  method get_display ( :$raw = False ) {
    propReturnObject(
      gdk_clipboard_get_display($!gdk-c),
      $raw,
      |::('GDK::Display').getTypePair
    );
  }

  method get_formats {
    gdk_clipboard_get_formats($!gdk-c);
  }

  method get_type {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_clipboard_get_type, $n, $t );
  }

  method is_local {
    so gdk_clipboard_is_local($!gdk-c);
  }

  proto method read_async (|)
  { * }

  multi method read_async (
                    @mime_types,
                    &callback,
    gpointer        $user_data   = gpointer,
    Int()          :pri(
                     :priority(
                       :io-priority(:$io_priority)
                     )
                   )             = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith(
      ArrayToCArray(Str, @mime_types),
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method read_async (
    CArray[Str]         $mime_types,
    gint                $io_priority,
    GCancellable        $cancellable,
                        &callback,
    gpointer            $user_data    = gpointer
  ) {
    my gint $i = $io_priority;

    gdk_clipboard_read_async(
      $!gdk-c,
      $mime_types,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  proto method read_finish (|)
  { * }

  multi method read_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror,
  ) {
    samewith($result, newCArray(Str), $error);
  }
  multi method read_finish (
    GAsyncResult()           $result,
    CArray[Str]              $out_mime_type,
    CArray[Pointer[GError]]  $error,
                            :$raw            = False
  ) {
    my $is = propReturnObject(
      gdk_clipboard_read_finish(
        $!gdk-c,
        $result,
        $out_mime_type,
        $error
      ),
      $raw,
      |GIO::InputStream.getTypePair
    );
    ( $is, $out_mime_type[0] )
  }

  proto method read_text_async (|)
  { * }

  multi method read_text_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method read_text_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gdk_clipboard_read_text_async($!gdk-c, $cancellable, &callback, $user_data);
  }

  method read_text_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = gdk_clipboard_read_text_finish($!gdk-c, $result, $error);
    set_error($error);
    $rv;
  }

  proto method read_texture_async (|)
  { * }

  multi method read_texture_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    GCancellable() :$cancellable = GCancellable
  ) {
    samewith($cancellable, &callback, $user_data);
  }
  multi method read_texture_async (
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    gdk_clipboard_read_texture_async(
      $!gdk-c,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_texture_finish (
    GAsyncResult()           $result,
    CArray[Pointer[GError]]  $error   = gerror,
                            :$raw     = False
  ) {
    clear_error;
    my $rv = gdk_clipboard_read_texture_finish($!gdk-c, $result, $error);
    set_error($error);

    propReturnObject(
      $rv,
      $raw,
      |::('GDK::Texture').getTypePair
    );
  }

  proto method read_value_async (|)
  { * }

  multi method read_value_async (
    Int()                $type,
                         &callback,
    gpointer             $user_data,
    Int()               :pri(
                           :priority(
                             :io-priority(:$io_priority)
                           )
                         )            = G_PRIORITY_DEFAULT,
    GCancellable()      :$cancellable = GCancellable
  ) {
    samewith($type, $io_priority, $cancellable, &callback, $user_data)
  }
  multi method read_value_async (
    Int()               $type,
    Int()               $io_priority,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data
  ) {
    my GType $t = $type;
    my gint  $i = $io_priority;

    gdk_clipboard_read_value_async(
      $!gdk-c,
      $t,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method read_value_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so gdk_clipboard_read_value_finish($!gdk-c, $result, $error);
    set_error($error);
    $rv;
  }

  method set (Int() $type) {
    my GType $t = $type;

    gdk_clipboard_set($!gdk-c, $t);
  }

  method set_content (GdkContentProvider() $provider) {
    gdk_clipboard_set_content($!gdk-c, $provider);
  }

  method set_text (Str() $text) {
    gdk_clipboard_set_text($!gdk-c, $text);
  }

  method set_texture (GdkTexture() $texture) {
    gdk_clipboard_set_texture($!gdk-c, $texture);
  }

  method set_value (GValue() $value) {
    gdk_clipboard_set_value($!gdk-c, $value);
  }

  proto method store_async (|)
  { * }

  multi method store_async (
                    &callback,
    gpointer        $user_data   = gpointer,
    Int()          :pri(
                      :priority(
                        :io-priority(:$io_priority)
                      )
                    )            = G_PRIORITY_DEFAULT,
    GCancellable() :$cancellable = GCancellable
  ) {
    my gint $i = $io_priority;

    samewith($i, $cancellable, &callback, $user_data)
  }
  multi method store_async (
    Int()          $io_priority,
    GCancellable() $cancellable,
                   &callback,
    gpointer       $user_data    = gpointer
  ) {
    my gint $i = $io_priority;

    gdk_clipboard_store_async(
      $!gdk-c,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method store_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  ) {
    clear_error;
    my $rv = so gdk_clipboard_store_finish($!gdk-c, $result, $error);
    set_error($error);
    $rv;
  }

}
