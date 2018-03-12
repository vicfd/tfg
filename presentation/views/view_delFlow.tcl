  #########################################################################################################
  ###													###
  ###   					Eliminar flujo						### 
  ###													###
  #########################################################################################################
  
  proc eventDelFlow {} {
    global controller
    global panel
    global notification
    
    set data(bridge) [$panel.ent1 get]
    set data(flow) [$panel.ent2 get]
    set result [$controller action SA_delFlow data]

    $notification.txt insert end "Evento eliminar flujo:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el flujo a bridge $data(bridge)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el flujo\n"
    }
    $notification.txt see end
  }
    
  proc windowDelFlow {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent1 -width 50
    label $panel.lab2 -text "Flujo:" -width 50
    entry $panel.ent2 -width 50
    button $panel.but -text "Eliminar flujo" -command "eventDelFlow"
    
    pack $panel.lab1
    pack $panel.ent1
    pack $panel.lab2
    pack $panel.ent2
    pack $panel.but
    pack $panel
  }