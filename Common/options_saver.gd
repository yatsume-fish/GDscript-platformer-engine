extends Node

var options_save : OptionsSaveResource
var save_path = "user://options_save.tres"

########-DECLARING AUDIO RELATED VARIABLES
var bus_master
var bus_music
var bus_sfx
#########################################

func _ready() -> void:
	
	##########-INITIALIZING AUDIO RELATED METHODS
	bus_master = AudioServer.get_bus_index("Master")
	bus_music = AudioServer.get_bus_index("Music")
	bus_sfx = AudioServer.get_bus_index("Sfx")
	#########################################


func _save():
	var data = OptionsSaveResource.new()
	
	#######-SAVING AUDIO RELATED SETTINGS-#################################
	data.volume_master = AudioServer.get_bus_volume_linear(bus_master)
	data.volume_music = AudioServer.get_bus_volume_linear(bus_music)
	data.volume_sfx = AudioServer.get_bus_volume_linear(bus_sfx)
	#######################################################################
	
	ResourceSaver.save(data, save_path)
	print("saved!!")

func _load():
	var data = ResourceLoader.load(save_path) as OptionsSaveResource
	
	#######-LOADING AUDIO RELATED SETTINGS-################################
	AudioServer.set_bus_volume_linear(bus_master, data.volume_master)
	AudioServer.set_bus_volume_linear(bus_music, data.volume_music)
	AudioServer.set_bus_volume_linear(bus_sfx, data.volume_sfx)
	#######################################################################
