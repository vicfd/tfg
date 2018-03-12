source business/business_topology.tcl
source business/business_control.tcl

oo::class create controller {
  constructor {} {
    my variable businessTopology
    my variable businessControl
    set businessTopology [businessTopology new]
    set businessControl [businessControl new]
  }

  method action {event data} {
    my variable businessTopology
    my variable businessControl

    switch $event {
      SA_addBridge {
	set result [$businessTopology addBridge $data]
	return $result
      }
      SA_addInterface {
	set result [$businessTopology addInterface $data]
	return $result
      }
      SA_addPort {
	upvar $data val
	set result [$businessTopology addPort $val(from) $val(to)]
	return $result
      }
      SA_addVlink {
	upvar $data val
	set result [$businessTopology addVlink $val(from) $val(to)]
	return $result
      }
      SA_delBridge {
	set result [$businessTopology delBridge $data]
	return $result
      }
      SA_delInterface {
	set result [$businessTopology delInterface $data]
	return $result
      }
      SA_delPort {
	upvar $data val
	set result [$businessTopology delPort $val(from) $val(to)]
	return $result
      }
      SA_delVlink {
	set result [$businessTopology delVlink $data]
	return $result
      }
      SA_showInfo {
	set result [$businessTopology showInfo]
	return $result
      }
      SA_saveTopology {
	set result [$businessTopology saveTopology $data]
	return $result
      }
      SA_loadTopology {
	set result [$businessTopology loadTopology $data]
	return $result
      }
      SA_cleanTopology {
	set result [$businessTopology cleanTopology]
	return $result
      }
      SA_addFlow {
	upvar $data val
	set result [$businessControl addFlow $val(bridge) $val(flow)]
	return $result
      }
      SA_delFlow {
	upvar $data val
	set result [$businessControl delFlow $val(bridge) $val(flow)]
	return $result
      }
      SA_showFlows {
	set result [$businessControl showFlows $data]
	return $result
      }
      SA_saveFlows {
	upvar $data val
	set result [$businessControl saveFlows $val(bridge) $val(fileName)]
	return $result
      }
      SA_loadFlows {
	upvar $data val
	set result [$businessControl loadFlows $val(bridge) $val(fileName)]
	return $result
      }
      SA_cleanFlows {
	set result [$businessControl cleanFlows $data]
	return $result
      }
      default {
	puts "evento por defecto: $event"
      }
    }
  }
}

