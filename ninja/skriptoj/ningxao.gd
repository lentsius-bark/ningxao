extends KinematicBody2D

var gravito = 9.8
var direkto = Vector2()
var mov_rapido = Vector2()
var mov_gravito = Vector2()

#la direkto de la surfaco
var supren = Vector2()

#angulo inter la ludato kaj la planedo
var angulo = 0
var mov_angulo = 0

var rapideco = 100
var akcelado = 700

#tiu ci variablo estas la radio kiu kontrolas la planedsurfacan direkton
onready var radio = $radi_elsendo
#test linio
onready var linio = $linio

# tiu ĉi variablo enhavos la planedon al kiu ni volos flugi
var cel_planedo

var vivpoentoj = 100



func _ready():
	var planedoj = []
	var infanoj = get_parent().get_children()
	for x in infanoj:
		if x.is_in_group("planedoj"):
			planedoj.append(x)
	if planedoj.size() == 0:
		print("Oni ne trovis planedojn en la gepatra nodo. Bonvolu aldoni almenau unu por korekta funkcio de la ludo")
	else:
		print("Sukcese aldonis planedon")
		cel_planedo = planedoj[0]

func _process(delta):
	#por ke ni ciam sciu kio estas la supra vektoro lau la surfaco de la planedo
	if radio.is_colliding():
		supren = radio.get_collision_normal()
	else:
		#print("ne estas planedo cxi tie")
		pass
		
#	movigxu(delta)
	turnigxu(delta)
	gxisdatigu_radion()
	
func _physics_process(delta):
	movigxu(delta)
	
func movigxu(delta):
	direkto = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		direkto.x -= rapideco
	if Input.is_action_pressed("ui_right"):
		direkto.x += rapideco
	if Input.is_action_pressed("ui_up"):
		direkto.y -= rapideco
	if Input.is_action_pressed("ui_down"):
		direkto.y += rapideco
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()	
	
	direkto = direkto.normalized()
	
	#gravit procezo
	#reapliku tuj kiam la restajxoj funkcias perfekte!
	#
	#
	mov_gravito.y += gravito * delta
		
	#akcelado
	var fin_mov_rapido = direkto * rapideco * akcelado * delta
	mov_rapido = mov_rapido.linear_interpolate(fin_mov_rapido, 0.1)
	
	#kalkuli la mov_angulon
	mov_angulo = (get_global_position() - cel_planedo.get_global_position()).angle()
	
	var nelonga_angulo = rad2deg(mov_angulo)
	nelonga_angulo = nelonga_angulo + 90
	mov_angulo = deg2rad(nelonga_angulo)
	
	mov_rapido.y += mov_gravito.y
#	mov_rapido = mov_rapido.rotated(mov_angulo)
	var tangento = get_global_position() - cel_planedo.get_global_position()
	tangento = tangento.tangent()
	mov_rapido = mov_rapido.rotated(mov_angulo)

	#gisdatigu la linion
	linio.set_point_position(1, to_local(radio.get_collision_point()))

	mov_rapido = move_and_slide(mov_rapido,supren)
	print(mov_rapido)
		
func turnigxu(delta):
	#rivante la angulon en radianoj
	angulo = get_global_position().angle_to_point(cel_planedo.get_global_position())
#	angulo = rad2deg(angulo)
#	print(angulo, rad2deg(angulo))
#	set_rotation_degrees(rad2deg(angulo))
	var vektoro = cel_planedo.get_global_position() - get_global_position()
#	look_at(vektoro.reflect())
#	look_at(cel_planedo.get_global_position())
	set_rotation_degrees(rad2deg(angulo)+90)
	
func gxisdatigu_radion():
	radio.set_cast_to(radio.to_local(cel_planedo.get_global_position()))