extends Node3D

@onready var dir_light =get_tree().root.get_node("Main").get_node("environment").get_node("DirectionalLight3D")
@onready var light_source = get_parent().get_node("lightSource")



func _physics_process(delta):
	if dir_light.light_energy <=2.0:
		light_source.light_energy = lerp(light_source.light_energy,2.0,0.01)
	else:
		light_source.light_energy =  lerp(light_source.light_energy,0.0,0.1)


