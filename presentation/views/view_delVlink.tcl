  #########################################################################################################
  ###													###
  ###   					Eliminar vLink						### 
  ###													###
  #########################################################################################################
  
  proc eventDelVlink {} {
    global controller
    global panel
    global notification
    
    set vlink [$panel.ent get]
    set result [$controller action SA_delVlink $vlink]

    $notification.txt insert end "Evento eliminar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el vLink: $vlink\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el vLink\n"
    }
    $notification.txt see end
  }
    
  proc windowDelVlink {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del conector:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar vLink" -command "eventDelVlink"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }  