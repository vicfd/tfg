  #########################################################################################################
  ###													###
  ###   					Mostrar información					### 
  ###													###
  #########################################################################################################
  
  proc eventShowInfo {} {
    global controller
    global notification
    
    set result [$controller action SA_showInfo null]

    $notification.txt insert end "Evento mostrar puentes:\n"
    if {[string length $result] > 0} {
      $notification.txt insert end "$result\n"
    } else {
      $notification.txt insert end "No hay ningun puente\n"
    }
    $notification.txt see end
  }