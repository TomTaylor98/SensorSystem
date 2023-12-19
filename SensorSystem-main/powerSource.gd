extends Node3D


@onready var bulb = get_parent().get_node("bulb")

var voltage = 230 #the voltage of the power source in volts

var is_current_blocked = false

var mo_block = true
var li_block = true

signal current(voltage)

func _ready():
	connect("current",bulb.on_current)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	is_current_blocked = false
	
	if mo_block or li_block:
		is_current_blocked = true
		
	if !is_current_blocked:
		set_block_signals(false)
	else:
		set_block_signals(true)
	
	emit_signal("current",voltage)
		
	
	

func on_low_light():
	li_block = false
	
	
func on_high_light():
	li_block = true
	
func on_motion_detected():
	#is_current_blocked= false
	mo_block = false

func on_timeout_for_motion_sensor():
	mo_block = true
	
