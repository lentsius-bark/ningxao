extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$fongitaro.play(0.0)
	pass

func _on_fongitaro_finished():
	$fongitaro.play(0.0)
	
func versxu_moneron(loko, valoro):
	globala.add_monero(valoro)
	pass