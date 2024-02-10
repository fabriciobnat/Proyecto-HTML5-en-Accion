extends Node2D

var logica = preload("res://Scripts/NPCss/logica.gd").new()


var velocidad = 32
var movimiento = Vector2()
var play_dialogo = false

var arrib = false
var abaj = false
var derecha = false
var izquierda = false

var direction

func _ready():
	$AnimationPlayer.play("Frente")

func _process(_delta):
	coliciones()
	movimiento = Vector2()
	if logica.mov_npc == false:
		match direction:
			0:
				if arrib == false:
					movimiento.y -= velocidad
					$Detencion.rotation_degrees = 0
					$AnimationPlayer.play("Espalda")
			1: 
				if abaj == false:
					movimiento.y += velocidad
					$Detencion.rotation_degrees = 180
					$AnimationPlayer.play("Frente")
			2:
				if derecha == false:
					movimiento.x -= velocidad
					$Detencion.rotation_degrees = 270
					$AnimationPlayer.play("Izquierda")
			3:
				if derecha == false:
					movimiento.x += velocidad
					$Detencion.rotation_degrees = 90
					$AnimationPlayer.play("Derecha")
			4:
				if movimiento.length() > 0:
					movimiento = movimiento.normalized() * velocidad
	
	position += movimiento * _delta

func coliciones():
	if $arriba.is_colliding():
		arrib = true
	elif not $arriba.is_colliding():
		arrib = false
	if $abajo.is_colliding():
		abaj = true
	elif not $abajo.is_colliding():
		abaj = false
	if $izq.is_colliding():
		izquierda = true
	elif not $izq.is_colliding():
		izquierda = false
	if $der.is_colliding():
		derecha = true
	elif not $der.is_colliding():
		derecha = false

func _on_Timer_timeout():
	randomize()
	direction = int(rand_range(0, 5))
	print (direction)


func _on_Dan_area_entered(area):
	pass # Replace with function body.



func _on_Lou_area_entered(area):
	pass # Replace with function body.
