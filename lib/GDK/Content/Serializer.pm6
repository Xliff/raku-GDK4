use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Content::Serializer:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkContentSerializerAncestry is export of Mu
  where GdkContentSerializer | GObject;

class GDK::Content::Serializer:ver<4> {
  also does GLib::Roles::Object;

  has GdkContentSerializer $!gdk-cs is implementor;

  submethod BUILD ( :$gdk-serializer ) {
    self.setGdkContentSerializer($gdk-serializer) if $gdk-serializer
  }

  method setGdkContentSerializer (GdkContentSerializerAncestry $_) {
    my $to-parent;

    $!gdk-cs = do {
      when GdkContentSerializer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkContentSerializer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkContentSerializer
    is also<GdkContentSerializer>
  { $!gdk-cs }

  multi method new (
    GdkContentSerializerAncestry  $gdk-serializer,
                                 :$ref             = True
  ) {
    return unless $gdk-serializer;

    my $o = self.bless( :$gdk-serializer );
    $o.ref if $ref;
    $o;
  }

  method register_serializer (
    Int()    $gtype,
    Str()    $mime_type,
             &serialize,
    gpointer $data       = gpointer,
             &notify     = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is static
    is also<register-serializer>
  {
    my GType $g = $gtype;

    gdk_content_register_serializer(
      $g,
      $mime_type,
      &serialize,
      $data,
      &notify
    );
  }

  proto method serialize_async (|)
    is also<serialize-async>
    is static
  { * }

  multi method serialize_async (
    GOutputStream()      $stream,
    Str()                $mime_type,
    GValue()             $value,
                         &callback,
    gpointer             $user_data   = gpointer,
    GCancellable()      :$cancellable = GCancellable,
    Int()               :$io_priority = G_PRIORITY_DEFAULT
  ) {
    samewith(
      $stream,
      $mime_type,
      $value,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    )
  }
  multi method serialize_async (
    GOutputStream()     $stream,
    Str()               $mime_type,
    GValue()            $value,
    Int()               $io_priority,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data    = gpointer
  ) {
    my gint $i = $io_priority;

    gdk_content_serialize_async(
      $stream,
      $mime_type,
      $value,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method serialize_finish (
    GAsyncResult()          $result,
    CArray[Pointer[GError]] $error   = gerror
  )
    is static
    is also<serialize-finish>
  {
    clear_error;
    my $rv = so gdk_content_serialize_finish($result, $error);
    set_error($error);
    $rv;
  }

  method get_cancellable ( :$raw = False )
    is also<
      get-cancellable
      cancellable
    >
  {
    propReturnObject(
      gdk_content_serializer_get_cancellable($!gdk-cs),
      $raw,
      |GIO::Cancellable.getTypePair
    );
  }

  method get_gtype
    is also<
      get-gtype
      gtype
    >
  {
    gdk_content_serializer_get_gtype($!gdk-cs);
  }

  method get_mime_type
    is also<
      get-mime-type
      mime_type
      mime-type
    >
  {
    gdk_content_serializer_get_mime_type($!gdk-cs);
  }

  method get_output_stream ( :$raw = False )
    is also<
      get-output-stream
      output_stream
      output-stream
    >
  {
    propReturnObject(
      gdk_content_serializer_get_output_stream($!gdk-cs),
      $raw,
      |GIO::Cancellable.getTypePair
    );
  }

  method get_priority
    is also<
      get-priority
      priority
    >
  {
    gdk_content_serializer_get_priority($!gdk-cs);
  }

  method get_task_data
    is also<
      get-task-data
      task_data
      task-data
    >
  {
    gdk_content_serializer_get_task_data($!gdk-cs);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_content_serializer_get_type, $n, $t );
  }

  method get_user_data
    is also<
      get-user-data
      user_data
      user-data
    >
  {
    gdk_content_serializer_get_user_data($!gdk-cs);
  }

  method get_value ( :$raw = False )
    is also<
      get-value
      value
    >
  {
    propReturnObject(
      gdk_content_serializer_get_value($!gdk-cs),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method return_error (GError() $error = GError.new) is also<return-error> {
    gdk_content_serializer_return_error($!gdk-cs, $error);
  }

  method return_success is also<return-success> {
    gdk_content_serializer_return_success($!gdk-cs);
  }

  method set_task_data (
    gpointer $data,
             &notify = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-task-data>
  {
    gdk_content_serializer_set_task_data($!gdk-cs, $data, &notify);
  }

}
