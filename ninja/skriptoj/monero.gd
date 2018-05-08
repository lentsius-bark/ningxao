extends Node2D

export var obla = false
export var valoro = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_body_entered(body):
	if body.name == "ningxao":
		globala.add_monero(valoro)
		#ludu monersonon
		if obla:
			$sonego.play(0.0)
		else:
			$sono.play(0.0)
		set_visible(0)
		$Area2D.call_deferred("set_monitoring", false)

func _on_sono_finished():
		get_parent().remove_child(self)
		queue_free()