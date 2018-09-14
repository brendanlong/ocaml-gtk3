module Types(F : Cstubs.Types.TYPE) = struct
  module Window = struct
    module Type = struct
      let toplevel = F.constant "GTK_WINDOW_TOPLEVEL" F.int
      let popup = F.constant "GTK_WINDOW_POPUP" F.int
    end
  end
end

module Bindings (F : Cstubs.FOREIGN) = struct
  let foreign = F.foreign

  module Foreign = struct
    include Ctypes
    include Foreign
  end
  module Ctypes = struct
    include Ctypes

    let (@->)         = F.(@->)
    let returning     = F.returning
    let foreign       = F.foreign
    let foreign_value = F.foreign_value
  end

  let init = foreign "gtk_init"
      Ctypes.(ptr int @-> ptr_opt void @-> returning void)

  module Object = struct
    let t = Ctypes.(ptr void)

    let unref = foreign "g_object_unref"
        Ctypes.(t @-> returning void)
  end

  module Widget = struct
    let t = Ctypes.(ptr void)
  end

  module Window = struct
    let t = Ctypes.(ptr void)

    let make = foreign "gtk_window_new"
        Ctypes.(int @-> returning t)
  end
end