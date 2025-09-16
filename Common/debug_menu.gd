extends Control

@onready var debug_window = $Window
@onready var levels_button = $Window/VBoxContainer/OptionButton

var debug_show : bool
var level_selected
var levels_list
var levels_number

func _process(delta: float) -> void:
	debug_handler()

func _ready() -> void:
	add_to_list()

func _input(event):
	if event.is_action_pressed("Button_debug"):
		if debug_show == true:
			debug_show = false
			print("Debug menu OFF")
		else:
			debug_show = true
			print("Debug menu ON")

func _on_window_close_requested() -> void:
	debug_show = false
	print("debug menu OFF")

func debug_handler():
		if debug_show:
			debug_window.show()
		else:
			debug_window.hide()

func list_levels():
	levels_list = ResourceLoader.list_directory("res://Levels/")
	levels_number = levels_list.size()
	print("there are %s levels" % levels_number)
	print(levels_list)

func add_to_list():
	list_levels()
	for n in levels_number:
		levels_button.add_item(levels_list[n])

func _on_option_button_item_selected(index: int) -> void:
	level_selected = levels_button.get_item_text(index)
	Global.main_scene.load_level(level_selected)
