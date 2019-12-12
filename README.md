
# Calendar Button Plugin for Godot Engine (jospic Fork)
![](icon.png)

This plugin, originally developed by Ivan Skodje, will add a CalendarButton node that allows you to easily select a date without having to do all the work of creating your own Calendar and Date classes.

![](https://i.imgur.com/effwCjs.png)

**This version is a fork by jospic that introduces many new features.**

-----------

## Main improvements introduced by this version

1. Compatibility with Godot 3.x version
2. Possibility to insert a specific date (double click on month-year header label)
3. Possibility of localization (selecting in the properties node button)
4. Now the user can choose the starting day of the week: Sunday, as in the English countries or Monday as in the Latin countries (selecting in the properties node button)
5. Possibility to choose the length of the week short names from one to three characters (selecting in the properties node button)

![](https://i.imgur.com/8HTKFRJ.png)  |  ![](https://i.imgur.com/NrTDN3f.png)
:-------------------------:|:-------------------------:
Insert a custom date       |  new calendar button properties

-----------

## How to implement in your project

1. Place CalendarButton in your scene
2. From a script of your choice, get the CalendarButton node
3. Using the node, add a connection: calendar_button_node.connect("date_selected", self, "your_func_here")
4. Create a function "func your_func_here(date_obj)". Note that it expect an argument.
5. Do a test inside "your_func_here", such as:  print(date_obj.date())

-----------

**Code Example:**

func _ready():
	var calendar_button_node = get_node("path/to/CalendarButton")
	calendar_button_node.connect("date_selected", self, "your_func_here")

func your_func_here(date_obj):
	print(date_obj.date()) # Use the date_obj wisely :)

-----------

**Get detailed comments inside each class for more information.**

-----------

## License

MIT License (MIT)

Copyright (c) 2016 Ivan P. Skodje

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
