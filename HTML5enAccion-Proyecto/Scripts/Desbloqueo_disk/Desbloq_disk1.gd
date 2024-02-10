extends Area2D

var active = false


func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _process(delta):
	pass




func unpause(timeline_name):
	get_tree().paused = false


func _on_NPC_body_entered(body):
	if body.name == 'Player':
		if get_node_or_null('DialogNode') == null:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-quiz-disk2')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
	active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
		queue_free()
