extends KinematicBody2D

signal player_g
export (int) var speed = 400
onready var _animation: =$AnimatedSprite
var velocity = Vector2.ZERO
var in_area = null



func get_inputs():
	velocity = Vector2()
	if Input.is_action_pressed("intro"):
		emit_signal("player_g", in_area)

func _physics_process(delta):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	) 
	
	if direction.length() == 0:
		_animation.stop()
	else:
		if direction.length() > 1.0 and direction[0] == 1:
			_animation.play("right")
			direction = direction.normalized()
		elif direction.length() > 1.0 and direction[0] == -1:
			_animation.play("left")
			direction = direction.normalized()
		else:
			if direction[1] == 1:
				_animation.play("down")
			if direction[1] == -1:
				_animation.play("up")
			if direction[0] == 1:
				_animation.play("right")
			if direction[0] == -1:
				_animation.play("left")        
	move_and_slide(speed * direction)

func _unhandled_input(event):
	if event.is_action_pressed("intro"):
		emit_signal("player_g", in_area)

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
		
func _on_player_area_exited(area):
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



func _on_Player_player_g(area):
	if area != null:
		area.inspect()
