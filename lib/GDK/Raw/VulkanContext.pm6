use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GDK::Raw::Compat:ver<4>;
use GDK::Raw::Definitions:ver<4>;

unit package GDK::Raw::VulkanContext:ver<4>;

### /usr/src/gtk4-4.8.1+ds/gdk/gdkvulkancontext.h

sub gdk_vulkan_error_quark
  returns GQuark
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_strerror (VkResult $result)
  returns Str
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_device (GdkVulkanContext $context)
  returns VkDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_draw_index (GdkVulkanContext $context)
  returns uint32_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_draw_semaphore (GdkVulkanContext $context)
  returns VkSemaphore
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_image (
  GdkVulkanContext $context,
  guint            $id
)
  returns VkImage
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_image_format (GdkVulkanContext $context)
  returns VkFormat
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_instance (GdkVulkanContext $context)
  returns VkInstance
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_n_images (GdkVulkanContext $context)
  returns uint32_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_physical_device (GdkVulkanContext $context)
  returns VkPhysicalDevice
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_queue (GdkVulkanContext $context)
  returns VkQueue
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_queue_family_index (GdkVulkanContext $context)
  returns uint32_t
  is      native(gdk4)
  is      export
{ * }

sub gdk_vulkan_context_get_type
  returns GType
  is      native(gdk4)
  is      export
{ * }
