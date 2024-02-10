extends Control


func _on_Instrucciones_pressed():
	if get_node_or_null('DialogNode') == null:
		get_tree().paused = true
		var dialog = Dialogic.start('Instrucciones')
		dialog.pause_mode = Node.PAUSE_MODE_PROCESS
		dialog.connect('timeline_end', self, 'unpause')
		$Instrucciones.visible = false
		$Instrucciones/Burbujapress.visible = false
		add_child(dialog)
		pass
func unpause(timeline_name):
	get_tree().paused = false
