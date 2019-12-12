tool
extends TextureButton

###########################
# README
# How to use CalendarButton: 
# 
# In order to get the data from CalendarButton, we must create a connection.
# Example of use from your script:
# -----------------------------------
#
# var calendar_button_node = get_node("path/to/CalendarButton")
# calendar_button_node.connect("date_selected", self, "your_func_here")
#
# func your_func_here(date_obj):
# 	print(date_obj.date())
#
# -----------------------------------
# Whenever you select a day using CalendarButton, 
# a Date object will be sent to your script. 
# 
# Read res://addons/calendar_button/class/Date.gd for more info on Date object
###########################


var CalBegin = {
  "Sunday":0,
  "Monday":1
}

# calendar begins with weekday (Sunday or Monday)
export (String, "Sunday", "Monday") var WeekStartsOn = "Sunday"

# shortname weekday length (in char)
export (String, "1", "2", "3") var LengthWeekdayShortname = 2

# Stored date object
var date

# Signal to notify when a button has been clicked
signal date_selected(date_obj)

# Path
var month_year_path = "PanelContainer/vbox/hbox_month_year/"
var btn_img_path = "res://addons/calendar_button/btn_img/"
var label_days_path = "PanelContainer/vbox/hbox_label_days/"
var lang_path = "res://addons/calendar_button/languages/"

# Get language files
export (String, "English", "Italian") var language = "English"

var trans

# Classes
var Calendar = preload("res://addons/calendar_button/class/Calendar.gd").new()
var Date = preload("res://addons/calendar_button/class/Date.gd")

# Nodes
var popup = null
var label_month_year_node = null
var month_days_node = null

# Saved time selection
var selected_month
var selected_year
var selected_day

# Runs when added to editor / tree
func _enter_tree():
	setup_calendar_button()
	
	# get language resource
	trans = get_language_file(lang_path + language + ".json")

	# Setup popup and connections
	popup = preload("res://addons/calendar_button/popup.tscn").instance()
	popup.get_node(month_year_path + "button_prev_month").connect("pressed",self,"go_prev_month")
	popup.get_node(month_year_path + "button_next_month").connect("pressed",self,"go_next_month")
	popup.get_node(month_year_path + "button_prev_year").connect("pressed",self,"go_prev_year")
	popup.get_node(month_year_path + "button_next_year").connect("pressed",self,"go_next_year")
	popup.get_node(month_year_path + "label_month_year").connect("gui_input",self,"insert_month_year")
	popup.get_node(month_year_path + "edit_month").connect("item_selected",self,"month_selected")
	popup.get_node(month_year_path + "edit_year").connect("text_entered",self,"year_confirmed")
	
	# Populate weekday shortname 
	for i in range (1 , 8 ):
		if (trans):
			popup.get_node(label_days_path + "label_day" + str(i)).set_text(trans[str(Calendar.get_weekday_shortname(i + CalBegin[WeekStartsOn]))].substr(0, int(LengthWeekdayShortname)))
		else:
			popup.get_node(label_days_path + "label_day" + str(i)).set_text(str(Calendar.get_weekday_shortname(i + CalBegin[WeekStartsOn])).substr(0, int(LengthWeekdayShortname)))
			
	# Populate month dropdown (in the custom insert date)
	for i in range (1, 13):
		if (trans):
			popup.get_node(month_year_path + "edit_month").add_item(trans[str(Calendar.get_month_name(i))], i)
		else:
			popup.get_node(month_year_path + "edit_month").add_item(str(Calendar.get_month_name(i)), i)
			
	# Get nodes
	label_month_year_node = popup.get_node(month_year_path + "label_month_year")
	month_days_node = popup.get_node("PanelContainer/vbox/hbox_days")
	
	# Add signal to all buttons, which returns button node
	for i in range(42):
		var btn_node = month_days_node.get_node("btn_" + str(i))
		btn_node.connect("pressed", self, "day_pressed", [btn_node]) # will send name of button
	
	load_data()

# Runs when user presses a day button
func day_pressed(btn_node):
	# Close popup
	close_popup()
	
	# Update selected day
	selected_day = int(btn_node.get_text())
	
	# Store Date
	date = Date.new(selected_day, selected_month, selected_year)
	
	# Send signal with Date object to whomever needs it
	emit_signal("date_selected", date)


# A one time setup of the Calendar button
func setup_calendar_button():
	# Button settings
	set_toggle_mode(true)
	
	# Set "Normal" Button Texture
	texture_normal = load(btn_img_path + "btn_32x32_03.png")
	
	# Set "Pressed" Button Texture
	texture_pressed = load(btn_img_path + "btn_32x32_04.png")


# Load data on _init
func load_data():
	# Load todays date by default
	selected_month = Calendar.month()
	selected_year = Calendar.year()
	selected_day = Calendar.day()
	
	# Refresh popup with current data
	refresh_data()


# Reloads popup data
func refresh_data():
	# Update label with current month and year
	if (trans):
		label_month_year_node.set_text(trans[str(Calendar.get_month_name(selected_month))] + " " + str(selected_year))
	else:
		label_month_year_node.set_text(str(Calendar.get_month_name(selected_month)) + " " + str(selected_year))
		
	# Clear all nodes
	for i in range(42):
		var btn_node = month_days_node.get_node("btn_" + str(i))
		btn_node.set_text("")
		btn_node.set_disabled(true)
	
	# Get the week day for the first day in this month of this year
	var week_day = Calendar.get_weekday(1 - CalBegin[WeekStartsOn], selected_month, selected_year)
	
	# This months number of days
	var current_month_num_days = Calendar.get_number_of_days(selected_month, selected_year)
	
	# Draw the days for this month belonging to the correct weekday
	for i in range(current_month_num_days):
		var btn_node = month_days_node.get_node("btn_" + str(i + week_day))
		btn_node.set_text(str(i+1))
		btn_node.set_disabled(false)
		
		# If the day entered is "today"
		if(i+1 == Calendar.day() && selected_year == Calendar.year() && selected_month == Calendar.month() ):
			# Make it obvious that this is today
			btn_node.set_flat(true)
		else:
			btn_node.set_flat(false)
			pass


# Makes sure the popup window does not leave the screen
func check_position():
	var cal = popup.get_parent()
	var popup_container = popup.get_node("PanelContainer")
	
	var difference_x = 0
	var difference_y = 0
	
	var x_total = cal.get_position().x + cal.get_size().x + popup_container.get_position().x + popup_container.get_size().x
	if(x_total > OS.get_window_size().x):
		difference_x = x_total - OS.get_window_size().x
	
	var y_total = cal.get_position().y + cal.get_size().y + popup_container.get_position().y + popup_container.get_size().y
	if(y_total > OS.get_window_size().y):
		difference_y = y_total - OS.get_window_size().y
	
	popup_container.set_position(Vector2(popup_container.get_position().x - difference_x, popup_container.get_position().y - difference_y))

func insert_month_year(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.doubleclick:
		popup.get_node(month_year_path + "label_month_year").hide()
		var textlabel = popup.get_node(month_year_path + "label_month_year").get_text().rsplit(" ")
		var textMonth = textlabel[0]
		var textYear = textlabel[1]
		popup.get_node(month_year_path + "edit_month").select(selected_month - 1)
		popup.get_node(month_year_path + "edit_month").show()
		popup.get_node(month_year_path + "edit_year").set_text(textYear)
		popup.get_node(month_year_path + "edit_year").show()
		
		# disable navigation  buttons
		popup.get_node(month_year_path + "button_prev_month").disabled = true
		popup.get_node(month_year_path + "button_next_month").disabled = true
		popup.get_node(month_year_path + "button_prev_year").disabled = true
		popup.get_node(month_year_path + "button_next_year").disabled = true
		

func month_selected(id):
	selected_month = popup.get_node(month_year_path + "edit_month").get_item_id(id)	
	popup.get_node(month_year_path + "edit_month").hide()
	popup.get_node(month_year_path + "edit_year").hide()
	popup.get_node(month_year_path + "label_month_year").show()
	
	# enable navigation  buttons
	popup.get_node(month_year_path + "button_prev_month").disabled = false
	popup.get_node(month_year_path + "button_next_month").disabled = false
	popup.get_node(month_year_path + "button_prev_year").disabled = false
	popup.get_node(month_year_path + "button_next_year").disabled = false
		
	# Refresh data
	refresh_data()

func year_confirmed(text):
	if (text != ""): selected_year = int(text)
	popup.get_node(month_year_path + "edit_month").hide()
	popup.get_node(month_year_path + "edit_year").hide()
	popup.get_node(month_year_path + "label_month_year").show()
	
	# enable navigation  buttons
	popup.get_node(month_year_path + "button_prev_month").disabled = false
	popup.get_node(month_year_path + "button_next_month").disabled = false
	popup.get_node(month_year_path + "button_prev_year").disabled = false
	popup.get_node(month_year_path + "button_next_year").disabled = false
	
	# Refresh data
	refresh_data()
	
func go_prev_month():
	# Decrease by one
	selected_month -= 1
	
	# If we have less than 1, set to december (12) and decrease year by one
	if(selected_month < 1):
		selected_month = 12
		selected_year -= 1
	
	# Refresh data
	refresh_data()


func go_next_month():
	# Increment by one
	selected_month += 1
	
	# If we have surpassed 12, set to january (1) and increase year by one
	if(selected_month > 12):
		selected_month = 1
		selected_year += 1
	
	# Refresh data
	refresh_data()


func go_prev_year():
	# Decrease year by one
	selected_year -= 1
	
	# Refresh data
	refresh_data()


func go_next_year():
	# Increase year by one
	selected_year += 1
	
	# Refresh data
	refresh_data()


func close_popup():
	popup.hide()
	# check_outside_press.hide()
	set_pressed(false)


func _toggled(is_pressed):
	if(!is_pressed):
		close_popup()
	else:
		if(has_node("popup")):
			popup.show()
		else:
			add_child(popup)
	
	# If the button is placed close to a corner; we make sure we can see the entire popup
	check_position()


func get_language_file(path):
	var data_file = File.new()
	if data_file.open(path, File.READ) != OK:
		return
	var data_text = data_file.get_as_text()
	data_file.close()
	var data_parse = JSON.parse(data_text)
	if data_parse.error != OK:
		return
	var data = data_parse.result
	return data
		
	
	
	
