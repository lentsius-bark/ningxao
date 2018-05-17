extends StaticBody2D

export var movigxanta = false
export var speed = 2000
export(NodePath) var cel_planednodo

onready var pafo = $radipafo

var celplanedo
var lokoj = []
var celo
var direkto = Vector2()
var novloko = Vector2()
var angulo

export(float) var rapideco = 0.01

func _ready():
	if cel_planednodo != null:
		celplanedo = get_node(cel_planednodo)
	if movigxanta == true:
		lokoj = $"../lokoj".get_children()
		set_global_position(lokoj[0].get_global_position())
		celo = lokoj[0]
		set_global_position(celo.get_global_position())
	else:
		$"../lokoj".queue_free()
		$radipafo.queue_free()
		set_script(null)

func _process(delta):
	movigxi(delta)
	if celplanedo != null:
		turnigxi()
	
	
func movigxi(delta):	
	direkto = get_position() - celo.get_position()
	direkto = direkto.normalized() * speed * delta

	translate(-direkto)

	if get_global_position().distance_to(celo.get_global_position()) < 1.5:
		lokoj.invert()
		celo = lokoj[0]

func turnigxi():
	pafo.set_cast_to(to_local(celplanedo.get_global_position()))
	angulo = get_global_position().angle_to_point(pafo.get_collision_point())
	set_rotation(rad2deg(angulo)/2 + 90)
	print(rad2deg(angulo))