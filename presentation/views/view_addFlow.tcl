  #########################################################################################################
  ###													###
  ###   					Agregar flujo						### 
  ###													###
  #########################################################################################################
  
  proc eventAddFlow {} {
    global controller
    global panel
    global notification
    
    set data(bridge) [$panel.ent1 get]
    set data(flow) [$panel.ent2 get]
    set result [$controller action SA_addFlow data]

    $notification.txt insert end "Evento agregar flujo:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el flujo a bridge $data(bridge)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el flujo\n"
    }
    $notification.txt see end
  }
    
  proc windowAddFlow {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent1 -width 50
    label $panel.lab2 -text "Flujo:" -width 50
    entry $panel.ent2 -width 50
    button $panel.but -text "Crear flujo" -command "eventAddFlow"
    
    pack $panel.lab1
    pack $panel.ent1
    pack $panel.lab2
    pack $panel.ent2
    pack $panel.but
    pack $panel
  }