extends ColorRect

func _ready():
	$Intro.playing = true


func _on_AnimationPlayer_animation_finished(_anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Escenas/Munuindex.tscn")
