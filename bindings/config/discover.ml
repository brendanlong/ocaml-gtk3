open Base
open Stdio
module C = Configurator

let write_sexp fn sexp =
  Out_channel.write_all fn ~data:(Sexp.to_string sexp)

let () =
  C.main ~name:"gtk3" @@ fun c ->
  let default : C.Pkg_config.package_conf =
    { libs = [ "-lgtk-3" ; "-lgdk-3" ; "-lpangocairo-1.0" ; "-lpango-1.0"
             ; "-latk-1.0" ; "-lcairo-gobject" ; "-lcairo"
             ; "-lgdk_pixbuf-2.0" ; "-lgio-2.0" ; "-lgobject-2.0"
             ; "-lglib-2.0o" ]
    ; cflags = [] }
  in
  let conf =
    match C.Pkg_config.get c with
    | None -> default
    | Some pc ->
      Option.value (C.Pkg_config.query pc ~package:"gtk+-3.0") ~default
  in

  write_sexp "gtk+-3.0-cclib.sexp" [%sexp (conf.libs   : string list)];
  write_sexp "gtk+-3.0-ccopt.sexp" [%sexp (conf.cflags : string list)];
  Out_channel.write_all "gtk+-3.0-cclib" ~data:(String.concat conf.libs   ~sep:" ");
  Out_channel.write_all "gtk+-3.0-ccopt" ~data:(String.concat conf.cflags ~sep:" ")
