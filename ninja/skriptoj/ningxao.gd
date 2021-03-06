extends KinematicBody2D

const gravito = 9.8 * 3
var direkto = Vector2()
var mov_rapido = Vector2()
var mov_gravito = Vector2()

#la direkto de la surfaco
var supren = Vector2()

#angulo inter la ludato kaj la planedo
var angulo = 0
var mov_angulo = 0

const rapideco = 100
const saltforteco = 1400
var akcelado = 3

#variablo por la listo de planedoj
var planedoj = []
var planeddistancoj = []

#tiu ci variablo estas la radio kiu kontrolas la planedsurfacan direkton
onready var radio = $radi_elsendo
onready var radidua = $radi_elsendo_dua

#la sonludilo por la sono de vento
onready var vento = $ventsono

# tiu ĉi variablo enhavos la planedon al kiu ni volos flugi
var cel_planedo

var vivpoentoj = 100

var duobla_salto = 1
var terkomenco = 0

#gxeneralaj signaloj
signal aperi()
signal malaperi()

#variabloj por sxaltado
onready var sxalttempilo = $sxalttempilo
var povas_sxalti = 0
var sxaltobjekto
signal sxaltante(maksimumo, progreso)
signal sxaltinte()

func _ready():
	planedoj.append($"../planedo")
	if planedoj.size() == 0:
		print("Oni ne trovis planedojn en la gepatra nodo. Bonvolu aldoni almenau unu por korekta funkcio de la ludo")
	else:
		print("Sukcese aldonis planedon")
		cel_planedo = planedoj[0]

func _process(delta):
	#ni agordas la unuan momenton kiam la ludato tusxas la teron denove post kiam ri saltis.
	if terkomenco == 1:
		if is_on_floor():
			duobla_salto = 1
			terkomenco = 0
	
	#kontroli kiom for estas la planedoj kaj se iu estas pli proksime ol la unua, iru tien!
	planedkontrolo()
	#agordi la lautecon de la sono de vento
	ventego()
	
	#se ni povas sxalti ion, faru!
	if povas_sxalti == 1:
		sxaltado()
	
	#por ke ni ciam sciu kio estas la supra vektoro lau la surfaco de la planedo
	if radio.is_colliding():
		supren = radio.get_collision_normal()
	else:
		print("ne estas planedo")
	if Input.is_action_just_pressed("ui_accept"):
		cel_planedo = planedoj[1]

	#la ludato estas turnita
	turnigxu(delta)
	#la radio kiu pafas al la direkto de la planedo kiu estas aktiva
	gxisdatigu_radion()
	
func _physics_process(delta):
	movigxu(delta)

func sxaltado():
	if Input.is_action_pressed("uzi") and sxaltobjekto != null:
		if sxalttempilo.is_stopped():
			sxalttempilo.set_wait_time(sxaltobjekto.sxalttempo)
			sxalttempilo.start()
			emit_signal("aperi")
		emit_signal("sxaltante", sxaltobjekto.sxalttempo, sxalttempilo.get_wait_time() - sxalttempilo.get_time_left())
		
	if Input.is_action_just_released("uzi") and !sxalttempilo.is_stopped():
		sxalttempilo.stop()
		emit_signal("malaperi")

func planedkontrolo():
	if planedoj.size() > 1:
		radidua.set_cast_to(to_local(planedoj[-1].get_global_position()))
		
		if get_global_position().distance_to(radio.get_collision_point()) > get_global_position().distance_to(radidua.get_collision_point()):
			cel_planedo = planedoj[-1]
			planedoj.invert()
	elif planedoj.size() == 1:
		radidua.set_enabled(0)
		cel_planedo = planedoj[0]
	elif planedoj.size() == 0:
		radidua.set_enabled(0)
		print("ne estas planedoj cxirkaue")
	
func movigxu(delta):
	direkto = Vector2()
	
	#var dekstren = radio.get_collision_normal().tangent()
	var dekstren = (get_global_position() - cel_planedo.get_global_position()).tangent().normalized()
	
	if Input.is_action_pressed("ui_left"):
		direkto = dekstren * rapideco
	if Input.is_action_pressed("ui_right"):
		direkto = -dekstren * rapideco
	if Input.is_action_pressed("ui_cancel"):
		get_tree().quit()	
	
#	direkto = direkto.normalized()

	#saltado
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		direkto += radio.get_collision_normal() * saltforteco
	elif Input.is_action_just_pressed("ui_up") and !is_on_floor():
		if duobla_salto == 1:
			direkto += radio.get_collision_normal() * saltforteco
			duobla_salto = 0
			terkomenco = 1

	#akcelado
	var fin_mov_rapido = direkto * akcelado
	mov_rapido = mov_rapido.linear_interpolate(fin_mov_rapido, 0.14)
		
	#apliki graviton
	mov_rapido += -radio.get_collision_normal() * gravito

	mov_rapido = move_and_slide(mov_rapido,supren)
		
func turnigxu(delta):
	#trovante la angulon en radianoj
	angulo = get_global_position().angle_to_point(radio.get_collision_point())
	var vektoro = cel_planedo.get_global_position() - get_global_position()
	set_rotation_degrees(rad2deg(angulo)+90)
	
func gxisdatigu_radion():
	radio.set_cast_to(radio.to_local(cel_planedo.get_global_position()))

func _on_Area2D_body_entered(body):
	if body.is_in_group("planedoj") and !planedoj.has(body):
		planedoj.append(body)
		if planedoj.size() > 1:
			radidua.set_enabled(1)

func _on_Area2D_body_exited(body):
	if body.is_in_group("planedoj") and planedoj.size() > 1:
		if planedoj.has(body):
			var id = planedoj.find(body)
			planedoj.remove(id)

func padsalto(forteco):
	mov_rapido += radio.get_collision_normal() * forteco

func ventego():
	var vent_lauteco = (mov_rapido.length() / 300) * -20
	if vent_lauteco < -30:
		vent_lauteco = -30
	vento.set_volume_db(vent_lauteco*-1)
	
func _on_ventsono_finished():
	vento.play(0.1)
	
func sxaltebligi(objekto):
	#sendi informon al la GUI ke ni povas sxalti ion
	emit_signal("aperi")
	#agordi propran variablon pri sxaltado kaj la objekto
	povas_sxalti = 1
	sxaltobjekto = objekto

func malsxaltebligi(objekto):
	if sxaltobjekto == objekto:
		emit_signal("malaperi")
		povas_sxalti = 0
		sxaltobjekto = null

func _on_sxalttempilo_timeout():
	if sxaltobjekto != null:
		emit_signal("malaperi")
		emit_signal("sxaltinte")
		sxaltobjekto.sxalti()
		povas_sxalti = 0
		sxaltobjekto = null
