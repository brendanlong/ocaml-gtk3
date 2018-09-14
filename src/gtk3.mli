open Ctypes

val init : unit-> unit

module Window : sig
  module Type : sig
    type t =
      | Toplevel
      | Popup
  end
  type t

  val make : Type.t -> t
end