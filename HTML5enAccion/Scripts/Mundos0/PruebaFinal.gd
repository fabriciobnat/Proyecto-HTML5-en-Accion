extends Control

var questions = ["¿Cuál es la etiqueta HTML5 que se utiliza para definir el comienzo de un documento HTML5 válido?",
				"¿Cuál es el elemento HTML5 utilizado para crear un titulo principal en una página web?",
				"¿Cuál es el elemento HTML5 utilizado para marcar el texto como enfatizado o destacado?",
				"¿Cuál es el elemento HTML5 utilizado para crear una lista ordenada?",
				"¿Cuál es el elemento HTML5 utilizado para crear hipervínculos en una página web?",
				"¿Cuál es el elemento HTML5 utilizado para insertar imágenes en una página web?"]

var options = [["Escribe tu respuesta:"],
			   ["Escribe tu respuesta:"],
			   ["Escribe tu respuesta:"],
			   ["Escribe tu respuesta:"],
			   ["a. <url>", "b. <link>", "c. <a>", "d. <href>"],
			   ["a. <image>", "b. <picture>", "c. <photo>", "d. <img>"]]


var tiempo_restante = 300  # Establece el tiempo límite en segundos
var tiempo_transcurrido = 0  # Inicializa el tiempo transcurrido en cero

var answers = ["<!doctype html>", "<h1>", "<em>", "<ol>", "<a>", "<img>"]
var currentQuestion = 0
var score = 0

onready var questionLabel: Label = $QuestionLabel
onready var optionsLabel: Label = $OptionsLabel
onready var answerTextEdit: TextEdit = $AnswerTextEdit
onready var nextButton: Button = $NextButton
onready var restartButton: Button = $RestartButton
onready var messageLabel: Label = $MessageLabel
onready var label_tiempo: Label = $TiempoLabel


var minimumCorrectAnswers = 5
var correctAnswersCount = 0

func _ready():
	label_tiempo.text = "Tiempo restante: " + str(tiempo_restante)
	displayQuestion()

func _process(delta):
	tiempo_transcurrido += delta

	# Calcula el tiempo restante
	var tiempo_actual = tiempo_restante - tiempo_transcurrido

	# Asegúrate de que el tiempo no sea negativo
	if tiempo_actual < 0:
		tiempo_actual = 0

	# Actualiza la etiqueta con el tiempo restante
	label_tiempo.text = "Tiempo restante: " + str(round(tiempo_actual))

	# Comprueba si se ha agotado el tiempo
	if tiempo_actual == 0:
		# Aquí puedes tomar acciones cuando se agote el tiempo, como reiniciar el juego
		tiempo_agotado()



func displayQuestion():
	if currentQuestion < questions.size():
		questionLabel.text = questions[currentQuestion]
		optionsLabel.text = "\n".join(options[currentQuestion])
		answerTextEdit.text = ""
		nextButton.disabled = false
		restartButton.visible = false
	else:
		questionLabel.text = "Evaluación completada"
		optionsLabel.text = ""
		answerTextEdit.text = ""
		answerTextEdit.visible = false
		nextButton.visible = false
		if correctAnswersCount >= minimumCorrectAnswers:
			messageLabel.text = "Puntaje final: %d de %d.\n¡Felicidades!" % [score, questions.size()]
			messageLabel.modulate = Color(0.0, 1.0, 0.0)  # Color verde
			restartButton.visible = false
			yield(get_tree().create_timer(4.0), "timeout")  # Espera 3 segundos
			get_tree().change_scene("res://Escenas/Mundos/Creditos.tscn")
		else:
			messageLabel.text = "Mínimo de respuestas válidas acertadas:  %d de %d.  \n Inténtalo otra vez!" % [score, questions.size()]
			messageLabel.modulate = Color(1.0, 0.0, 0.0)  # Color rojo
			restartButton.visible = true


func _on_AnswerTextEdit_text_changed(new_text):
	nextButton.disabled = false
	pass

func _on_NextButton_pressed():
	if currentQuestion < questions.size():
		var userAnswer = answerTextEdit.text.strip_edges()
		if userAnswer != "":
			if userAnswer == answers[currentQuestion]:
				score += 1
				correctAnswersCount += 1
				messageLabel.text = "CORRECTO"
				messageLabel.modulate = Color(0.0, 1.0, 0.0)  # Color verde
				# Reproduce el sonido de éxito
				$AudioSucces.play()
			else:
				messageLabel.text = "INCORRECTO"
				messageLabel.modulate = Color(1.0, 0.0, 0.0)  # Color rojo
				# Reproduce el sonido de error
				$AudioWrong.play()
			currentQuestion += 1
			displayQuestion()
		else:
			messageLabel.text = "Por favor, ingresa una respuesta antes de continuar."
			$AudioWrong.play()
			messageLabel.modulate = Color(1.0, 0.0, 0.0) # Color rojo
	else:
		nextButton.visible = false



func _on_RestartButton_pressed():
	currentQuestion = 0
	score = 0
	correctAnswersCount = 0
	displayQuestion()
	answerTextEdit.visible = true
	nextButton.visible = true 



func tiempo_agotado():
	# Reiniciar variables del juego
	currentQuestion = 0
	score = 0
	correctAnswersCount = 0

	# Mostrar un mensaje de reinicio o realizar otras acciones necesarias
	label_tiempo.text = "Tiempo agotado. El juego se ha reiniciado."
	label_tiempo.modulate = Color(1.0, 1.0, 1.0)  # Cambia el color del mensaje a blanco

	# Reiniciar la escena principal
	get_tree().change_scene("res://Escenas/Mundos/Reiniciar.tscn")




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


