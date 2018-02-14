source negocio/negocioTopologia.tcl

oo::class create controlador {
    constructor {} {
		my variable negocioTopologia
		set negocioTopologia [negocioTopologia new]
    }

    method action {event data} {
		global S
		my variable negocioTopologia

		switch $event {
			SA_addBridge {
				set result [$negocioTopologia addBridge $data]
				if {$result == 1} {
					puts "Agregado con exito el bridge"
				} else {
					puts "No se ha podido agregar el bridge"
				}
			}
			SA_addInterface {
				set result [$negocioTopologia addInterface $data]
				if {$result == 1} {
					puts "Agregado con exito el interfaz"
				} else {
					puts "No se ha podido agregar el interfaz"
				}
			}
			SA_delBridge {
				set result [$negocioTopologia delBridge $data]
				if {$result == 1} {
					puts "Eliminado con exito el bridge"
				} else {
					puts "No se ha podido eliminar el bridge"
				}
			}
			SA_delInterface {
				set result [$negocioTopologia delInterface $data]
				if {$result == 1} {
					puts "Eliminado con exito el interfaz"
				} else {
					puts "No se ha podido eliminar el interfaz"
				}
			}
			SA_addVlink {
				upvar $data val
				set result [$negocioTopologia addVlink $val(from) $val(to)]
				if {$result == 1} {
					puts "Creado con exito enlace"
				} else {
					puts "No se ha podido crear el enlace"
				}
			}
			SA_delVlink {
				set result [$negocioTopologia delVlink $data]
				if {$result == 1} {
					puts "Eliminado con exito enlace"
				} else {
					puts "No se ha podido eliminar el enlace"
				}
			}
			default {
				puts "evento por defecto: $evento"
			}
		}
    }
}

