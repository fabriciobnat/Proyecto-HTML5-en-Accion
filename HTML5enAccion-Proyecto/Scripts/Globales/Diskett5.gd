extends Node2D


func _ready():
	if self.name in Global.llave_founded:
		queue_free()


func _on_Area2D_body_entered(_body):
	Global.llave_founded.append(self.name)
	$DiskSound.playing = true
	if get_parent().has_method("key_collect"):
		get_parent().key_collect()
	if get_parent().get_parent().has_method("key_collect"):
		get_parent().get_parent().key_collect()
	queue_free()
