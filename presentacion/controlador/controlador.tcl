source negocio/negocioTopologia.tcl

oo::class create controlador {
  constructor {} {
    my variable negocioTopologia
    set negocioTopologia [negocioTopologia new]
  }

  method action {event data} {
    global S
    my variable negocioTopologia

    switch $event {
      SA_addBridge {
	set result [$negocioTopologia addBridge $data]
	return $result
      }
      SA_addInterface {
	set result [$negocioTopologia addInterface $data]
	return $result
      }
      SA_addPort {
	upvar $data val
	set result [$negocioTopologia addPort $val(from) $val(to)]
	return $result
      }
      SA_addVlink {
	upvar $data val
	set result [$negocioTopologia addVlink $val(from) $val(to)]
	return $result
      }
      SA_delBridge {
	set result [$negocioTopologia delBridge $data]
	return $result
      }
      SA_delInterface {
	set result [$negocioTopologia delInterface $data]
	return $result
      }
      SA_delPort {
	upvar $data val
	set result [$negocioTopologia delPort $val(from) $val(to)]
	return $result
      }
      SA_delVlink {
	set result [$negocioTopologia delVlink $data]
	return $result
      }
      SA_showInfo {
	set result [$negocioTopologia showInfo]
	return $result
      }
      SA_saveTopology {
	set result [$negocioTopologia saveTopology $data]
	return $result
      }
      SA_loadTopology {
	set result [$negocioTopologia loadTopology $data]
	return $result
      }
      SA_cleanTopology {
	set result [$negocioTopologia cleanTopology]
	return $result
      }
      default {
	puts "evento por defecto: $event"
      }
    }
  }
}

