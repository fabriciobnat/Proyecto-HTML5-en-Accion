extends KinematicBody2D

var logica = preload("res://Scripts/NPCss/logica.gd").new()

var ACCELERATION = 8000000
var MAX_SPEED    = 300
var SPEED        = 20
var FRICTION     = 3000
var velocity     = Vector2.ZERO
var direction    = Vector2.DOWN
var state        = MOVE

var in_area      = null
signal player_g

enum{ MOVE, AUTOMOVE }

onready var animationPlayer = $AnimationPlayer
onready var animationTree   = $AnimationTree
onready var animationState  = animationTree.get("parameters/playback")

func get_inputs():
	velocity = Vector2()
	if Input.is_action_pressed("intro"):
		emit_signal("player_g", in_area)

func _ready():
	if get_parent().name == "TercerCuarto":
		$Luces.enabled = true
	if get_parent().name == "TercerCuarto":
		$Sombra.enabled = true
	if get_parent().name == "Laberinto":
		$Luces.enabled = true
	if get_parent().name == "Laberinto":
		$Sombra.enabled = true
	animationTree.active = true

func _process(delta):
	match state:
		MOVE:
			move_state(delta)
		AUTOMOVE:
			auto_move_state()

func move_state(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		direction = input_vector
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationState.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)

	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move()

func move():
	velocity = move_and_slide(velocity)

func auto_move():
	get_node("Timer").start()
	direction = Global.auto_move_direction
	state = AUTOMOVE

func auto_move_state():
	velocity = Global.auto_move_direction * SPEED
	animationTree.set("parameters/Run/blend_position" , Global.auto_move_direction )
	animationState.travel("Run")
	move()

func _on_Timer_timeout():
	animationTree.set("parameters/Idle/blend_position" , Global.auto_move_direction )
	animationState.travel("Idle")
	state = MOVE

func _unhandled_input(event):
	if event.is_action_pressed("intro"):
		emit_signal("player_g", in_area)
	pass

func _on_player_area_entered(area):
	if area.is_in_group("pc1"):
		in_area = area
		$"G-key".show()
	if area.is_in_group("Puerta"):
		in_area = area
		$"G-key".show()
	if area.is_in_group("Cientifico"):
		in_area = area
		$"G-key".show()
	if area.is_in_group("Avisos"):
		in_area = area
		$"G-key".show()
	pass

func _on_Area2D_area_exited(area):
	if area.is_in_group("pc1"):
		in_area = null
		$"G-key".hide()
	if area.is_in_group("Puerta"):
		in_area = null
		$"G-key".hide()
	if area.is_in_group("Cientifico"):
		in_area = null
		$"G-key".hide()
	if area.is_in_group("Avisos"):
		in_area = null
		$"G-key".hide()
	if area.is_in_group("npc"):
		logica.mov_npc = false
	pass







