
#addBridge
#addInterface 
#addVlink {from to}
#delBridge {bridge} 
#delInterface {interface}
#delVlink {from}

  #########################################################################################################
  ###													  ###
  ###   					Inicio grafico						  ### 
  ###													  ###
  #########################################################################################################

  proc init {} {
    global notification
    global panel
    #########################################################################################################
    ###													  ###
    ###   					Congiguracion general					  ### 
    ###												          ###
    #########################################################################################################

    wm title . "OpenVSwitch provisional"
    wm minsize . 800 300
    menu .menu -tearoff 0 
    wm geometry .menu 300x50
    
    
    #########################################################################################################
    ###													  ###
    ###   					Menu bridges						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.bridges
    menu $m -tearoff 0 
    .menu add cascade -label "Modulo topologia" -menu $m -underline 0 
    $m add command -label "Agregar puente" -command {destroy .panel; windowAddBridge}
    $m add command -label "Agregar interfaz" -command {destroy .panel; windowAddInterface}
    $m add command -label "Agregar puerto" -command {destroy .panel; windowAddPort}
    $m add command -label "Agregar vLink" -command {destroy .panel; windowAddVlink}
    $m add command -label "Eliminar puente" -command {destroy .panel; windowDelBridge}
    $m add command -label "Eliminar interfaz" -command {destroy .panel; windowDelInterface}
    $m add command -label "Eliminar puerto" -command {destroy .panel; windowDelPort}
    $m add command -label "Eliminar vLink" -command {destroy .panel; windowDelVlink}
    $m add command -label "Mostrar bridges" -command {eventShowInfo}
    $m add command -label "Guardar topologia" -command {destroy .panel; windowSaveTopology}
    $m add command -label "Cargar topologia" -command {destroy .panel; windowLoadTopology}
    $m add command -label "Limpiar topologia" -command {eventCleanTopology}

    #########################################################################################################
    ###													  ###
    ###   					Menu control						  ### 
    ###													  ###
    #########################################################################################################
    
    set m .menu.control
    menu $m -tearoff 0 
    .menu add cascade -label "Interfaces" -menu $m -underline 0 
    $m add command -label "Agregar control"
    $m add command -label "Eliminar control"
    $m add command -label "Backup"

    . configure -menu .menu
    focus .
    
    set notification [frame .bottom]

    text $notification.txt -width 110 -height 10
    pack $notification.txt
    pack $notification -side bottom 
  }

  #########################################################################################################
  ###													###
  ###   					Agregar bridge						### 
  ###													###
  #########################################################################################################
  
  proc eventAddBridge {} {
    global controlador
    global panel
    global notification
    
    set bridge [$panel.ent get]
    set result [$controlador action SA_addBridge $bridge]

    $notification.txt insert end "Evento agregar bridge:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el bridge: $bridge\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el bridge\n"
    } 
    $notification.txt see end
  }
    
  proc windowAddBridge {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Crear bridge" -command "eventAddBridge"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }
  
  #########################################################################################################
  ###													###
  ###   					Agregar interfaz					### 
  ###													###
  #########################################################################################################
  
  proc eventAddInterface {} {
    global controlador
    global panel
    global notification
    
    set interface [$panel.ent get]
    set result [$controlador action SA_addInterface $interface]

    $notification.txt insert end "Evento agregar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Agregado con exito el interfaz: $interface\n"
    } else {
      $notification.txt insert end "Error: No se ha podido agregar el interfaz\n"
    }
    $notification.txt see end
  }
    
  proc windowAddInterface {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del interfaz:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Crear interfaz" -command "eventAddInterface"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }
  
  #########################################################################################################
  ###													###
  ###   					Agregar puerto						### 
  ###													###
  #########################################################################################################
  
  proc eventAddPort {} {
    global controlador
    global panel
    global notification
    
    set data(from) [$panel.ent1 get]
    set data(to) [$panel.ent2 get]
    set result [$controlador action SA_addPort data]

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
  
  #########################################################################################################
  ###													###
  ###   					Agregar vLink						### 
  ###													###
  #########################################################################################################
  
  proc eventAddVlink {} {
    global controlador
    global panel
    global notification
    
    set data(from) [$panel.ent1 get]
    set data(to) [$panel.ent2 get]
    set result [$controlador action SA_addVlink data]

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
  
  #########################################################################################################
  ###													###
  ###   					Eliminar bridge						### 
  ###													###
  #########################################################################################################
    
  proc eventDelBridge {} {
    global controlador
    global panel
    global notification    
    
    set bridge [$panel.ent get]
    set resultado [$controlador action SA_delBridge $bridge]

    $notification.txt insert end "Evento eliminar switch:\n"

    if {$resultado == 1} {
      $notification.txt insert end "Eliminado con exito el switch: $bridge\n"
    } else {
      $notification.txt insert end "Error: No se ha podido elimar el switch\n"
    }
    $notification.txt see end
  }

  proc windowDelBridge {} {
    global panel
    set panel [frame .panel]
    pack $panel
    
    label $panel.lab -text "Nombre del bridge:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar bridge" -command "eventDelBridge"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
  }
  
  #########################################################################################################
  ###													###
  ###   					Eliminar interfaz					### 
  ###													###
  #########################################################################################################
  
  proc eventDelInterface {} {
    global controlador
    global panel
    global notification
    
    set interface [$panel.ent get]
    set result [$controlador action SA_delInterface $interface]

    $notification.txt insert end "Evento eliminar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el interfaz: $interface\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el interfaz\n"
    }
    $notification.txt see end
  }
    
  proc windowDelInterface {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del interfaz:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar interfaz" -command "eventDelInterface"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }
  
  #########################################################################################################
  ###													###
  ###   					Eliminar puerto						### 
  ###													###
  #########################################################################################################
  
  proc eventDelPort {} {
    global controlador
    global panel
    global notification
    
    set data(from) [$panel.ent1 get]
    set data(to) [$panel.ent2 get]
    set result [$controlador action SA_delPort data]

    $notification.txt insert end "Evento eliminar puerto:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el puerto de $data(to) a $data(from)\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el puerto\n"
    }
    $notification.txt see end
  }
    
  proc windowDelPort {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab1 -text "Nombre del bridge:" -width 50
    entry $panel.ent1 -width 50
    label $panel.lab2 -text "Nombre del elemento a conectar:" -width 50
    entry $panel.ent2 -width 50
    button $panel.but -text "Eliminar puerto" -command "eventDelPort"
    
    pack $panel.lab1
    pack $panel.ent1
    pack $panel.lab2
    pack $panel.ent2
    pack $panel.but
    pack $panel
  }
  
  #########################################################################################################
  ###													###
  ###   					Eliminar vLink						### 
  ###													###
  #########################################################################################################
  
  proc eventDelVlink {} {
    global controlador
    global panel
    global notification
    
    set vlink [$panel.ent get]
    set result [$controlador action SA_delVlink $vlink]

    $notification.txt insert end "Evento eliminar interfaz:\n"

    if {$result == 1} {
      $notification.txt insert end "Eliminado con exito el vLink: $vlink\n"
    } else {
      $notification.txt insert end "Error: No se ha podido eliminar el vLink\n"
    }
    $notification.txt see end
  }
    
  proc windowDelVlink {} {
    global panel
    set panel [frame .panel]
    
    
    label $panel.lab -text "Nombre del conector:" -width 50
    entry $panel.ent -width 50
    button $panel.but -text "Eliminar vLink" -command "eventDelVlink"
    
    pack $panel.lab
    pack $panel.ent
    pack $panel.but
    pack $panel
  }  
  
  #########################################################################################################
  ###													###
  ###   					Mostrar información					### 
  ###													###
  #########################################################################################################
  
  proc eventShowInfo {} {
    global controlador
    global notification
    
    set result [$controlador action SA_showInfo null]

    $notification.txt insert end "Evento mostrar bridges:\n"
    if {[string length $result] > 0} {
      $notification.txt insert end "$result\n"
    } else {
      $notification.txt insert end "No hay ningun bridge\n"
    }
    $notification.txt see end
  }
  
  #########################################################################################################
  ###													###
  ###   					Guardar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventSaveTopology {} {
    global controlador
    global panel
    global notification
    
    set fileName [$panel.ent get]
    set result [$controlador action SA_saveTopology $fileName]

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
  
  #########################################################################################################
  ###													###
  ###   					Cargar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventLoadTopology {} {
    global controlador
    global panel
    global notification    
    
    set types {
      {"OpenVSwitch files" {.ncovs}}
    } 
  
    set fileName [tk_getOpenFile -filetypes $types -parent .]
    $panel.lab configure -text $fileName
    set result [$controlador action SA_loadTopology $fileName]
    
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
  
  #########################################################################################################
  ###													###
  ###   					Limpiar topologia					### 
  ###													###
  #########################################################################################################
  
  proc eventCleanTopology {} {
    global controlador
    global notification
    
    set result [$controlador action SA_cleanTopology null]

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