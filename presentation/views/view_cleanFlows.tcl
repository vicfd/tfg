  #########################################################################################################
  ###													###
  ###   					Limpiar flujos						### 
  ###													###
  #########################################################################################################
  
  proc eventCleanFlows {} {
    global controller
    global panel
    global notification
    
    set bridge [$panel.ent get]
    set result [$controller action SA_cleanFlows $bridge]

    $notification.txt insert end "Evento limpiar flujos:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado controles de flujo de: $bridge\n"
    } else {
      $notification.txt insert end "Error: No se han podido eliminar\n"
    } 
    $notification.txt see end
  }
    
  proc windowCleanFlows {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Limpiar flujos" -command "eventCleanFlows"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }