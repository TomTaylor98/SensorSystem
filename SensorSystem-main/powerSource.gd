extends Node3D


@onready var bulb = get_parent().get_node("bulb")

var voltage = 230 #the voltage of the power source in volts

var is_light_low = false
var is_motion_detected = true

signal current(voltage)

func _ready():
	connect("current",bulb.on_current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	
	if is_light_low and is_motion_detected:
		set_block_signals(false)
	else:
		set_block_signals(true)
	
	emit_signal("current",voltage)
		
	
	

func on_low_light():
	is_light_low = true
	
func on_high_light():
	is_light_low = false
	
func on_motion_detected():
	is_motion_detected = true
	
