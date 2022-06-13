# script: Bird

extends RigidBody2D
class_name Bird

signal died

onready var strm = $FlapSound.stream as AudioStreamOGGVorbis
onready var strm2 = $DieSound.stream as AudioStreamOGGVorbis
onready var strm3 = $HitSound.stream as AudioStreamOGGVorbis

onready var scn_gamemenu = preload("res://GameMenu.tscn")

onready var hitten = false
onready var alive = true

onready var list_index = 0
const ANIMATION_LIST = ["yellow", "blue", "red"]

const SFX_VOLUME_FILE_PATH = "user://sfxvolume_data.save"
const BIRD_COLOR_FILE_PATH = "user://bird_data.save"

func _ready() -> void:
	strm.set_loop(false)
	strm2.set_loop(false)
	strm3.set_loop(false)

	var sfx_file = File.new()
	var bird_file = File.new()
	var value = 0

	if bird_file.file_exists(BIRD_COLOR_FILE_PATH):
		bird_file.open(BIRD_COLOR_FILE_PATH, File.READ)
		list_index = bird_file.get_var()
		bird_file.close()

		if str(list_index) == "Null":
			list_index = 0

	if sfx_file.file_exists(SFX_VOLUME_FILE_PATH):
		sfx_file.open(SFX_VOLUME_FILE_PATH, File.READ)
		value = sfx_file.get_var()
		sfx_file.close()

		if str(value) == "Null":
			value = 0

		$FlapSound.set_volume_db(float(value))
		$HitSound.set_volume_db(float(value))
		$DieSound.set_volume_db(float(value))


	else:
		bird_file.open(BIRD_COLOR_FILE_PATH, File.WRITE)
		bird_file.store_var(list_index)
		bird_file.close()

	$BirdSprites.animation = ANIMATION_LIST[list_index]

	set_physics_process(true)
	set_process_input(true)


func _physics_process(delta) -> void:
	if rad2deg(rotation) < -30:
		rotation = deg2rad(-30)
		set_angular_velocity(0)

	if get_linear_velocity().y > 0:
		set_angular_velocity(1.5)
	
		if rad2deg(rotation) > 30:
			rotation = deg2rad(30)
			set_angular_velocity(0)



func flap() -> void:
	set_linear_velocity(Vector2(get_linear_velocity().x, -150))
	set_angular_velocity(-3)


func _input(event) -> void:
	if event.is_action_pressed("flap") && alive:
		$FlapSound.play()
		flap()


func die():
	alive = false
	if hitten == false:
		$HitSound.play()
		hitten = true

	$BirdSprites.stop()
	emit_signal("died")


