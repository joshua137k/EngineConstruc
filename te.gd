extends MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var amesh =StandardMaterial3D.new()
	material_override=amesh


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
