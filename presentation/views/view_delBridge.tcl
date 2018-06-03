  #########################################################################################################
  ###													###
  ###   					Eliminar bridge						### 
  ###													###
  #########################################################################################################
    
  proc eventDelBridge {} {
    global controller
    global panel
    global notification    
    
    set bridge [$panel.ent get]
    set resultado [$controller action SA_delBridge $bridge]

    $notification.txt insert end "Evento eliminar switch:\n"

    if {$resultado == 1} {
      $notification.txt insert end "Eliminado con exito el switch: $bridge\n"
    } else {
      $notification.txt insert end "Error: No se ha podido elimar el switch\n"
    }
    $notification.txt see end
  }

  proc windowDelBridge {} {
    global panel
    set panel [frame .panel]
    pack $panel
    
    label $panel.lab -text "Nombre del puente:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar puente" -command "eventDelBridge"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
  }