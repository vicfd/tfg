  source presentation/views/view_addBridge.tcl
  source presentation/views/view_addInterface.tcl
  source presentation/views/view_addPort.tcl
  source presentation/views/view_addVlink.tcl
  source presentation/views/view_cleanTopology.tcl
  source presentation/views/view_delBridge.tcl
  source presentation/views/view_delInterface.tcl
  source presentation/views/view_delPort.tcl
  source presentation/views/view_delVlink.tcl
  source presentation/views/view_loadTopology.tcl
  source presentation/views/view_saveTopology.tcl
  source presentation/views/view_showInfo.tcl
  source presentation/views/view_addFlow.tcl
  source presentation/views/view_delFlow.tcl
  source presentation/views/view_showFlows.tcl
  source presentation/views/view_saveFlows.tcl
  source presentation/views/view_loadFlows.tcl
  source presentation/views/view_cleanFlows.tcl

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

    wm title . "Nuestro controlador Open vSwitch"
    wm minsize . 950 300
    menu .menu -tearoff 0 
    wm geometry .menu 300x50
    
    
    #########################################################################################################
    ###													  ###
    ###   					Menu archivo						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.files
    menu $m -tearoff 0 
    .menu add cascade -label "Archivo" -menu $m -underline 0
    $m add command -label "Guardar topologia" -command {destroy .panel; windowSaveTopology}
    $m add command -label "Cargar topologia" -command {destroy .panel; windowLoadTopology}
    $m add command -label "Guardar control" -command {destroy .panel; windowSaveFlows}
    $m add command -label "Cargar control" -command {destroy .panel; windowLoadFlows}
    
    #########################################################################################################
    ###													  ###
    ###   					Menu limpiar						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.clean
    menu $m -tearoff 0 
    .menu add cascade -label "Limpiar" -menu $m -underline 0
    $m add command -label "Limpiar topologia" -command {eventCleanTopology}
    $m add command -label "Limpiar flujos" -command {destroy .panel; windowCleanFlows}

    #########################################################################################################
    ###													  ###
    ###   					Menu puentes						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.bridges
    menu $m -tearoff 0 
    .menu add cascade -label "Puente" -menu $m -underline 0     
    $m add command -label "Agregar puente" -command {destroy .panel; windowAddBridge}
    $m add command -label "Eliminar puente" -command {destroy .panel; windowDelBridge}
    $m add command -label "Mostrar puentes" -command {eventShowInfo}
    
    #########################################################################################################
    ###													  ###
    ###   					Menu interfaces						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.interfaces
    menu $m -tearoff 0 
    .menu add cascade -label "Interfaces" -menu $m -underline 0     
    $m add command -label "Agregar interfaz" -command {destroy .panel; windowAddInterface}
    $m add command -label "Eliminar interfaz" -command {destroy .panel; windowDelInterface}
      
    #########################################################################################################
    ###													  ###
    ###   					Menu vlink						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.vlink
    menu $m -tearoff 0 
    .menu add cascade -label "vLink" -menu $m -underline 0 
    $m add command -label "Agregar vLink" -command {destroy .panel; windowAddVlink}
    $m add command -label "Eliminar vLink" -command {destroy .panel; windowDelVlink}
    
    #########################################################################################################
    ###													  ###
    ###   					Menu Puerto						  ### 
    ###													  ###
    #########################################################################################################

    set m .menu.port
    menu $m -tearoff 0 
    .menu add cascade -label "Puerto" -menu $m -underline 0 
    $m add command -label "Agregar puerto" -command {destroy .panel; windowAddPort}
    $m add command -label "Eliminar puerto" -command {destroy .panel; windowDelPort}
    
    #########################################################################################################
    ###													  ###
    ###   					Menu control						  ### 
    ###													  ###
    #########################################################################################################
    
    set m .menu.control
    menu $m -tearoff 0 
    .menu add cascade -label "Interfaces" -menu $m -underline 0 
    $m add command -label "Agregar control" -command {destroy .panel; windowAddFlow}
    $m add command -label "Eliminar control" -command {destroy .panel; windowDelFlow}
    $m add command -label "Mostrar flujo" -command {destroy .panel; windowShowFlows}

    . configure -menu .menu
    focus .
    
    set notification [frame .bottom]

    text $notification.txt -width 130 -height 10
    pack $notification.txt
    pack $notification -side bottom 
    
    global panel
    set panel [frame .panel]
    label $panel.lab1 -text "Bienvenido a nuestro controlador de Open vSwitch, utiliza el menu de arriba para navegar por todas las funciones." -height 5
    grid $panel.lab1 -row 0 -column 0
    pack $panel    
  }