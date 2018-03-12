  #########################################################################################################
  ###													###
  ###   					Limpiar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventCleanTopology {} {
    global controller
    global notification
    
    set result [$controller action SA_cleanTopology null]

    $notification.txt insert end "Evento limpiar topologia: realizado con exito\n"
    $notification.txt see end
  }

  proc WindowBridges {} {
    set frbridges [frame .panel]
    pack $frbridges

    set bridges [exec sudo ovs-vsctl list-br]

    foreach br $bridges {
	    button $frbridges.$br -text $br
	    pack $frbridges.$br -side top
    }
  }