extends Area2D

func _on_Entrance_body_entered(_body):
# warning-ignore:return_value_discarded
	Global.from_level = get_parent().name
	Global.auto_move_direction = _body.direction
	get_tree().change_scene("res://Escenas/Mundos/" + self.name + ".tscn")
