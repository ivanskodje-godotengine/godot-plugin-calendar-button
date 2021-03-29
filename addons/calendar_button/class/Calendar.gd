const MONTH = {
JAN = 1,
FEB = 2,
MAR = 3,
APR = 4,
MAY = 5,
JUN = 6,
JUL = 7,
AUG = 8,
SEP = 9,
OCT = 10,
NOV = 11,
DEC = 12
}


const month_name = [
"Jan", "Feb", "Mar", "Apr", 
"May", "Jun", "Jul", "Aug", 
"Sep", "Oct", "Nov", "Dec"
]


const weekday_name = [
"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
]


func hour():
	return OS.get_datetime()["hour"]

func minute():
	return OS.get_datetime()["minute"]

func second():
	return OS.get_datetime()["second"]

func day():
	return OS.get_datetime()["day"]

func week():
	return OS.get_datetime()["week"]

func month():
	return OS.get_datetime()["month"]

func year():
	return OS.get_datetime()["year"]


# Returns the total number of days on selected month and year
func get_number_of_days(m, y):
	var number_of_days
	if(m == MONTH.APR || m == MONTH.JUN || m == MONTH.SEP || m == MONTH.NOV):
		number_of_days = 30
	elif(m == MONTH.FEB):
		var is_leap_year = (y % 4 == 0 && y % 100 != 0) || (y % 400 == 0)
		if(is_leap_year):
			number_of_days = 29
		else:
			number_of_days = 28
	else:
		number_of_days = 31
	
	return number_of_days


# Returns the weekday (int)
func get_weekday(d, m, y):
	var t = [0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4]
	if m < 3:
		y -= 1

	return (y + y/4 - y/100 + y/400 + t[m-1] + d) % 7

# Returns the weekday name
func get_weekday_name(d, m, y):
	var day_num = get_weekday(d, m, y)
	return weekday_name[day_num]


# Returns the name of the current month
func get_month_name(num):
	return month_name[num-1]
