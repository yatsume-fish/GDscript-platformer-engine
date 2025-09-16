extends Node

@onready var level_instance
@onready var World = $World

func _ready() -> void:
	Global.main_scene = self

func unload_level():
	if (is_instance_valid(level_instance)):
		level_instance.queue_free()
	level_instance = null


func load_level(level_name : String):
	unload_level()
	var level_path := "res://Levels/%s.tscn" % level_name
	var level_resource := load(level_path)
	if (level_resource):
		level_instance = level_resource.instance()
		World.add_child(level_instance)
