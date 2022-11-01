use v6.c;

unit package GDK::Raw::Exports:ver<4>;

our @gdk4-exports is export;

BEGIN {
  @gdk4-exports = <
    Cairo
    GDK::Raw::Definitions
    GDK::Raw::Enums
    GDK::Raw::Structs
    GDK::Raw::Subs
  >;
}
