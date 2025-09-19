extends Control

##### AUDIO RELATED NODES ###################################
@onready var master_slider: HSlider = $Panel/VBox/Tabs/Audio/VBox/MasterContainer/MasterSlider
@onready var music_slider: HSlider = $Panel/VBox/Tabs/Audio/VBox/MusicContainer/MusicSlider
@onready var sfx_slider: HSlider = $Panel/VBox/Tabs/Audio/VBox/SFXContainer/SFXSlider
##############################################################

#### DECLARING AUDIO RELATED VARIABLES ########################
var bus_master
var bus_music
var bus_sfx
###############################################################

func _ready() -> void:
	
	###### INITIALIZING AUDIO METHODS #############################
	bus_master = AudioServer.get_bus_index("Master")
	bus_music = AudioServer.get_bus_index("Music")
	bus_sfx = AudioServer.get_bus_index("Sfx")
	###############################################################
	
	var save_file = Global.main_scene.options_saver
	save_file._load()
	
	master_slider.set_value_no_signal(AudioServer.get_bus_volume_linear(bus_master))
	music_slider.set_value_no_signal(AudioServer.get_bus_volume_linear(bus_music))
	sfx_slider.set_value_no_signal(AudioServer.get_bus_volume_linear(bus_sfx))


########## AUDIO RELATED SIGNALS AND BUTTONS ######################
func _on_master_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_master, db)

func _on_music_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_music, db)

func _on_sfx_slider_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(bus_sfx, db)
##################################################################


func _on_return_pressed() -> void:
	queue_free()

func _on_save_pressed() -> void:
	Global.main_scene.options_saver._save()
