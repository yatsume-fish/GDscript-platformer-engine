extends Control



func resume():
	get_tree().paused = false
	hide()
	print("game resumed")

func pause():
	get_tree().paused = true
	show()
	print("game paused")

func options():
	var pause_menu = load("res://Common/options_menu.tscn").instantiate()
	get_parent().add_child(pause_menu)



func _input(event): #input handling
	if event.is_action_pressed("Button_pause") and not get_tree().paused:
		pause()
	elif event.is_action_pressed("Button_pause") and get_tree().paused:
		resume()
	

######### SIGNALS AND BUTTONS ###############################
func _on_resume_pressed() -> void:
	resume()

func _on_restart_pressed() -> void:
	pass 

func _on_options_pressed() -> void:
	options() 

func _on_return_to_menu_pressed() -> void:
	pass
###########################################################
