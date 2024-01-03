extends Control


func _ready():
	pass # Replace with function body.




func _on_AnimationPlayer_animation_started(anim_name):
	pass


func _on_NuevoJuego_pressed():
	get_tree().change_scene("res://Escenas/Munuindex.tscn")


func _on_Creditos_pressed():
	get_tree().change_scene("res://Escenas/Mundos/Creditos_Finales.tscn")


func _on_Salir_pressed():
	get_tree().quit()
