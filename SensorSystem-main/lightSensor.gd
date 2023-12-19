extends Node3D

@onready var dir_light =get_parent().get_parent().get_node("light")

@onready var power_source = get_parent().get_node("powerSource")
@onready var server = $Server


var border_value = 70.0	
var is_on:int

var power = 0.0 # the power of the electrical current in watts

signal low_light
signal high_light

func get_data():
	return PackedInt64Array([dir_light.light_intensity_lux,border_value,is_on])

func _ready():
	connect("low_light",power_source.on_low_light)
	connect("high_light",power_source.on_high_light)

func _physics_process(delta):
	
	if dir_light.light_intensity_lux <border_value:
		is_on = 1
		emit_signal("low_light")
	else:
		is_on = 0
		emit_signal("high_light")
	
	
		
