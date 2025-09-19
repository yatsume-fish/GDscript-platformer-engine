class_name Level
extends Node

@export var level_name : String
@export var soundtrack : Resource

func _ready() -> void:
	if soundtrack:
		load(soundtrack.get_path())
		print(soundtrack.get_path())
		Global.main_scene.play_track(soundtrack)
	else:
		Global.main_scene.play_track(null)
