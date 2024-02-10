extends KinematicBody2D
var logica = preload("res://Scripts/NPCss/logica.gd").new()


var velocidad = 32
var movimiento = Vector2()
var play_dialogo = false

var arriba = false
var abajo = false
var derecha = false
var izquierda = false

var direction

func _ready():
	$AnimationPlayer.play("Frente")

func _process(delta):
	coliciones()
	movimiento = Vector2()
	if logica.mov_npc == false:
		match direction:
			0:
				if arriba == false:
					movimiento.y -= velocidad
					$Detencion.rotation_degrees = 0
					$AnimationPlayer.play("Espalda")
			1: 
				if abajo == false:
					movimiento.y += velocidad
					$Detencion.rotation_degrees = 180
					$AnimationPlayer.play("Frente")
			2:
				if izquierda == false:
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
	
	position += movimiento * delta

func coliciones():
	if $arriba.is_colliding():
		arriba = true
	elif not $arriba.is_colliding():
		arriba = false
	if $abajo.is_colliding():
		abajo = true
	elif not $abajo.is_colliding():
		abajo = false
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


func _on_Alain_area_entered(area):
	pass # Replace with function body.


func _on_Marc_area_entered(area):
	pass # Replace with function body.


func _on_Dave_area_entered(area):
	pass # Replace with function body.
