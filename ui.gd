extends Control

@export var Playerr:CharacterBody3D
# Called when the node enters the scene tree for the first time.
@onready var posX=get_node("Panel/VBoxContainer/X")
@onready var posY=get_node("Panel/VBoxContainer/Y")
@onready var posZ=get_node("Panel/VBoxContainer/Z")
@onready var SizeX=get_node("Panel/VBoxContainer/SizeX")
@onready var SizeY=get_node("Panel/VBoxContainer/SizeY")
@onready var SizeZ=get_node("Panel/VBoxContainer/SizeZ")
@onready var rotx=get_node("Panel/VBoxContainer/Rotx")
@onready var roty=get_node("Panel/VBoxContainer/RotY")
@onready var rotz=get_node("Panel/VBoxContainer/RotZ")
var col=true


var node
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PlayerPos.text="Pressione em ESC para liberar o mouse"+str(Playerr.position)
	
	if Playerr.objColliding!=null:
		var nod = get_parent().get_node(Playerr.objColliding.get_path())

			
			#Set HScrollbar value
		if node!=nod:
			posX.get_node("value").text=str(nod.position.x)
			posY.get_node("value").text=str(nod.position.y)
			posZ.get_node("value").text=str(nod.position.z)
			SizeX.get_node("value").text=str(nod.scale.x)
			SizeY.get_node("value").text=str(nod.scale.y)
			SizeZ.get_node("value").text=str(nod.scale.z)
			rotx.get_node("value").text=str(nod.rotation_degrees.x)
			roty.get_node("value").text=str(nod.rotation_degrees.y)
			rotz.get_node("value").text=str(nod.rotation_degrees.z)
			$Panel/ColorPicker.color=nod.get_node("MeshInstance3D").material_override.albedo_color
			node=nod
			
		
		nod.position.x=int(posX.get_node("value").text)
		nod.position.y=int(posY.get_node("value").text)
		nod.position.z=int(posZ.get_node("value").text)
		nod.scale.x=int(SizeX.get_node("value").text)
		nod.scale.y=int(SizeY.get_node("value").text)
		nod.scale.z=int(SizeZ.get_node("value").text)
		nod.rotation_degrees.x=int(rotx.get_node("value").text)
		nod.rotation_degrees.y=int(roty.get_node("value").text)
		nod.rotation_degrees.z=int(rotz.get_node("value").text)
		
		nod.get_node("MeshInstance3D").material_override.albedo_color=$Panel/ColorPicker.color


	if Input.is_action_just_pressed("ui_cancel"):
		$Panel.visible=false
		$create2.visible=false
		
		
	
	


func _on_create_pressed():
	Playerr.boxvisible()
	$Panel.visible=false
	$create2.visible=true


func _on_axis_pressed():
	Playerr.boxvisible()
	$Panel.visible=true
	$create2.visible=false


func _on_box_pressed():
	Playerr.create_obj(0)


func _on_circulo_pressed():
	Playerr.create_obj(1)
