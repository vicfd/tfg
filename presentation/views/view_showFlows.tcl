  #########################################################################################################
  ###													###
  ###   					Mostrar flujo						### 
  ###													###
  #########################################################################################################
  
  proc eventShowFlows {} {
    global controller
    global panel
    global notification
    
    set bridge [$panel.ent get]
    set result [$controller action SA_showFlows $bridge]

    $notification.txt insert end "Evento mostrar flujo $bridge:\n"
    
    if {$result == 0} {
      $notification.txt insert end "No existe el bridge\n"
    } else {
      $notification.txt insert end "$result\n"
    }
    $notification.txt see end
  }
  
    proc windowShowFlows {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Mostrar flujo" -command "eventShowFlows"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }