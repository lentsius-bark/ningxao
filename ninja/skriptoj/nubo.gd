extends Sprite

var rapideco
var travideblo

func _ready():
	rapideco = randf()*0.3
	var videbleco = rand_range(0.1, 0.8)
	set_modulate(Color(1,1,1,videbleco))

func _process(delta):
	set_rotation(get_global_rotation() + rapideco * delta)