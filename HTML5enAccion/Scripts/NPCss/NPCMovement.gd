extends KinematicBody2D

export var move_speed: float = 0
export var move_direction: Vector2 = Vector2(1, 0)

func _physics_process(delta):
	var velocity = move_direction.normalized() * move_speed
	move_and_slide(velocity)
