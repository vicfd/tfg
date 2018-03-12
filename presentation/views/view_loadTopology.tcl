  #########################################################################################################
  ###													###
  ###   					Cargar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventLoadTopology {} {
    global controller
    global panel
    global notification    
    
    set types {
      {"OpenVSwitch files" {.ncovs}}
    } 
  
    set fileName [tk_getOpenFile -filetypes $types -parent .]
    $panel.lab configure -text $fileName
    set result [$controller action SA_loadTopology $fileName]
    
    $notification.txt insert end "Evento cargar topologia:\n"
    
    if {$result == 1} {
      $notification.txt insert end "Cargado archivo con exito: $fileName\n"
    } else {
      $notification.txt insert end "Error: No se ha podido cargar el estado\n"
    }
    $notification.txt see end    
  }
  
  proc windowLoadTopology {} {
    global panel
    set panel [frame .panel]
    
    label $panel.lab -text "No File"
    button $panel.but -text "Seleccionar archivo" -command "eventLoadTopology"
    
    grid $panel.but -row 0 -column 0
    grid $panel.lab -row 0 -column 1
    pack $panel
  }