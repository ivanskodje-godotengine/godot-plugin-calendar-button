tool
extends EditorPlugin

# See calendar_script for info
func _enter_tree():
	add_custom_type("CalendarButton", "TextureButton", preload("calendar_script.gd"), preload("icon.png"))
	pass

func _exit_tree():
	# Clean-up of the plugin goes here
	remove_custom_type("CalendarButton")
	pass