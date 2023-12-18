extends Node3D

@onready var dir_light =get_parent().get_parent().get_node("light")

@onready var power_source = get_parent().get_node("powerSource")

var max_luminosity = 4.0
var border_value = 50.0	

var power = 0.0 # the power of the electrical current in watts

signal low_light
signal high_light

func set_border_value():
	pass

func _ready():
	connect("low_light",power_source.on_low_light)
	connect("high_light",power_source.on_high_light)

func _physics_process(delta):
	
	if dir_light.light_intensity_lux <border_value:
		emit_signal("low_light")
	else:
		emit_signal("high_light")
		
#	set_border_value()
#
#	if dir_light.environment.background_intensity>border_value:
#		emit_signal("low_light")
#	else:
#		emit_signal("high_light")
#
	

	
