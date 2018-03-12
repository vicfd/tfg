oo::class create daoControl {
  method addFlow {bridge flow} {
    if {[catch {exec sudo ovs-ofctl add-flow $bridge "$flow"} errmsg]} {
	    puts "$errmsg"
	    return 0
    }
    return 1
  }

  method delFlow {bridge flow} {
    if {[catch {exec sudo ovs-ofctl del-flows $bridge "$flow"} errmsg]} {
	    puts "$errmsg"
	    return 0
    }
    return 1
  }
  
  method showFlows {bridge} {
    set rc [catch {
      set result [exec sudo ovs-ofctl dump-flows $bridge | sed "1d"]
    } result]

    if {$rc} {
      set result 0
    }
  
    return $result
  }
  
  method saveFlows {data fileName} {
    if {[catch {exec echo $data > $fileName.ncovs} errmsg]} {
      puts "$errmsg"
      return 0
    }
    return 1
  }
  
  method loadFlows {bridge fileName} {
    if {[catch {exec sudo ovs-ofctl add-flows $bridge $fileName} errmsg]} {
	    puts "$errmsg"
	    return 0
    }
    return 1
  }
  
  method cleanFlows {bridge} {
    if {[catch {exec sudo ovs-ofctl del-flows $bridge} errmsg]} {
      puts "$errmsg"
      return 0
    }
    return 1
  }
}
