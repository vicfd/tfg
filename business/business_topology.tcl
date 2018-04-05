source dataAccess/dao_topology.tcl
source dataAccess/dao_file.tcl

oo::class create businessTopology {
  constructor {} {
    my variable daoTopology
    my variable daoControl
    my variable daoFile
    set daoTopology [daoTopology new]
    set daoControl [daoControl new]
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
      my variable daoControl
      my variable daoFile
      set bridges [$daoTopology listBr]
      set save ""
      
      set veth "\"veth\" : \["
      set tuntap "\"tuntap\" : \["
      set bridge "\"bridge\" : \["
      
      set first_br 1
      set first_tuntap 1
      set first_veth 1
      set veth_list ""
      set result 1      
      
      foreach br $bridges {
	set aux_br "\{\"$br\" : \[\"$br.ncovs\""
	set ports [$daoTopology listPort $br]
	set aux_ports ""
	
	foreach port $ports {
	  set status [$daoTopology getInterfaceStatus $port]
	  set aux_ofport [$daoTopology getOfPort $port]
	  set aux_ports [append aux_ports ", {\"$port\": $aux_ofport}"]
	  
	  if {[string first tun $status] != -1} {
	    if {$first_tuntap == 1} {
	      set tuntap [append tuntap "\"$port\""]
	      set first_tuntap 0
	    } else {
	      set tuntap [append tuntap ", \"$port\""]
	    }
	  } elseif {[string first veth $status] != -1} {
	    if {[string first $port $veth_list] == -1} {
	      set vlinks [$daoTopology getVethConnection $port]
	      set vlinks [split $vlinks "@"]
	      set aux_veth 1

	      if {$first_veth == 1} {
		set first_veth 0
	      } else {
		set veth [append veth ", "]
	      }
	      
	      foreach vlink $vlinks {
		set veth_list [append veth_list $vlink]
		if {$aux_veth == 1} {
		  set veth [append veth "\{\"$port\": "]
		  set aux_veth 0
		} else {
		  set veth [append veth "\"$vlink\"\}"]
		}
	      }
	    }
	  }
	}
	
	set aux_ports [append aux_ports "\]"]
	set aux_br [append aux_br $aux_ports "\}"]
	
	if {$first_br == 1} {
	  set bridge [append bridge $aux_br]
	  set first_br 0
	} else {
	  set bridge [append bridge ", " $aux_br]
	}
      }
      
      set veth [append veth "\]"]
      set tuntap [append tuntap "\]"]
      set bridge [append bridge "\]"]
      set save "\{\n\t\"topologia\":\n\t\{\n\t\t$veth,\n\t\t$tuntap,\n\t\t$bridge\n\t\}\n\}"
      
      $daoFile saveTopology $fileName $save
      
      foreach br $bridges {
	set data [$daoControl showFlows $br]
	$daoFile saveFlows $data "save/$fileName/$br"
      }
    }
      
    return $result
  }
  
  method saveTopologyOld {fileName} {
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
      my variable daoControl
      my variable daoFile
      my cleanTopology
      set file_data [$daoFile loadTopology $fileName]
      set send 1
      set bridge ""
      set type_option 0
      set know_option 0
      
      set d1 [json::json2dict $file_data]

      foreach a $d1 {
	if {[string first topologia $a] == -1} {
	  foreach b $a {
	    if {$know_option == 0} {
	      if {[string first veth $b] != -1} {
		set type_option 1
	      } elseif {[string first tuntap $b] != -1} {
		set type_option 2
	      } elseif {[string first bridge $b] != -1} {
		set type_option 3
	      }
	      
	      set know_option 1
	    } else {
	      if {$type_option == 1} {
		foreach c $b {
		  set aux_veth ""
		  set aux_control_veth 0
		  foreach d $c {
		    if {$aux_control_veth == 0} {
		      set aux_veth $d
		      set aux_control_veth 1
		    } else {
		      my addVlink $aux_veth $d
		    }
		  }
		}
	      } elseif {$type_option == 2} {
		foreach c $b {
		  my addInterface $c
		}
	      } elseif {$type_option == 3} {
		set aux_br ""
		set aux_control_br 0
		foreach c $b {
		  foreach d $c {
		    if {$aux_control_br == 0} {
		      set aux_br $d
		      set aux_control_br 1
		    } else {
		      my addBridge $aux_br
		      set aux_br_flow 0
		      
		      foreach e $d {
			if {$aux_br_flow == 0} {
			  set aux_file [string range $fileName 0 [string last / $fileName]]
			  set aux_file [append aux_file $e]
			  $daoControl loadFlows $aux_br $aux_file
			  set aux_br_flow 1
			} else {
			  set aux_control_ofPort 0
			  set aux_interface ""
			  foreach f $e {
			    
			    if {$aux_control_ofPort == 0} {
			      set aux_interface $f
			      set aux_control_ofPort 1
			    } else {
			      #puts "$aux_interface $f"
			      $daoTopology addPort $aux_br $aux_interface
			      #my addPort $aux_br $aux_interface
			      $daoTopology setOfPort $aux_interface $f 
			      set aux_control_ofPort 0
			    }
			  }
			}
		      }
		      set aux_control_br 0
		    }
		  }
		}
	      }
	      
	      set know_option 0
	    }
	  }
	}
      }
    }
      
    return $send
  }
  
  method loadTopologyOld {fileName} {
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
