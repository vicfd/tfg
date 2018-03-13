source dataAccess/dao_topology.tcl
source dataAccess/dao_file.tcl

oo::class create businessTopology {
  constructor {} {
    my variable daoTopology
    my variable daoFile
    set daoTopology [daoTopology new]
    set daoFile [daoFile new]
  }

  method addBridge {bridge} {
    my variable daoTopology

    set result [$daoTopology addBridge $bridge]
    
    if {$result == 1} {
      $daoTopology upElement $bridge
    }
    
    return $result
  }
	  
  method addInterface {interface} {
    my variable daoTopology
    set result [$daoTopology addInterface $interface]
    
    if {$result == 1} {
      $daoTopology upElement $interface
    }
    
    return $result
  }
  
  method addPort {from to} {
    my variable daoTopology
    set result [$daoTopology addPort $from $to]
    
    return $result
  }

  method addVlink {from to} {
    my variable daoTopology
    set result [$daoTopology addVlink $from $to]
    
    if {$result == 1} {
      $daoTopology upElement $from
      $daoTopology upElement $to
    }
    
    return $result
  }	

  method delBridge {bridge} {
    my variable daoTopology
    return [$daoTopology delBridge $bridge]
  }

  method delInterface {interface} {
    my variable daoTopology
    return [$daoTopology delInterface $interface]
  }
  
  method delPort {from to} {
    my variable daoTopology
    set result [$daoTopology delPort $from $to]
    
    return $result
  }

  method delVlink {from} {
    my variable daoTopology
    return [$daoTopology delVlink $from]
  }
  
  method showInfo {} {
    my variable daoTopology
    set bridges [$daoTopology listBr]
    set result ""
    set first 1
    
    foreach bridge $bridges {
      if {$first == 1} {
	set result "$bridge:"
	set first 0
      } else {
	set result [append result "\n" $bridge ":"]
      }
      
      set ports [$daoTopology listPort $bridge]
      
      foreach port $ports {
	set result [append result " " $port]
      }
    }
    
    return $result
  }
  
  method saveTopology {fileName} {
    set result 0
    
    if {[string length $fileName] != 0} {
      my variable daoTopology
      my variable daoFile
      set bridges [$daoTopology listBr]
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
	
	set ports [$daoTopology listPort $bridge]
	
	foreach port $ports {
	  set status [$daoTopology getInterfaceStatus $port]

	  if {[string first tun $status] != -1} {
	    set save [append save "\n" "2 $port"]
	  } elseif {[string first veth $status] != -1} {
	    set vlinks [$daoTopology getVethConnection $port]
	    set vlinks [split $vlinks "@"]
	    set save [append save "\n" "3"]
	    
	    foreach vlink $vlinks {
	      set save [append save $vlink " "]
	    }
	  } else {
	    set save [append save "\n" "4 $port"]
	  }
	}
      }
      
      $daoFile saveTopology $fileName $save
    }
      
    return $result
  }
  
  method loadTopology {fileName} {
    set send 0
    
    if {[string length $fileName] != 0} {
      my variable daoTopology
      my variable daoFile
      set file_data [$daoFile loadTopology $fileName]
      set send 1
      set bridge ""
      
      set data [split $file_data "\n"]
      foreach line $data {
	set command -1
	set aux 1
	foreach item $line {
	  if {$command == -1} {
	    set command $item
	  } elseif {$command == 1} {
	    set bridge $item
	    set result [$daoTopology addBridge $bridge]
	    
	    if {$result == 1} {
	      $daoTopology upElement $bridge
	    }
	  } elseif {$command == 2} {
	    set result [$daoTopology addInterface $item]
	    
	    if {$result == 1} {
	      $daoTopology upElement $item
	      $daoTopology addPort $bridge $item
	    }
	  } elseif {$command == 3} {
	    if {$aux == 1} {
	      set aux $item
	    } else {
	      set result [$daoTopology addVlink $aux $item]
	      
	      if {$result == 1} {
		$daoTopology upElement $aux
		$daoTopology upElement $item
	      }
	      
	      $daoTopology addPort $bridge $aux
	    }
	  } elseif {$command == 4} {
	    $daoTopology addPort $bridge $item
	  }
	}
      }
    }
      
    return $send
  }
  
  method cleanTopology {} {
    my variable daoTopology
    set bridges [$daoTopology listBr]
    set result 1
    
    foreach bridge $bridges {
      set ports [$daoTopology listPort $bridge]
      
      foreach port $ports {
	set status [$daoTopology getInterfaceStatus $port]
	$daoTopology delInterface $port
	if {[string first tun $status] != -1} {
	  $daoTopology delInterface $port
	} elseif {[string first veth $status] != -1} {
	  $daoTopology delVlink $port
	}
      }
      $daoTopology delBridge $bridge
    }
  }
}
