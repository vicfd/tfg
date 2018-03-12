  #########################################################################################################
  ###													###
  ###   					Agregar vLink						### 
  ###													###
  #########################################################################################################
  
  proc eventAddVlink {} {
    global controller
    global panel
    global notification
    
    set data(from) [$panel.ent1 get]
    set data(to) [$panel.ent2 get]
    set result [$controller action SA_addVlink data]

    $notification.txt insert end "Evento agregar vLink:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el vLink de $data(from) a $data(to)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el vLink\n"
    }
    $notification.txt see end
  }
    
  proc windowAddVlink {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab1 -text "Nombre del primer conector:" -width 50
    entry $panel.ent1 -width 50
    label $panel.lab2 -text "Nombre del segundo conector:" -width 50
    entry $panel.ent2 -width 50
    button $panel.but -text "Crear vLink" -command "eventAddVlink"
    
    pack $panel.lab1
    pack $panel.ent1
    pack $panel.lab2
    pack $panel.ent2
    pack $panel.but
    pack $panel
  }