extends Node3D

@export_group("Zoom")
@export var zoom_minimum = 16
@export var zoom_maximum = 4
@export var zoom_speed = 10

@export_group("Rotation")
@export var rotation_speed = 120


@onready var camera:Camera3D = $Camera

var zoom = 10
var camera_rotation


func _ready():
	camera_rotation = rotation_degrees
	pass # Replace with function body.


func _process(delta):
	rotation_degrees = rotation_degrees.lerp(camera_rotation, delta * 6)
	camera.position = camera.position.lerp(Vector3(0, 0, zoom), 8 * delta)
	handle_input(delta)
	pass
	
func handle_input(delta):
	
	var input = Vector3.ZERO
	
	input.y = Input.get_axis("camera_left", "camera_right")
	input.x = Input.get_axis("camera_up", "camera_down")
	
	camera_rotation += input * rotation_speed * delta
	camera_rotation.x = clamp(camera_rotation.x, -80, -10)
	
	zoom += Input.get_axis("zoom_in", "zoom_out") * zoom_speed * delta
	zoom = clamp(zoom, zoom_maximum, zoom_minimum)
	pass
