extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _on_ningxao_sxaltante(maksimumo, progreso):
	$uzi.set_max(maksimumo)
	$uzi.set_value(progreso)

func _on_ningxao_aperi():
	$uzi.set_visible(1)

func _on_ningxao_malaperi():
	$uzi.set_visible(0)
	reset()

func reset():
	$uzi.set_value(0)

func _on_ningxao_sxaltinte():
	reset()
