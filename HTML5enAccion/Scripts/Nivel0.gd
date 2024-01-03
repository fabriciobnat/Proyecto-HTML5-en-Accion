extends Node2D


func _on_Player_player_g(area):
	if area != null:
		area.inspect()
