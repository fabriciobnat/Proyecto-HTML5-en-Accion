extends Node2D


func _ready():
	if !Global.disk_one:
		queue_free()


func _on_Area2D_body_entered(_body):
	$DiskSound.playing = true
	Global.counter_disk += 1
	Global.disk_one = false
	queue_free()
