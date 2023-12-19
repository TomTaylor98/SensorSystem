extends Node3D

#because the performance of light bulbs is usually predefined
var W = 100 #the power of the light bulb, in 
var R = 20
var V 
var is_current_flowing:bool = false

@onready var mesh = $mesh
@onready var light = $OmniLight3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	mesh.get_surface_override_material(0).emission_intensity = 0

func _physics_process(delta):
	
	if is_current_flowing:
		var P = V*V/R
		light.light_intensity_lumens = P
		mesh.get_surface_override_material(0).emission_intensity = P/4*PI*mesh.mesh.radius
	else:
		V = 0
		light.light_intensity_lumens = 0
		mesh.get_surface_override_material(0).emission_intensity = 0
		
	is_current_flowing = false

func on_current(v):
	V = v
	is_current_flowing = true
	
	
	
	
