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
			set result [$daoTopologia addBridge $bridge]
			
			if {$result == 1} {
				$daoTopologia upElement $bridge
			}
			
			return $result
		}
	}
	
	method addInterface {interface} {
		my variable daoTopologia
		set result [$daoTopologia addInterface $interface]
		
		if {$result == 1} {
			$daoTopologia upElement $interface
		}
		
		return $result
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
