extends CanvasLayer

func _ready():
	show_key()
	hide_key()
	delete_canvas()

func show_key():
	if "Door1" in Global.llave_founded and not "Door1" in Global.opened_doors:
		$Door1.visible = true
	if "Door2" in Global.llave_founded and not "Door2" in Global.opened_doors:
		$Door2.visible = true
	if "Door3" in Global.llave_founded and not "Door3" in Global.opened_doors:
		$Door3.visible = true
	if "Door4" in Global.llave_founded and not "Door4" in Global.opened_doors:
		$Door4.visible = true
	if "Door5" in Global.llave_founded and not "Door5" in Global.opened_doors:
		$Door5.visible = true
	if "Door6" in Global.llave_founded and not "Door6" in Global.opened_doors:
		$Door6.visible = true
	if "Door7" in Global.llave_founded and not "Door7" in Global.opened_doors:
		$Door7.visible = true
	if "Door8" in Global.llave_founded and not "Door8" in Global.opened_doors:
		$Door8.visible = true
	if "Door9" in Global.llave_founded and not "Door9" in Global.opened_doors:
		$Door9.visible = true
	if "Door10" in Global.llave_founded and not "Door10" in Global.opened_doors:
		$Door10.visible = true

func hide_key():
	if "Door1" in Global.opened_doors:
		$Door1.visible = false
	if "Door2" in Global.opened_doors:
		$Door2.visible = false
	if "Door3" in Global.opened_doors:
		$Door3.visible = false
	if "Door4" in Global.opened_doors:
		$Door4.visible = false
	if "Door5" in Global.opened_doors:
		$Door5.visible = false
	if "Door6" in Global.opened_doors:
		$Door6.visible = false
	if "Door7" in Global.opened_doors:
		$Door7.visible = false
	if "Door8" in Global.opened_doors:
		$Door8.visible = false
	if "Door9" in Global.opened_doors:
		$Door9.visible = false
	if "Door10" in Global.opened_doors:
		$Door10.visible = false


func delete_canvas():
	if "Door1" in Global.opened_doors and "Door2" in Global.opened_doors and "Door3" in Global.opened_doors and "Door4" in Global.opened_doors and "Door5" in Global.opened_doors and "Door6" in Global.opened_doors and "Door7" in Global.opened_doors and "Door8" in Global.opened_doors and "Door9" in Global.opened_doors and "Door10" in Global.opened_doors: 
		self.queue_free()
