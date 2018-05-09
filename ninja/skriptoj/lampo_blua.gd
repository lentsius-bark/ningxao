extends Sprite

export var sxaltita = false
export var sxalttempo = 0.1


func _ready():
	if sxaltita == true:
		$sono.play(0.0)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func sxalti():
	#sxaltigxi kaj forigi nebezonatajn aferojn
	sxaltita = true
	$sxaltigxsono.play(0.0)
	$lumo.set_visible(1)
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
