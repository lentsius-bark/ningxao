extends Node2D

export var trezora = false
#export var cel_sceno
onready var animacioj = $pordo_animacioj

func _ready():
	if trezora:
		var novbrilo = load('res://grafikajxoj/pordoj/brilo_orangxa.png')
		var novpordo = load('res://grafikajxoj/pordoj/la_pordo_orangxa.png')
		$brilo.set_texture(novbrilo)
		$la_pordo.set_texture(novpordo)
		$brilo.set_visible(0)
	else:
		pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_body_entered(body):
	animacioj.play("malfermi")
	$brilo.set_visible(1)


func _on_Area2D_body_exited(body):
	animacioj.play_backwards("malfermi")
	$brilo.set_visible(0)