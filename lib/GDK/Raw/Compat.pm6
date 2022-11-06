use v6.c;

use NativeCall;

unit package GDK::Raw::Compat:ver<4>;

constant cairo_content_t is export := Pointer;
constant cairo_region_t  is export := Pointer;

# Vulkan types
constant VkDevice         is export := Pointer;
constant VkFormat         is export := Pointer;
constant VkImage          is export := Pointer;
constant VkInstance       is export := Pointer;
constant VkPhysicalDevice is export := Pointer;
constant VkQueue          is export := Pointer;
constant VkResult         is export := Pointer;
constant VkSemaphore      is export := Pointer;
