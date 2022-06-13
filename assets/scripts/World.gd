extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var player = $Bird
onready var ground_scrolling = $Ground/Scrolling

# godot create a user folder to save something
const SAVE_FILE_PATH = "user://saved_data.save"
const DAYNIGT_STATE_FILE_PATH = "user://daynightstate_data.save"
const MUSIC_VOLUME_FILE_PATH = "user://musicvolume_data.save"
const SFX_VOLUME_FILE_PATH = "user://sfxvolume_data.save"

onready var highscore = 0
onready var score = 0


func _ready():
	var day_file = File.new()
	var music_file = File.new()
	var sfx_file = File.new()
	var value = 0
	var day = true

	$NightMusic.stop()
	$DayMusic.stop()
	$OneHundredMusic.stop()

	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	player.connect("died", self, "_on_Player_died")
	load_highscore()
	
	var strm = $ten_points.stream as AudioStreamOGGVorbis
	strm.set_loop(false)

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

	if music_file.file_exists(MUSIC_VOLUME_FILE_PATH):
		music_file.open(MUSIC_VOLUME_FILE_PATH, File.READ)
		value = music_file.get_var()
		music_file.close()

		if str(value) == "Null":
			value = 0

		$DayMusic.set_volume_db(float(value))
		$NightMusic.set_volume_db(float(value))
		$OneHundredMusic.set_volume_db(float(value))


	if sfx_file.file_exists(SFX_VOLUME_FILE_PATH):
		sfx_file.open(SFX_VOLUME_FILE_PATH, File.READ)
		value = sfx_file.get_var()
		sfx_file.close()

		if str(value) == "Null":
			value = 0

		$ten_points.set_volume_db(float(value))


	if not day:
		$Background2.show()
		$Background.hide()
		$NightMusic.play()

	else:
		$DayMusic.play()


func player_score():
	score += 1
	set_score(score)
	
	if score%10 == 0:
		$ten_points.play()
	
	if score == 100:
		$DayMusic.stop()
		$NightMusic.stop()
		$OneHundredMusic.play()


func set_score(new_score):
	score = new_score
	hud.update_score(score)


func _on_obstacle_created(obs):
	obs.connect("score", self, "player_score")


func game_over():
	ground_scrolling.stop()
	obstacle_spawner.stop()
	get_tree().call_group("Obstacles", "set_physics_process", false)

	if score > highscore:
		highscore = score

	save_highscore()
	$HUD.init_game_over_menu(score, highscore)

func _on_Player_died():
	game_over()


func save_highscore():
	var save_file = File.new()
	save_file.open(SAVE_FILE_PATH, File.WRITE)
	save_file.store_var(highscore)
	save_file.close()

func load_highscore():
	var save_file = File.new()
	
	if save_file.file_exists(SAVE_FILE_PATH):
		save_file.open(SAVE_FILE_PATH, File.READ)
		highscore = save_file.get_var()
		save_file.close()
	
	else:
		highscore = 0


func change_background():
	if $Background.is_visible_in_tree():
		$Background2.show()
		$Background.hide()

	else:
		$Background.show()
		$Background2.hide()

