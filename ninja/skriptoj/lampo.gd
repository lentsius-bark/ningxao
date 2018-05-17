extends Sprite

export var sxaltita = false
export var sxalttempo = 0.1

export(String, "Blua", "Rugxa", "Flava") var lamptipo


func _ready():
	if sxaltita == true:
		$sono.play(0.0)
		$lumlumo.set_enabled(1)
	else:
		$lumlumo.set_enabled(0)		
	
	if lamptipo == "Blua":
		#fari ion bluan
		pass
	elif lamptipo == "Rugxa":
		#fari ion rugxan
		pass
	elif lamptipo == "Flava":
		#fario ion Flavan
		pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func sxaltigxi(ningxao):
	#sxaltigxi kaj forigi nebezonatajn aferojn
	sxaltita = true
	$sxaltigxsono.play(0.0)
	$lumlumo.set_enabled(1)
	$sono.play(0.0)
	$loko2D.queue_free()

func _on_AudioStreamPlayer2D_finished():
	$sono.play(0.1)


func _on_loko2D_body_entered(body):
	print("povas_sxalti")
	body.sxaltebligi(self)


func _on_loko2D_body_exited(body):
	body.malsxaltebligi(self)


func _on_sxaltigxsono_finished():
	$sxaltigxsono.queue_free()
