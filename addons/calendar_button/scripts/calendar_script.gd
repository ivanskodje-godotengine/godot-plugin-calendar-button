tool
extends TextureButton

export var week_starts_on_sunday = true

signal date_selected(date_obj)

var calendar := Calendar.new(week_starts_on_sunday)
var selected_date := Date.new()
var window_restrictor := WindowRestrictor.new()

var popup : Popup
var calendar_buttons : CalendarButtons

func _enter_tree():
	set_toggle_mode(true)
	setup_calendar_icon()
	popup = create_popup_scene()
	calendar_buttons = create_calendar_buttons()
	setup_month_and_year_signals(popup)
	refresh_data()
	setup_day_labels()

func setup_calendar_icon():
	texture_normal = load("res://addons/calendar_button/btn_img/btn_32x32_03.png")
	texture_pressed = load("res://addons/calendar_button/btn_img/btn_32x32_04.png")
	
func create_popup_scene() -> Popup:
	return preload("res://addons/calendar_button/popup.tscn").instance() as Popup

func create_calendar_buttons() -> CalendarButtons:
	var calendar_container : GridContainer = popup.get_node("PanelContainer/vbox/hbox_days")
	return CalendarButtons.new(self, calendar_container, calendar, week_starts_on_sunday)

func setup_month_and_year_signals(popup : Popup):
	var month_year_path = "PanelContainer/vbox/hbox_month_year/"
	popup.get_node(month_year_path + "button_prev_month").connect("pressed",self,"go_prev_month")
	popup.get_node(month_year_path + "button_next_month").connect("pressed",self,"go_next_month")
	popup.get_node(month_year_path + "button_prev_year").connect("pressed",self,"go_prev_year")
	popup.get_node(month_year_path + "button_next_year").connect("pressed",self,"go_next_year")

func setup_day_labels():

	var hbox_label_days = "PanelContainer/vbox/hbox_label_days/"
	var hbox_label_days_node = popup.get_node(hbox_label_days)

	
	var day_index = int(!week_starts_on_sunday) # 1 if starts on monday, 0 on sunday

	for day in hbox_label_days_node.get_children():
		print(day.get_name(), " ", day.text)

		day.text = calendar.WEEKDAY_NAME[day_index].substr(0, 3)

		day_index += 1

func set_popup_title(title : String):
	var label_month_year_node := popup.get_node("PanelContainer/vbox/hbox_month_year/label_month_year") as Label
	label_month_year_node.set_text(title)

func refresh_data():
	var title : String = str(calendar.get_month_name(selected_date.month()) + " " + str(selected_date.year()))
	set_popup_title(title)
	calendar_buttons.update_calendar_buttons(selected_date)

func day_selected(btn_node):
	close_popup()
	var day := int(btn_node.get_text())
	selected_date.set_day(day)
	emit_signal("date_selected", selected_date)

func go_prev_month():
	selected_date.change_to_prev_month()
	refresh_data()

func go_next_month():
	selected_date.change_to_next_month()
	refresh_data()

func go_prev_year():
	selected_date.change_to_prev_year()
	refresh_data()

func go_next_year():
	selected_date.change_to_next_year()
	refresh_data()

func close_popup():
	popup.hide()
	set_pressed(false)

func _toggled(is_pressed):
	if(!has_node("popup")):
		add_child(popup)
	if(!is_pressed):
		close_popup()
	else:
		if(has_node("popup")):
			popup.show()
		else:
			add_child(popup)
	
	window_restrictor.restrict_popup_inside_screen(popup)
