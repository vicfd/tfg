  #########################################################################################################
  ###													###
  ###   					Agregar interfaz					### 
  ###													###
  #########################################################################################################
  
  proc eventAddInterface {} {
    global controller
    global panel
    global notification
    
    set interface [$panel.ent get]
    set result [$controller action SA_addInterface $interface]

    $notification.txt insert end "Evento agregar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el interfaz: $interface\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el interfaz\n"
    }
    $notification.txt see end
  }
    
  proc windowAddInterface {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del interfaz:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Crear interfaz" -command "eventAddInterface"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }