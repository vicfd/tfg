  #########################################################################################################
  ###													###
  ###   					Guardar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventSaveFlows {} {
    global controller
    global panel
    global notification    
  
    set data(bridge) [$panel.ent get]
    set data(fileName) [tk_getSaveFile]
    $panel.lab2 configure -text $data(fileName)
    set result [$controller action SA_saveFlows data]
    
    $notification.txt insert end "Evento guardar control:\n"
    
    if {$result == 1} {
      $notification.txt insert end "Guardado archivo con exito: $data(fileName).ncovs\n"
    } else {
      $notification.txt insert end "Error: No se ha podido guardar el estado\n"
    }
    $notification.txt see end    
  }
  
  proc windowSaveFlows {} {
    global panel
    set panel [frame .panel]
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50    
    label $panel.lab2 -text "No File"
    button $panel.but -text "Guardar flujo" -command "eventSaveFlows"

    grid $panel.lab1 -row 0 -column 0
    grid $panel.ent -row 1 -column 0
    grid $panel.but -row 2 -column 0
    grid $panel.lab2 -row 3 -column 0
    pack $panel
  }