use v6.c;

use Method::Also;

use GLib::Raw::Traits;
use GDK::Raw::Types:ver<4>;
use GDK::Raw::VulkanContext:ver<4>;

use GLib::Roles::Implementor;
use GLib::Roles::Object;

our subset GdkVulkanContextAncestry is export of Mu
  where GdkVulkanContext | GObject;

class GDK::VulkanContext:ver<4> {
  also does GLib::Roles::Object;

  has GdkVulkanContext $!gdk-vc is implementor;

  submethod BUILD ( :$gdk-vulkan-context ) {
    self.setGdkVulkanContext($gdk-vulkan-context) if $gdk-vulkan-context;
  }

  method setGdkVulkanContext (GdkVulkanContextAncestry $_) {
    my $to-parent;

    $!gdk-vc = do {
      when GdkVulkanContext {
        $to-parent = cast(GObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(GdkVulkanContext, $_);
      }
    }
    self!setObject($to-parent);
  }

  method GDK::Raw::Definitions::GdkVulkanContext
    is also<GdkVulkanContext>
  { $!gdk-vc }

  multi method new (
    GdkVulkanContextAncestry  $gdk-vulkan-context,
                             :$ref = True
  ) {
    return unless $gdk-vulkan-context;

    my $o = self.bless( :$gdk-vulkan-context );
    $o.ref if $ref;
    $o;
  }

  method images-updated is also<images_updated> {
    self.connect($!gdk-vc, 'images-updated');
  }

  method error_quark is static is also<error-quark> {
    gdk_vulkan_error_quark();
  }

  # method gdk_vulkan_strerror {
  #   gdk_vulkan_strerror($!gdk-vc);
  # }

  method get_device is also<get-device> {
    gdk_vulkan_context_get_device($!gdk-vc);
  }

  method get_draw_index is also<get-draw-index> {
    gdk_vulkan_context_get_draw_index($!gdk-vc);
  }

  method get_draw_semaphore is also<get-draw-semaphore> {
    gdk_vulkan_context_get_draw_semaphore($!gdk-vc);
  }

  method get_image (Int() $id) is also<get-image> {
    my guint $i = $id;

    gdk_vulkan_context_get_image($!gdk-vc, $i);
  }

  method get_image_format is also<get-image-format> {
    gdk_vulkan_context_get_image_format($!gdk-vc);
  }

  method get_instance is also<get-instance> {
    gdk_vulkan_context_get_instance($!gdk-vc);
  }

  method get_n_images is also<get-n-images> {
    gdk_vulkan_context_get_n_images($!gdk-vc);
  }

  method get_physical_device is also<get-physical-device> {
    gdk_vulkan_context_get_physical_device($!gdk-vc);
  }

  method get_queue is also<get-queue> {
    gdk_vulkan_context_get_queue($!gdk-vc);
  }

  method get_queue_family_index is also<get-queue-family-index> {
    gdk_vulkan_context_get_queue_family_index($!gdk-vc);
  }

  method get_type is also<get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &gdk_vulkan_context_get_type, $n, $t );
  }

}
