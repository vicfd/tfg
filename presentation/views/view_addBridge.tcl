  #########################################################################################################
  ###													###
  ###   					Agregar bridge						### 
  ###													###
  #########################################################################################################
  
  proc eventAddBridge {} {
    global controller
    global panel
    global notification
    
    set bridge [$panel.ent get]
    set result [$controller action SA_addBridge $bridge]

    $notification.txt insert end "Evento agregar bridge:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el bridge: $bridge\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el bridge\n"
    } 
    $notification.txt see end
  }
    
  proc windowAddBridge {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Crear bridge" -command "eventAddBridge"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }