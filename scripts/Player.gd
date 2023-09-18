extends Node3D

class_name Player

@export var camera:Camera3D

var currentObject:PackedScene

var ghostObject:Node3D
var rotationY:float
var result

func _ready():
	pass


func _process(delta):
	handle_raycast()	
	handle_input()	
	handle_ghost(delta)
	pass
	
func handle_ghost(delta):
	if(ghostObject and result and result):
		var pos = result.position

		pos.y += 2
		
		ghostObject.visible = true
		ghostObject.position = ghostObject.position.lerp(pos, delta * 8)
		ghostObject.rotation_degrees = ghostObject.rotation_degrees.lerp(Vector3(0,rotationY,0), delta * 6)
	elif(ghostObject):
		ghostObject.visible = false
	pass

func change_current_object(newObject):
	currentObject = newObject
	if ghostObject:
		ghostObject.queue_free()
	ghostObject = newObject.instantiate()
	get_parent().add_child(ghostObject)
	pass

func handle_raycast():
	var space_state = get_world_3d().direct_space_state
	#Get Mouse Position 2D
	var mouse_position = get_viewport().get_mouse_position()
	#Get Ray
	var ray_origin = camera.project_ray_origin(mouse_position)
	var ray_end = ray_origin + camera.project_ray_normal(mouse_position) * 20000
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	result = space_state.intersect_ray(query)
	pass

func handle_input():
	if(Input.is_action_just_pressed("interact")):
		interact()
	if Input.is_action_just_pressed("rotateClock"):
		rotationY += 90
	elif Input.is_action_just_pressed("rotateCounterClock"):
		rotationY -= 90
	pass

func interact():
	print("Interact")
	if result and result.collider.has_method("place_object") and currentObject:
		result.collider.place_object(currentObject, rotationY)
	pass
