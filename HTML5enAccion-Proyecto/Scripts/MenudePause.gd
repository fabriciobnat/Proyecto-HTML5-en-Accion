extends Node2D

var dialogInProcess = false  # Agrega esta variable para rastrear si el diálogo del NPC está en curso

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("esc"):
		if dialogInProcess:
			# Si el diálogo está en curso, no cambies el estado del juego ni del menú de pausa
			return

		get_tree().paused = not get_tree().paused
		$CanvasLayer/AudioStreamPlayer.play()
		$CanvasLayer.visible = not $CanvasLayer.visible

func _on_btn_regresar_pressed():
	if dialogInProcess:
		# Si el diálogo está en curso, no cambies el estado del juego ni del menú de pausa
		return

	get_tree().paused = not get_tree().paused
	$CanvasLayer/AudioStreamPlayer.play()
	$CanvasLayer.visible = not $CanvasLayer.visible

func _on_btn_salir_pressed():
	get_tree().quit()

var master_bus = AudioServer.get_bus_index("Master")

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(master_bus, value)

	if value == -30:
		AudioServer.set_bus_mute(master_bus, true)
	else:
		AudioServer.set_bus_mute(master_bus, false)

