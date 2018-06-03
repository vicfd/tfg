  #########################################################################################################
  ###													###
  ###   					Cargar control 						### 
  ###													###
  #########################################################################################################
 
  proc eventLoadFlows {} {
    global controller
    global panel
    global notification    

    set types {
      {"OpenVSwitch files" {.ncovs}}
    }
    
    set data(bridge) [$panel.ent get]
    set data(fileName) [tk_getOpenFile -filetypes $types -parent .]
    $panel.lab2 configure -text $data(fileName)
    set result [$controller action SA_loadFlows data]
    
    $notification.txt insert end "Evento cargar control:\n"
    
    if {$result == 1} {
      $notification.txt insert end "Cargado archivo con exito: $data(fileName) en bridge: $data(bridge)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido cargar el estado\n"
    }
    $notification.txt see end    
  }
  
  proc windowLoadFlows {} {
    global panel
    set panel [frame .panel]
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50    
    label $panel.lab2 -text "No File"
    button $panel.but -text "Cargar control de flujo" -command "eventLoadFlows"

    grid $panel.lab1 -row 0 -column 0
    grid $panel.ent -row 1 -column 0
    grid $panel.but -row 2 -column 0
    grid $panel.lab2 -row 3 -column 0
    pack $panel
  }