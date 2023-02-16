extends FPSController3D
class_name Player

## Example script that extends [CharacterController3D] through 
## [FPSController3D].
## 
## This is just an example, and should be used as a basis for creating your 
## own version using the controller's [b]move()[/b] function.
## 
## This player contains the inputs that will be used in the function 
## [b]move()[/b] in [b]_physics_process()[/b].
## The input process only happens when mouse is in capture mode.
## This script also adds submerged and emerged signals to change the 
## [Environment] when we are in the water.

@export var input_back_action_name := "move_backward"
@export var input_forward_action_name := "move_forward"
@export var input_left_action_name := "move_left"
@export var input_right_action_name := "move_right"
@export var input_sprint_action_name := "move_sprint"
@export var input_jump_action_name := "move_jump"
@export var input_crouch_action_name := "move_crouch"


@export var underwater_env: Environment


@onready var box = preload("res://base.tscn")
@onready var sphere = preload("res://sphere.tscn")
var nameobj=0
var is_colliding:bool
var objColliding

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	setup()
	emerged.connect(_on_controller_emerged.bind())
	submerged.connect(_on_controller_subemerged.bind())
	fly_ability.set_active(not fly_ability.is_actived())


func _physics_process(delta):
	var is_valid_input := Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	is_colliding= $Head/Camera/RayCast3D.is_colliding()
	if is_colliding:
		objColliding=$Head/Camera/RayCast3D.get_collider()
	if is_valid_input:
		
		var input_axis = Input.get_vector(input_back_action_name, input_forward_action_name, input_left_action_name, input_right_action_name)
		var input_jump = Input.is_action_just_pressed(input_jump_action_name)
		var input_crouch = Input.is_action_pressed(input_crouch_action_name)
		var input_sprint = Input.is_action_pressed(input_sprint_action_name)
		var input_swim_down = Input.is_action_pressed(input_crouch_action_name)
		var input_swim_up = Input.is_action_pressed(input_jump_action_name)
		move(delta, input_axis, input_jump, input_crouch, input_sprint, input_swim_down, input_swim_up)
	else:
		# NOTE: It is important to always call move() even if we have no inputs 
		## to process, as we still need to calculate gravity and collisions.
		move(delta)


func _input(event: InputEvent) -> void:
	# Mouse look (only if the mouse is captured).
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_head(event.relative)
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			


func _on_controller_emerged():
	camera.environment = null


func _on_controller_subemerged():
	camera.environment = underwater_env


func create_obj(type):
	#0-box  1-circle

	
	nameobj+=1
	match(type):
		0:
			
			var obj=box.instantiate()
			obj.set_name(str(nameobj))
			obj.position = $Head/Camera/Marker3D.global_position
			get_parent().call_deferred("add_child",obj)
		1:
			var obj=sphere.instantiate()
			obj.set_name(str(nameobj))
			obj.position = $Head/Camera/Marker3D.global_position
			get_parent().call_deferred("add_child",obj)

func boxvisible():
	$Head/Camera/Marker3D/MeshInstance3D.visible=!$Head/Camera/Marker3D/MeshInstance3D.visible
