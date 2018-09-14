module Ffi_bindings = Gtk3_bindings.Ffi_bindings

let prefix = "gtk3_stub"

let prologue = "
#include <gtk/gtk.h>
"

let () =
  print_endline prologue;
  Cstubs.Types.write_c Format.std_formatter (module Ffi_bindings.Types)
