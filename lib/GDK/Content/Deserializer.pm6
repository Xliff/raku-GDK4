use v6.c;

use Method::Also;
use NativeCall;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::Content::Deserializer:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkContentDeserializerAncestry is export of Mu
  where GdkContentDeserializer | GObject;

class GDK::Content::Deserializer:ver<4> {
  also does GLib::Roles::Object;

  has GdkContentDeserializer $!gdk-cd is implementor;

  submethod BUILD ( :$gdk-deserializer ) {
    self.setGdkContentDeserializer($gdk-deserializer) if $gdk-deserializer
  }

  method setGdkContentDeserializer (GdkContentDeserializerAncestry $_) {
    my $to-parent;

    $!gdk-cd = do {
      when GdkContentDeserializer {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkContentDeserializer, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkContentDeserializer
  { $!gdk-cd }

  multi method new (
    GdkContentDeserializerAncestry  $gdk-deserializer,
                                   :$ref               = True
  ) {
    return unless $gdk-deserializer;

    my $o = self.bless( :$gdk-deserializer );
    $o.ref if $ref;
    $o;
  }

  proto method deserialize_async (|)
    is also<deserialize-async>
    is static
  { * }

  multi method deserialize_async (
    GInputStream()       $stream,
    Str()                $mime_type,
    Int()                $type,
                         &callback,
    gpointer             $user_data   = gpointer,
    Int()               :$io_priority = G_PRIORITY_DEFAULT,
    GCancellable()      :$cancellable = GCancellable
  ) {
    samewith(
      $stream,
      $mime_type,
      $type,
      $io_priority,
      $cancellable,
      &callback,
      $user_data
    );
  }
  multi method deserialize_async (
    GInputStream()      $stream,
    Str()               $mime_type,
    Int()               $type,
    Int()               $io_priority,
    GCancellable()      $cancellable,
                        &callback,
    gpointer            $user_data     = gpointer
  ) {
    my GType $t = $type;
    my gint  $i = $io_priority;

    gdk_content_deserialize_async(
      $stream,
      $mime_type,
      $t,
      $i,
      $cancellable,
      &callback,
      $user_data
    );
  }

  method deserialize_finish (
    GAsyncResult()          $result,
    GValue()                $value,
    CArray[Pointer[GError]] $error  = gerror
  )
    is static

    is also<deserialize-finish>
  {
    clear_error;
    my $rv = gdk_content_deserialize_finish($result, $value, $error);
    set_error($error);
    $rv;
  }

  method register_deserializer (
    Str()    $mime_type,
    Int()    $type,
             &deserialize,
    gpointer $data         = gpointer,
             &notify       = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<register-deserializer>
  {
    my GType $t = $type;

    gdk_content_register_deserializer(
      $!gdk-cd,
      $t,
      &deserialize,
      $data,
      &notify
    );
  }

  method get_cancellable ( :$raw = False )
    is also<
      get-cancellable
      cancellable
    >
  {
    propReturnObject(
      gdk_content_deserializer_get_cancellable($!gdk-cd),
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
    gdk_content_deserializer_get_gtype($!gdk-cd);
  }

  method get_input_stream ( :$raw = False )
    is also<
      get-input-stream
      input_stream
      input-stream
    >
  {
    propReturnObject(
      gdk_content_deserializer_get_input_stream($!gdk-cd),
      $raw,
      |GIO::InputStream.getTypePair
    );
  }

  method get_mime_type
    is also<
      get-mime-type
      mime_type
      mime-type
    >
  {
    gdk_content_deserializer_get_mime_type($!gdk-cd);
  }

  method get_priority ( :$enum = True )
    is also<
      get-priority
      priority
    >
  {
    my $p = gdk_content_deserializer_get_priority($!gdk-cd);
    return $p unless $enum;
    GPriorityEnum($p)
  }

  method get_task_data
    is also<
      get-task-data
      task_data
      task-data
    >
  {
    gdk_content_deserializer_get_task_data($!gdk-cd);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type(
      self.^name,
      &gdk_content_deserializer_get_type,
      $n,
      $t
    );
  }

  method get_user_data
    is also<
      get-user-data
      user_data
      user-data
    >
  {
    gdk_content_deserializer_get_user_data($!gdk-cd);
  }

  method get_value ( :$raw = False ) is also<get-value> {
    propReturnObject(
      gdk_content_deserializer_get_value($!gdk-cd),
      $raw,
      |GLib::Value.getTypePair
    );
  }

  method return_error (GError() $error) is also<return-error> {
    gdk_content_deserializer_return_error($!gdk-cd, $error);
  }

  method return_success is also<return-success> {
    gdk_content_deserializer_return_success($!gdk-cd);
  }

  method set_task_data (
    gpointer $data,
             &notify = %DEFAULT-CALLBACKS<GDestroyNotify>
  )
    is also<set-task-data>
  {
    gdk_content_deserializer_set_task_data($!gdk-cd, $data, &notify);
  }

}
