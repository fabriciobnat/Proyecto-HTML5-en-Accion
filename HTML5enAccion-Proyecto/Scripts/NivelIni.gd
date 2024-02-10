extends Control
#Variables de entrada
var videoPlayer: VideoPlayer
var audioStreamPlayer: AudioStreamPlayer
var videoIndex: int = 0
var videoPaths: Array = ["res://Multimedia/Videos/html5.ogv", "res://Multimedia/Videos/html5ini2.ogv"]# Agrega aquí las rutas a tus videos
var audioPaths: Array = ["res://Multimedia/Audios/Teclas.wav", "res://Multimedia/Audios/InicioHistoria.wav"]
var isAudioPaused: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	videoPlayer = $VideoPlayer
	audioStreamPlayer = $AudioStreamPlayer
	load_and_play()

func load_and_play():
	videoPlayer.set_stream(load(videoPaths[videoIndex]))
	audioStreamPlayer.stream = load(audioPaths[videoIndex])
	videoPlayer.play()
	audioStreamPlayer.play()

func _on_Button_pressed():
	videoIndex += 1
	if videoIndex < videoPaths.size():
		load_and_play()
	else:
		get_tree().change_scene("res://Escenas/InicioJuego.tscn")



func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		audioStreamPlayer.stop()
		isAudioPaused = true
	else:
		audioStreamPlayer.play()
		isAudioPaused = false
