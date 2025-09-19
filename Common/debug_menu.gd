extends Control

@onready var debug_window = $Window
@onready var levels_button = $Window/VBoxContainer/OptionButton
@onready var debug_hud = $DebugHud

@onready var debug_hud_fps = $DebugHud/VBoxContainer/FpsContainer/FpsVar
@onready var debug_hud_level = $DebugHud/VBoxContainer/LevelContainer/LevelVar
@onready var debug_hud_audio = $DebugHud/VBoxContainer/AudioContainer/AudioVar

var debug_hud_show : bool
var debug_window_show : bool

var level_selected
var levels_list
var levels_number

func _process(_delta: float) -> void:
	debug_handler()

func _ready() -> void:
	add_to_list()

func _input(event): #input handling
	if event.is_action_pressed("Button_debug"):
		if debug_hud_show == true:
			debug_hud_show = false
			print("Debug menu OFF")
		else:
			debug_hud_show = true
			print("Debug menu ON")


func _on_button_pressed() -> void:
	debug_window_show = true
	print("debug menu ON")

func _on_window_close_requested() -> void:
	debug_window_show = false
	print("debug menu OFF")



func debug_handler(): 
	##fps display
	var fps = Engine.get_frames_per_second()
	
	debug_hud_fps.text = str(fps)
	debug_hud_level.text = str(Global.current_level)
	debug_hud_audio.text = str(Global.main_scene.music_player.get_stream())
	
	####### handles showing and hiding debug ui
	if debug_hud_show:
		debug_hud.show()
	else:
		debug_hud.hide()
	
	if debug_window_show:
		debug_window.show()
	else:
		debug_window.hide()




#returns the number of levels in the levels directory and lists them
func list_levels(): 
	levels_list = ResourceLoader.list_directory("res://Levels/")
	levels_number = levels_list.size()
	
	####### remove files that are not scenes
	
	for n in levels_number:
		if not ".tscn" in levels_list[n]:
			levels_list.remove_at(n)
	
	print("there are %s levels" % levels_number)
	print(levels_list)

#adds the list of numbers to the levels picker in the debug window
func add_to_list():
	list_levels()
	for n in levels_number:
		levels_button.add_item(levels_list[n])

func _on_option_button_item_selected(index: int) -> void:
	level_selected = levels_button.get_item_text(index)
	Global.main_scene.load_level(level_selected)
