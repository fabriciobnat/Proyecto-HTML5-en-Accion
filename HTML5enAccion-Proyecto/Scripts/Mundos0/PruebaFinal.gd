extends Control

var playerName: String = ""  # Almacena el nombre del jugador

var questions = ["¿Cuál es la etiqueta HTML5 que se utiliza para definir el comienzo de un documento HTML5 válido?",
				"¿Cuál es el elemento HTML5 utilizado para crear un título principal en una página web?",
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
var tiempo_detenido = false  # Variable para controlar si el tiempo se ha detenido

var answers = ["<!doctype html>", "<h1>", "<em>", "<ol>", "<a>", "<img>"]
var currentQuestion = 0
var score = 0

onready var questionLabel: Label = $QuestionLabel
onready var optionsLabel: Label = $OptionsLabel
onready var answerTextEdit: TextEdit = $AnswerTextEdit
onready var nameTextEdit: TextEdit = $NameTextEdit  # Nuevo campo de texto para el nombre
onready var iniciarButton: Button = $IniciarButton  # Nuevo botón para iniciar la evaluación
onready var nextButton: Button = $NextButton
onready var restartButton: Button = $RestartButton
onready var finishButton: Button = $FinishButton
onready var messageLabel: Label = $MessageLabel
onready var label_tiempo: Label = $TiempoLabel

var minimumCorrectAnswers = 5
var correctAnswersCount = 0

func _ready():
	label_tiempo.text = "Tiempo restante: " + str(tiempo_restante)
	hideElements()

func hideElements():
	questionLabel.hide()
	optionsLabel.hide()
	answerTextEdit.hide()
	restartButton.hide()
	finishButton.hide()
	messageLabel.hide()
	label_tiempo.hide()
	nextButton.hide()  # Ocultar el botón "Siguiente" inicialmente

func _process(delta):
	if !tiempo_detenido:
		tiempo_transcurrido += delta
		var tiempo_actual = tiempo_restante - tiempo_transcurrido
		if tiempo_actual < 0:
			tiempo_actual = 0
		label_tiempo.text = "Tiempo restante: " + str(round(tiempo_actual))
		if tiempo_actual == 0:
			tiempo_agotado()

func _on_NameTextEdit_text_changed(new_text):
	playerName = nameTextEdit.text.strip_edges()
	if playerName != "":
		iniciarButton.disabled = false
	else:
		iniciarButton.disabled = true

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
			messageLabel.text = "Puntaje final: %d de %d.\n¡Felicidades, %s!" % [score, questions.size(), playerName]
			messageLabel.modulate = Color(0.0, 1.0, 0.0)  # Color verde
			finishButton.visible = true
			restartButton.visible = false
			tiempo_detenido = true  # Detener el tiempo al finalizar la prueba
		else:
			messageLabel.text = "Mínimo de respuestas válidas acertadas:  %d de %d.  \n Inténtalo otra vez!" % [score, questions.size()]
			messageLabel.modulate = Color(1.0, 0.0, 0.0)  # Color rojo
			finishButton.visible = false
			restartButton.visible = true

func _on_IniciarButton_pressed():
	playerName = nameTextEdit.text.strip_edges()
	if playerName != "":
		$DatosLabel.visible = false
		messageLabel.text = "BIENVENIDO, %s" % playerName
		messageLabel.modulate = Color(1.0, 2.0, 0.0)  # Color verde
		showElements()
		startTimer()
		displayQuestion()  # Mostrar la primera pregunta al iniciar

func showElements():
	questionLabel.show()
	optionsLabel.show()
	answerTextEdit.show()
	label_tiempo.show()
	nameTextEdit.hide()
	iniciarButton.hide()
	nextButton.show()
	messageLabel.show()

func startTimer():
	tiempo_detenido = false

func _on_NextButton_pressed():
	if currentQuestion < questions.size():
		var userAnswer = answerTextEdit.text.strip_edges()
		if userAnswer != "":
			if userAnswer == answers[currentQuestion]:
				score += 1
				correctAnswersCount += 1
				messageLabel.text = "CORRECTO"
				messageLabel.modulate = Color(0.0, 1.0, 0.0)  # Color verde
				$AudioSucces.play()
			else:
				messageLabel.text = "INCORRECTO"
				messageLabel.modulate = Color(1.0, 0.0, 0.0)  # Color rojo
				$AudioWrong.play()
			currentQuestion += 1
			displayQuestion()
		else:
			messageLabel.text = "Por favor, ingresa una respuesta antes de continuar."
			$AudioWrong.play()
			messageLabel.modulate = Color(1.0, 0.0, 0.0)  # Color rojo
	else:
		nextButton.hide()  # Ocultar el botón "Siguiente" al finalizar

func _on_RestartButton_pressed():
	currentQuestion = 0
	score = 0
	correctAnswersCount = 0
	tiempo_detenido = false  # Reiniciar el estado del tiempo detenido
	displayQuestion()
	answerTextEdit.visible = true
	nextButton.visible = true

func _on_FinishButton_pressed():
	get_tree().change_scene("res://Escenas/Mundos/Creditos.tscn")

func tiempo_agotado():
	currentQuestion = 0
	score = 0
	correctAnswersCount = 0
	label_tiempo.text = "Tiempo agotado. El juego se ha reiniciado."
	label_tiempo.modulate = Color(1.0, 1.0, 1.0)  # Cambia el color del mensaje a blanco
	get_tree().change_scene("res://Escenas/Mundos/Reiniciar.tscn")
