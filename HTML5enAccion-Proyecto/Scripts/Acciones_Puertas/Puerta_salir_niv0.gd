extends Area2D

var active = false
var dialogInProcess = false  # Agrega esta variable para rastrear si el diálogo está en curso

func _ready():
	connect("body_entered", self, '_on_NPC_body_entered')
	connect("body_exited", self, '_on_NPC_body_exited')

func _input(event):
	if get_node_or_null('DialogNode') == null:
		if event.is_action_pressed("intro") and active and not dialogInProcess:  # Verifica si el diálogo no está en curso
			get_tree().paused = false
			var dialog = Dialogic.start('SalirNiv0')
			dialog.pause_mode = Node.PAUSE_MODE_PROCESS
			dialog.connect('timeline_end', self, 'unpause')
			add_child(dialog)
			dialogInProcess = true  # Marca que el diálogo está en curso

func unpause(timeline_name):
	dialogInProcess = false  # Marca que el diálogo ha terminado

func _on_NPC_body_entered(body):
	if body.name == 'Player':
		active = true

func _on_NPC_body_exited(body):
	if body.name == 'Player':
		active = false
