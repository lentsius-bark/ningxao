extends Node

var moneroj = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func aldoni_monerojn(valoro):
	moneroj += valoro
	
func atingi_moneroj():
	return(moneroj)