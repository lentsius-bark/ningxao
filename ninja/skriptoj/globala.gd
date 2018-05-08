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

func add_monero(valoro):
	moneroj += valoro
	print(moneroj)
	
func get_moneroj():
	return(moneroj)
	