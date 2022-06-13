# script: pipe

extends Area2D

const DAYNIGT_STATE_FILE_PATH = "user://daynightstate_data.save"

func _ready():
	var day = true
	var day_file = File.new()

	if day_file.file_exists(DAYNIGT_STATE_FILE_PATH):
		day_file.open(DAYNIGT_STATE_FILE_PATH, File.READ)
		day = day_file.get_var()
		day_file.close()

		if str(day) == "Null":
			day = true

	else:
		day_file.open(DAYNIGT_STATE_FILE_PATH, File.WRITE)
		day_file.store_var(day)
		day_file.close()


	if not day:
		$NightPipeSprite.show()
		$DayPipeSprite.hide()
	




