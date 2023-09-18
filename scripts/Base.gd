extends StaticBody3D

var currentObject:Node3D

var goalPosition

func place_object(scene, rotationY):
	if currentObject :
		currentObject.queue_free()
	print("Interact with Base")
	currentObject = scene.instantiate()
	goalPosition = position
	goalPosition.y += 0.1
	currentObject.position = position
	currentObject.position.y += 2
	currentObject.rotation_degrees.y = rotationY
	add_child(currentObject)
pass

func _process(delta):
	if(currentObject):
		currentObject.position = currentObject.position.lerp(goalPosition, delta * 6)
pass

func get_pos() -> Vector3 :
	return position

