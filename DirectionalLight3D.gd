extends DirectionalLight3D

var max_light_energy = 10
var min_light_energy = 1
var time_passed = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_passed += delta
	var tmp  = sin(time_passed/2)*max_light_energy
	if tmp>=0.5:
		light_energy = tmp
	else:
		pass
