oo::class create daoFile {
  # guardar list-br
  # ip tuntap son volatiles
  method saveTopology {fileName save} {
    exec rm -rf save/$fileName
    exec mkdir save/$fileName
    set data [open save/$fileName/save.ncovs w]
    puts $data $save
    close $data
  }

  # cargamos 
  # sudo ovs-vsctl get interface uml1_2 status si no es tun no se carga
  method loadTopology {fileName} {
      set fp [open $fileName r]
      set file_data [read $fp]
      close $fp
      return $file_data
  }
  
  method saveFlows {data fileName} {
    if {[catch {exec echo $data > $fileName.ncovs} errmsg]} {
      puts "$errmsg"
      return 0
    }
    return 1
  }
}
