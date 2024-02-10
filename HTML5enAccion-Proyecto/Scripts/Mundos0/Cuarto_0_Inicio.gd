extends Node2D

onready var Canvas = preload("res://Escenas/Disketts/KeyCanvas.tscn")

var disk: int = 0

func _ready():
	if Global.from_level != null:
		get_node("Player").set_position(get_node(Global.from_level + "Pos").position)
		get_node("Player").auto_move()

	key_collect()
	Global.current_level = self.name

func key_collect():
	if Global.llave_founded != []:
		if not has_node("KeyCanvas"):
			var canvas = Canvas.instance()
			add_child(canvas)
		else:
			get_node("KeyCanvas").show_key()
