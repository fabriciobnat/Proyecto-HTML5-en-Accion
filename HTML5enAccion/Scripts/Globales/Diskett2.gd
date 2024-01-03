extends Node2D


func _ready():
	if !Global.disk_two:
		queue_free()


func _on_Area2D_body_entered(_body):
	Global.counter_disk += 1
	Global.disk_two = false
	queue_free()
