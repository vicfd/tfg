oo::class create daoTopologia {
    method addBridge {bridge} {
		if {[catch {exec sudo ovs-vsctl add-br $bridge} errmsg]} {
			puts "$errmsg"
			return 0
		}
		return 1
    }

    method addInterface {interface} {
		if {[catch {exec sudo ip tuntap add $interface mode tap} errmsg]} {
			return 0
		}
		return 1
    }
	
    method addVlink {from to} {
		if {[catch {exec sudo ip link add $from type veth peer name $to} errmsg]} {
			return 0
		}
		return 1
    }
	
	method addPort {from to} {
		exec sudo ovs-vsctl add-port $from $to
	}

	method upElement {element} {
		exec sudo ip link set $element up
	}	
	
    method delBridge {bridge} {
		if {[catch {exec sudo ovs-vsctl del-br $bridge} errmsg]} {
			return 0
		}
		return 1
    }

    method delInterface {interface} {
		if {[catch {exec sudo ip tuntap del $interface mode tap} errmsg]} {
			return 0
		}
		return 1		
    }
	
	method delPort {from to} {
		exec sudo ovs-vsctl del-port $from $to
	}	
	
    method delVlink {from} {
		if {[catch {exec sudo ip link del $from} errmsg]} {
			return 0
		}
		return 1		
    }
	
	method downElement {element} {
		exec sudo ip link set $element down
	}
	
	method listBr {} {
		set result [exec sudo ovs-vsctl list-br]
		return $result
	}
	
	method existInterface {interface} {
		return [exec scripts/existInterface.sh $interface]
	}

    method saveTopology {} {
        puts "test"
    }

    method loadTopology {} {
        puts "test"
    }

    method cleanTopology {} {
        puts "test"
    }

    method updateTopology {} {
        puts "test"
    }

    method windowsShowsInfo {} {
        puts "test"
    }
}
