extends KinematicBody2D


func _ready():
	$Area2D.connect("body_entered", self, "_on_PlayerEntered")
	$Area2D.connect("body_exited", self, "_on_PlayerExited")

func _on_PlayerEntered(body):
	if body.name == "Player":  # Asume que el jugador tiene un nombre "Player" (ajusta esto según tu proyecto)
		# Iniciar la animación de movimiento del NPC aquí
		var animationPlayer = $AnimationPlayer
		animationPlayer.play("Idle")
		$AnimatedSprite.visible = true


func _on_PlayerExited(body):
	if body.name == "Player":
		# Detener la animación de movimiento del NPC aquí
		var animationPlayer = $AnimationPlayer
		animationPlayer.play("RESET")
		$AnimatedSprite.visible = false

