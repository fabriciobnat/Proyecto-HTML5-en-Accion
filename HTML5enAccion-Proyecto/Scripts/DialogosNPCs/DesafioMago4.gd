extends Area2D

var active = false
var disco = false


func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _process(delta):
	$Burbujapress.visible = active
	$YSort.visible = disco


func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("intro") and active:
			get_tree().paused = true
			var dialog = Dialogic.start('timeline-npc-DesafioMago4')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			disco = true
			$Door4.visible = true
			$Puertadisable4/Disable4.disabled = true
			add_child(dialog)


func unpause(timeline_name):
	get_tree().paused = false


func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true


func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
