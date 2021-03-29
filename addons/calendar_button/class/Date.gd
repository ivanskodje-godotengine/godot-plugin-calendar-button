class_name Date

var day : int setget set_day
var month : int setget set_month
var year : int setget set_year

func _init(day : int = OS.get_datetime()["day"], 
		month : int = OS.get_datetime()["month"], 
		year : int = OS.get_datetime()["year"]):
	self.day = day
	self.month = month
	self.year = year

# Supported Date Formats:
# DD : Two digit day of month
# MM : Two digit month
# YY : Two digit year
# YYYY : Four digit year
func date(date_format = "DD-MM-YY") -> String:
	if("DD".is_subsequence_of(date_format)):
		date_format = date_format.replace("DD", str(day()).pad_zeros(2))
	if("MM".is_subsequence_of(date_format)):
		date_format = date_format.replace("MM", str(month()).pad_zeros(2))
	if("YYYY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YYYY", str(year()))
	elif("YY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YY", str(year()).substr(2,3))
	return date_format

func day() -> int:
	return day

func month() -> int:
	return month

func year() -> int:
	return year

func set_day(var _day : int):
	day = _day

func set_month(var _month : int):
	month = _month

func set_year(var _year : int):
	year = _year
