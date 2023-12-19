extends Node3D

var prev_pos:Vector3 = Vector3.ZERO


var areas = {}
var is_area_entered

var motion_detected = false

@onready var power_source = get_parent().get_node("powerSource")

@onready var timer =$Timer

signal motion_detected_sig
signal timeout_for_motion_sensor

func _ready():
	connect("motion_detected_sig",power_source.on_motion_detected)
	connect("timeout_for_motion_sensor",power_source.on_timeout_for_motion_sensor)
	
	
func _physics_process(delta):
	
	if areas.size()>0:
		for a in areas.keys():
			
			if a.position != areas[a] and !motion_detected:
				motion_detected = true
				print(motion_detected)
				timer.start()
				emit_signal("motion_detected_sig")
			areas[a] = a.position
				
	
	
func _on_sensor_area_entered(area):
	
	if area not in areas.keys():
		areas[area] = area.position
		
func _on_sensor_area_exited(area):
	areas.erase(area)
	
	
func _on_timer_timeout():
	motion_detected = false
	print("timeout")
	emit_signal("timeout_for_motion_sensor")
	
