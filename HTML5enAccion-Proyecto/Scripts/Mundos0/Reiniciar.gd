extends Control


func _ready():
	var animationPlayer = $AnimationPlayer
	animationPlayer.play("Letras")


func _on_Button_pressed():
	get_tree().change_scene("res://Escenas/Mundos/PruebaFinal.tscn")
