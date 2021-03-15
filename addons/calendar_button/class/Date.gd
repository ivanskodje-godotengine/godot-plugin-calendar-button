# Variables
var _day
var _month
var _year


# Date class is intended for use to store Date objects for later use
# If you want more current time and dates, use Calendar class
func _init(d = OS.get_datetime()["day"], m = OS.get_datetime()["month"], y = OS.get_datetime()["year"]):
	_day = d
	_month = m
	_year = y


# Date Formats:
# DD : Two digit day of month
# MM : Two digit month
# YY : Two digit year
# YYYY : Four digit year
#
# Returns a string with a date format
func date(date_format = "DD-MM-YY"):
	if("DD".is_subsequence_of(date_format)):
		date_format = date_format.replace("DD", str(day()).pad_zeros(2))
	
	if("MM".is_subsequence_of(date_format)):
		date_format = date_format.replace("MM", str(month()).pad_zeros(2))
	
	if("YYYY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YYYY", str(year()))
	elif("YY".is_subsequence_of(date_format)):
		date_format = date_format.replace("YY", str(year()).substr(2,3))
	
	return date_format


# 1: Mon
# ...
# 7: Sun
#
# Returns an integer
func day():
	return _day


# 1: Jan
# ...
# 12: Dec
#
# Returns an integer
func month():
	return _month


# Year with format "1900"
# Returns an integer
func year():
	return _year
