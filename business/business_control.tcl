source dataAccess/dao_control.tcl
source dataAccess/dao_file.tcl

oo::class create businessControl {
  constructor {} {
    my variable daoControl
    my variable daoFile
    set daoControl [daoControl new]
    set daoFile [daoFile new]
  }

  method addFlow {bridge flow} {
    my variable daoControl

    set result [$daoControl addFlow $bridge $flow]    
    return $result
  }
  
  method delFlow {bridge flow} {
    my variable daoControl

    set result [$daoControl delFlow $bridge $flow]    
    return $result
  }
  
  method showFlows {bridge} {
    my variable daoControl

    set result [$daoControl showFlows $bridge]    
    return $result
  }
  
  method saveFlows {bridge fileName} {
    my variable daoControl
    my variable daoFile
  
    set result [$daoControl showFlows $bridge]
    
    if {$result == 0} {
      set result 0
    } else {
      $daoFile saveFlows $result $fileName
      set result 1
    }
    
    return $result
  }
  
  method loadFlows {bridge fileName} {
    my variable daoControl

    set result [$daoControl loadFlows $bridge $fileName]    
    return $result
  }
  
  method cleanFlows {bridge} {
    my variable daoControl

    set result [$daoControl cleanFlows $bridge]    
    return $result
  }
}