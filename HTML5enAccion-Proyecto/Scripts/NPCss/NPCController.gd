extends Node


export var move_speed: float = 100
export var move_direction: Vector2 = Vector2(1, 0)  # Dirección del movimiento (ajusta según necesites)
var npc_nodes: Array = []

func _ready():
	# Buscar todos los nodos hijos con el script NPCMovement.gd
	for child in get_children():
		if child is KinematicBody2D and child.has_script("res://NPCMovement.gd"):
			npc_nodes.append(child)

func _process(delta):
	# Mover todos los NPCs en la dirección especificada
	for npc in npc_nodes:
		npc.move_direction = move_direction
		npc.move_speed = move_speed
