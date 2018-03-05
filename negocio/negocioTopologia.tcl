source integracion/daoTopologia.tcl

oo::class create negocioTopologia {
  constructor {} {
    my variable daoTopologia
    set daoTopologia [daoTopologia new]
  }

  method addBridge {bridge} {
    my variable daoTopologia

    set result [$daoTopologia addBridge $bridge]
    
    if {$result == 1} {
      $daoTopologia upElement $bridge
    }
    
    return $result
  }
	  
  method addInterface {interface} {
    my variable daoTopologia
    set result [$daoTopologia addInterface $interface]
    
    if {$result == 1} {
      $daoTopologia upElement $interface
    }
    
    return $result
  }
  
  method addPort {from to} {
    my variable daoTopologia
    set result [$daoTopologia addPort $from $to]
    
    return $result
  }

  method addVlink {from to} {
    my variable daoTopologia
    set result [$daoTopologia addVlink $from $to]
    
    if {$result == 1} {
      $daoTopologia upElement $from
      $daoTopologia upElement $to
    }
    
    return $result
  }	

  method delBridge {bridge} {
    my variable daoTopologia
    return [$daoTopologia delBridge $bridge]
  }

  method delInterface {interface} {
    my variable daoTopologia
    return [$daoTopologia delInterface $interface]
  }
  
  method delPort {from to} {
    my variable daoTopologia
    set result [$daoTopologia delPort $from $to]
    
    return $result
  }

  method delVlink {from} {
    my variable daoTopologia
    return [$daoTopologia delVlink $from]
  }
  
  method showInfo {} {
    my variable daoTopologia
    set bridges [$daoTopologia listBr]
    set result ""
    set first 1
    
    foreach bridge $bridges {
      if {$first == 1} {
	set result "$bridge:"
	set first 0
      } else {
	set result [append result "\n" $bridge ":"]
      }
      
      set ports [$daoTopologia listPort $bridge]
      
      foreach port $ports {
	set result [append result " " $port]
      }
    }
    
    return $result
  }
  
  method saveTopology {fileName} {
    set result 0
    
    if {[string length $fileName] != 0} {
      my variable daoTopologia
      set bridges [$daoTopologia listBr]
      set save ""
      set first 1
      set result 1
      
      foreach bridge $bridges {
	if {$first == 1} {
	  set save "1 $bridge"
	  set first 0
	} else {
	  set save [append save "\n" "1 $bridge"]
	}
	
	set ports [$daoTopologia listPort $bridge]
	
	foreach port $ports {
	  set status [$daoTopologia getInterfaceStatus $port]

	  if {[string first tun $status] != -1} {
	    set save [append save "\n" "2 $port"]
	  } elseif {[string first veth $status] != -1} {
	    set vlinks [$daoTopologia getVethConnection $port]
	    set vlinks [split $vlinks "@"]
	    set save [append save "\n" "3"]
	    
	    foreach vlink $vlinks {
	      set save [append save $vlink " "]
	    }
	  }
	}
      }
      
      $daoTopologia saveTopology $fileName $save
    }
      
    return $result
  }
  
  method loadTopology {fileName} {
    set send 0
    
    if {[string length $fileName] != 0} {
      my variable daoTopologia
      set file [$daoTopologia loadTopology]
      set send 1
      set bridge ""

      set fp [open $fileName r]
      set file_data [read $fp]
      close $fp
      
      set data [split $file_data "\n"]
      foreach line $data {
	set command -1
	set aux 1
	foreach item $line {
	  if {$command == -1} {
	    set command $item
	  } elseif {$command == 1} {
	    set bridge $item
	    set result [$daoTopologia addBridge $bridge]
	    
	    if {$result == 1} {
	      $daoTopologia upElement $bridge
	    }
	  } elseif {$command == 2} {
	    set result [$daoTopologia addInterface $item]
	    
	    if {$result == 1} {
	      $daoTopologia upElement $item
	      $daoTopologia addPort $bridge $item
	    }
	  } elseif {$command == 3} {
	    if {$aux == 1} {
	      set aux $item
	    } else {
	      set result [$daoTopologia addVlink $aux $item]
	      
	      if {$result == 1} {
		$daoTopologia upElement $aux
		$daoTopologia upElement $item
	      }
	      
	      $daoTopologia addPort $bridge $aux
	    }
	  }
	}
      }
    }
      
    return $send
  }
  
  method cleanTopology {} {
    my variable daoTopologia
    set bridges [$daoTopologia listBr]
    set result 1
    
    foreach bridge $bridges {
      set ports [$daoTopologia listPort $bridge]
      
      foreach port $ports {
	set status [$daoTopologia getInterfaceStatus $port]
	$daoTopologia delInterface $port
	if {[string first tun $status] != -1} {
	  $daoTopologia delInterface $port
	} elseif {[string first veth $status] != -1} {
	  $daoTopologia delVlink $port
	}
      }
      $daoTopologia delBridge $bridge
    }
  }
}
