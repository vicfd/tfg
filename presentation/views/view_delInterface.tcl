  #########################################################################################################
  ###													###
  ###   					Eliminar interfaz					### 
  ###													###
  #########################################################################################################
  
  proc eventDelInterface {} {
    global controller
    global panel
    global notification
    
    set interface [$panel.ent get]
    set result [$controller action SA_delInterface $interface]

    $notification.txt insert end "Evento eliminar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el interfaz: $interface\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el interfaz\n"
    }
    $notification.txt see end
  }
    
  proc windowDelInterface {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del interfaz:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar interfaz" -command "eventDelInterface"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }