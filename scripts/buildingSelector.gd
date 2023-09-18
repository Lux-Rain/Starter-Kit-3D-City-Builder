extends Button

@export var building: PackedScene

@export var player: Player

func _pressed():
	player.change_current_object(building)
	pass
