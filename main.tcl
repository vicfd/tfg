source presentacion/controlador/controlador.tcl

set controlador [controlador new]
$controlador action SA_delBridge aasd
$controlador action SA_addBridge aasd
$controlador action SA_addInterface aasd
$controlador action SA_delInterface aasd
$controlador action SA_delBridge aasd
$controlador action SA_addInterface aasd
$controlador action SA_delInterface aasd

set data(from) VTRUNK_0
set data(to) VTRUNK_1

$controlador action SA_addVlink data
$controlador action SA_addVlink data
$controlador action SA_delVlink $data(from)
$controlador action SA_delVlink $data(from)