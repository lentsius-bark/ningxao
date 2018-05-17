extends AudioStreamPlayer

var kuranta = false

func _process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		kuranta = true
	else: kuranta = false

	if kuranta == true and !is_playing() and get_parent().is_on_floor():
		play(0.1)