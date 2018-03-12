  #########################################################################################################
  ###													###
  ###   					Guardar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventSaveTopology {} {
    global controller
    global panel
    global notification
    
    set fileName [$panel.ent get]
    set result [$controller action SA_saveTopology $fileName]

    $notification.txt insert end "Evento guardar topologia:\n"
    
    if {$result == 1} {
      $notification.txt insert end "Guardado archivo con exito: $fileName en carpeta 'save'\n"
    } else {
      $notification.txt insert end "Error: No se ha podido guardar el estado\n"
    }
    $notification.txt see end
  }
  
  proc windowSaveTopology {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del archivo:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Guardar topologia" -command "eventSaveTopology"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }