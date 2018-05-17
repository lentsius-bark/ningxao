extends StaticBody2D

export(float) var sxalttempo = 5
export(bool) var sxaltigxebla = true
export(bool) var unufoja = false

func _on_Loko2D_body_entered(body):
	if body.name == "ningxao" and sxaltigxebla == true:
		body.sxaltebligi(self)

func _on_Loko2D_body_exited(body):
	if body.name == "ningxao":
		body.malsxaltebligi(self)
		
func sxaltigxi(ningxao):
	print("Teleporto funkcias")
	ningxao.teleporti($teleport_pozicio.get_global_position())
	if unufoja:
		$teleporto_animacio.set_modulate(Color(1,0.3,0.3,1))
		sxaltigxebla = false
		
func sxaltebligxi(unufoja_denove):
	$teleporto_animacio.set_modulate(Color(1,0.3,0.3,1))
	sxaltigxebla = true
	if unufoja_denove:
		return
	unufoja = false
	