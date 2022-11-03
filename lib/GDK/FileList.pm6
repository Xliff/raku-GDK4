use v6.c;

use Method::Also;
use NativeCall;

use GDK::Raw::Types:ver<4>;
use GDK::Raw::Content::Formats:ver<4>;

use GLib::GSList;

use GLib::Roles::Implementor;

class GDK::FileList {
  has GdkFileList $!gdk-fl is implementor;

  submethod BUILD ( :$gdk-file-list ) {
    $!gdk-fl = $gdk-file-list;
  }

  method GDK::Raw::Definitions::GdkFileList
    is also<GdkFileList>
  { $!gdk-fl }

  proto method new_from_array (|)
    is also<new-from-array>
  { * }

  multi method new_from_array (@files) {
    @files .= map({
      when    IO::Path | Str { GLib::File.new_for_path($_); proceed }
      when    .^can('GFile') { .GFile }
      when    GFile          { $_     }

      default {
        die 'Elements in @files is not GFile-compatible'
      }
    });

    my $fa = newCArray( Pointer[GFile] );
    $fa[ .key ] = cast(Pointer[GFile], .value) for @files.pairs;
    samewith($fa, @files.elems);
  }
  multi method new_from_array (
    CArray[Pointer[GFile]] $files,
    Int()                  $n_files
  ) {
    my gsize $n = $n_files;

    my $gdk-file-list = gdk_file_list_new_from_array($files, $n);

    $gdk-file-list ?? self.bless( :$gdk-file-list ) !! Nil
  }

  method new_from_list (GSList() $files)is also<new-from-list> {
    my $gdk-file-list = gdk_file_list_new_from_list($files);

    $gdk-file-list ?? self.bless( :$gdk-file-list ) !! Nil
  }

  method get_files ( :$raw = False, :$glist = False ) is also<get-files> {
    returnGSList(
      gdk_file_list_get_files($!gdk-fl),
      $raw,
      $glist,
      |GIO::GFile.getTypePair
    );
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_file_list_get_type, $n, $t );
  }

}
