source integracion/daoTopologia.tcl

oo::class create negocioTopologia {
    constructor {} {
		my variable daoTopologia
		set daoTopologia [daoTopologia new]
    }

    method addBridge {bridge} {
		my variable daoTopologia
		set listInterface [$daoTopologia existInterface $bridge]
		
		if {$listInterface} {
			return 0
		} else {
			$daoTopologia addBridge $bridge
			return 1
		}
	}
	
	method addInterface {interface} {
		my variable daoTopologia
		return [$daoTopologia addInterface $interface]
	}
	
	method addVlink {from to} {
		my variable daoTopologia
		return [$daoTopologia addVlink $from $to]
	}	
	
	method delBridge {bridge} {
		my variable daoTopologia
		return [$daoTopologia delBridge $bridge]
	}
	
	method delInterface {interface} {
		my variable daoTopologia
		return [$daoTopologia delInterface $interface]
	}

	method delVlink {from} {
		my variable daoTopologia
		return [$daoTopologia delVlink $from]
	}		
}
