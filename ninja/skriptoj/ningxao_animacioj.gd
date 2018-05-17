extends AnimationPlayer

var terigxinta = true
onready var radipafo = $"../radi_elsendo"
var distanco = 0
var rapideco = 0

func _ready():
	play("kurado")

func _process(delta):
	#sxangxi la animaciojn lau la stato de la movanta ludato
	if Input.is_action_just_pressed("ui_left"):
		$"../Formo".set_scale(Vector2(-1,1))
	if Input.is_action_just_pressed("ui_right"):
		$"../Formo".set_scale(Vector2(1,1))
	
	#kontroli la tersituacion kaj distancon
	terkontrolo()
	
	if terigxinta == true:
		rapideco = get_parent().mov_rapido.length()
		rapideco = ( rapideco / 300 ) * 4.5
		if rapideco < 0.5:
			if get_current_animation() != "sencela":
				set_speed_scale(3)
				play("sencela", 0.6)
		else:
			set_speed_scale(rapideco)
			if get_current_animation() != "kurado":
				play("kurado")
	else:
		if get_current_animation() != "area_supren":
			play("area_supren")
		#rapideco = 0

func terkontrolo():
	distanco = radipafo.get_collision_point().distance_to(get_parent().get_global_position())
	if distanco > 15:
		terigxinta = false
	else:
		terigxinta = true

func _on_ningxao_animacioj_animation_finished(anim_name):
	var nuntempa = get_current_animation()
	play(nuntempa, -1)
		
func terigxinte():
	if terigxinta == true:
		return
	terigxinta = true
	print("Ningxao sukcese kaj kode alterigxis")