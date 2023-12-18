extends Node3D


var max_light_energy = 100000
var val = 0.0

@onready var l = $light


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	l.light_intensity_lux = val


func _on_light_slider_value_changed(value):
	#this is whe
	val = value*max_light_energy

