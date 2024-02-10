extends CanvasLayer

func _ready():
	if get_parent().name == "Nivel0":
		$Label.text = "Bienvenido al nivel 0  -Revisa todas las computadoras-"
	show_name()
	if get_parent().name == "CuartoInicio":
		$Label.text = "Bienvenido a la habitación de Tim Berners-Lee"
	show_name()
	if get_parent().name == "CiudadPrincipal":
		$Label.text = "Bienvenido a la ciudad central de Ginebra"
	show_name()
	if get_parent().name == "PrimerCuarto":
		$Label.text = "Bienvenido al hotel Geneva Centre -Revisa todas las computadoras-"
	show_name()
	if get_parent().name == "SegundoCuarto":
		$Label.text = "Bienvenido al Banco Nacional Suizo -Revisa todas las computadoras-"
	show_name()
	if get_parent().name == "TercerCuarto":
		$Label.text = "Bienvenido al Catillo del Mago Rudeus -Revisa todas las computadoras-"
	show_name()
	if get_parent().name == "Laberinto":
		$Label.text = "Bienvenido al laberinto del parque Beverin"
	show_name()
	if get_parent().name == "CuartoFinal":
		$Label.text = "Bienvenido al taller de herreria -Revisa todas las computadoras-"
	show_name()

func show_name():
	$AnimationPlayer.play("ShowName")
	yield($AnimationPlayer,"animation_finished")
	queue_free()
