extends Node

@onready var level_instance
@onready var World = $World
@onready var music_player = $AudioStreamPlayer

@onready var options_saver: Node = $OptionsSaver
@onready var game_saver: Node = $GameSaver


func _ready() -> void:
	Global.main_scene = self

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null

 
func load_level(level_name : String):
	unload_level()
	var level_path := "res://Levels/%s" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		level_instance = level_resource.instantiate()
		World.add_child(level_instance)
		Global.current_level = level_name

func play_track(soundtrack):
	print("i am now playing " + str(soundtrack))
	music_player.stream = soundtrack
	music_player.play()
