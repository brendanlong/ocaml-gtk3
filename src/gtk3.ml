open Printf

module Types = Gtk3_bindings.Ffi_bindings.Types(Ffi_generated_types)
module Bindings = Gtk3_bindings.Ffi_bindings.Bindings(Ffi_generated)

let init () =
  let n = Ctypes.(allocate int 0) in
  Bindings.init n None

module Window = struct
  module Type = struct
    type t =
      | Toplevel
      | Popup

    let of_int n =
      let open Types.Window.Type in
      if n = toplevel then Toplevel
      else if n = popup then Popup
      else failwith (sprintf "Unrecognized GtkWindowType %d" n)

    let to_int t =
      let open Types.Window.Type in
      match t with
      | Toplevel -> toplevel
      | Popup -> popup
  end

  type t = unit Ctypes.ptr

  let make type_ =
    Type.to_int type_
    |> Bindings.Window.make
end