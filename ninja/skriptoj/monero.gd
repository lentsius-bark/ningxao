extends Node2D

export var obla = false
export var valoro = 1

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_body_entered(body):
	#aldonu la antauagorditan amason da moneroj al la globala skripto
	globala.add_monero(valoro)
	
	#ludu monersonon lau la grandeco de la monero
	if obla:
		$sonego.play(0.0)
	else:
		$sono.play(0.0)
		
	#sxaltu la sonon kaj kasxu la lokon kiu kontrolas cxu la laduta eniris
	set_visible(0)
	$Area2D.call_deferred("set_monitoring", false)

func _on_sono_finished():
	get_parent().remove_child(self)
	queue_free()