  #########################################################################################################
  ###													###
  ###   					Agregar puerto						### 
  ###													###
  #########################################################################################################
  
  proc eventAddPort {} {
    global controller
    global panel
    global notification
    
    set data(from) [$panel.ent1 get]
    set data(to) [$panel.ent2 get]
    set result [$controller action SA_addPort data]

    $notification.txt insert end "Evento agregar puerto:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el puerto de $data(to) a $data(from)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el puerto\n"
    }
    $notification.txt see end
  }
    
  proc windowAddPort {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent1 -width 50
    label $panel.lab2 -text "Nombre del elemento a conectar:" -width 50
    entry $panel.ent2 -width 50
    button $panel.but -text "Crear puerto" -command "eventAddPort"
    
    pack $panel.lab1
    pack $panel.ent1
    pack $panel.lab2
    pack $panel.ent2
    pack $panel.but
    pack $panel
  }