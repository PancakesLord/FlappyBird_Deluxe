# script: GameMenu

extends Control

const BIRD_COLOR_FILE_PATH = "user://bird_data.save"
const DAYNIGT_STATE_FILE_PATH = "user://daynightstate_data.save"
const SFX_VOLUME_FILE_PATH = "user://sfxvolume_data.save"
const MUSIC_VOLUME_FILE_PATH = "user://musicvolume_data.save"


onready var day = true

onready var list_index = 0
const ANIMATION_LIST = ["yellow", "blue", "red"]

func _ready():


	var bird_file = File.new()
	var day_file = File.new()
	var sfx_file = File.new()
	var music_file = File.new()

	if not sfx_file.file_exists(SFX_VOLUME_FILE_PATH):
		var value = 0
		sfx_file.open(SFX_VOLUME_FILE_PATH, File.WRITE)
		sfx_file.store_var(value)
		sfx_file.close()

	else:
		var value = 0
		sfx_file.open(SFX_VOLUME_FILE_PATH, File.READ)
		value = sfx_file.get_var()
		sfx_file.close()
		$ParamMenu/SFXSlider.value = value

	if not music_file.file_exists(MUSIC_VOLUME_FILE_PATH):
		var value = 0
		music_file.open(MUSIC_VOLUME_FILE_PATH, File.WRITE)
		music_file.store_var(value)
		music_file.close()

		$MainMenuMusic.set_volume_db(float(0))
	
	else:
		var value = 0
		music_file.open(MUSIC_VOLUME_FILE_PATH, File.READ)
		value = music_file.get_var()
		music_file.close()

		$MainMenuMusic.set_volume_db(float(value))
		$ParamMenu/MusicSlider.value = value

	if bird_file.file_exists(BIRD_COLOR_FILE_PATH):
		bird_file.open(BIRD_COLOR_FILE_PATH, File.READ)
		list_index = bird_file.get_var()
		bird_file.close()

		if str(list_index) == "Null":
			list_index = 0

	else:
		bird_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		bird_file.store_var(list_index)
		bird_file.close()

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
		$Background2.show()
		$Background.hide()


	$ParamMenu/ChooseColor.animation = ANIMATION_LIST[list_index]


func _input(event):
	if event.is_action("flap") && $HowToPlay.is_visible_in_tree():
		$HowToPlay.hide()
		$MainMenu.show()

	elif event.is_action("flap") && $Credits.is_visible_in_tree():
		$Credits.hide()
		$MainMenu.show()


func _on_HTP_Button_pressed():
	$MainMenu.hide()
	$HowToPlay.show()



func _on_NewGameButton_pressed():
	$".".hide()
	get_tree().change_scene("res://subscenes/World.tscn")


func _on_ParamButon_pressed():
	$MainMenu.hide()
	$ParamMenu.show() 


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_LeaveParamButton_pressed():
	$MainMenu.show()
	$ParamMenu.hide() 


func _on_LeftArrowButton_pressed():
	var save_file = File.new()
	list_index -= 1

	if list_index < 0:
		$ParamMenu/ChooseColor.animation = ANIMATION_LIST[(-list_index)%3]
		save_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		save_file.store_var(-list_index%3)
		save_file.close()


	else:
		$ParamMenu/ChooseColor.animation = ANIMATION_LIST[list_index%3]

		save_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		save_file.store_var(list_index%3)
		save_file.close()


func _on_RightArrowButton_pressed():
	var save_file = File.new()
	list_index += 1

	if list_index < 0:
		$ParamMenu/ChooseColor.animation = ANIMATION_LIST[(-list_index)%3]
		save_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		save_file.store_var(-list_index%3)
		save_file.close()


	else:
		$ParamMenu/ChooseColor.animation = ANIMATION_LIST[list_index%3]

		save_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		save_file.store_var(list_index%3)
		save_file.close()


func _on_DayNightButton_pressed():
	
	var save_file = File.new()

	if $Background.is_visible_in_tree():
		$Background2.show()
		$Background.hide()
		
		day = false

	else:
		$Background.show()
		$Background2.hide()
		
		day = true


	save_file.open(DAYNIGT_STATE_FILE_PATH, File.WRITE)
	save_file.store_var(day)
	save_file.close()


func _on_SFXSlider_value_changed(value):
	value = round(value)
	
	var sfx_file = File.new()

	sfx_file.open(SFX_VOLUME_FILE_PATH, File.WRITE)
	sfx_file.store_var(value)
	sfx_file.close()



func _on_MusicSlider_value_changed(value):
	value = round(value)
	
	var music_file = File.new()

	music_file.open(MUSIC_VOLUME_FILE_PATH, File.WRITE)
	music_file.store_var(value)
	music_file.close()

	$MainMenuMusic.set_volume_db(float(value))


func _on_CreditsButton_pressed():
	$MainMenu.hide()
	$Credits.show() 




