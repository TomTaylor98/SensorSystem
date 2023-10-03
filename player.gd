extends Node3D

var m_prevpos = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		pass

func _process(delta):
	var hor_dir = Input.get_axis("ui_right","ui_left")
	var ver_dir = Input.get_axis("ui_down","ui_up")
	rotate_y(hor_dir*10.0*delta)
	position += 5*delta*ver_dir*transform.basis.z
