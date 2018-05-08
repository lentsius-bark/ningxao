extends StaticBody2D

export var forteco = 3000

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "ningxao":
		body.padsalto(forteco)
		$salt_rampo.set_visible(1)
		$sono.play(0.0)
		yield(get_tree().create_timer(0.1), "timeout")
		$salt_rampo.set_visible(0)
