# Calendar Button Plugin for Godot Engine 3.2.3
![](icon.png)

This will add a CalendarButton node that allows you to easily select a date without having to do all the work of creating your own Calendar and Date classes.
Very easy to use.

![](http://i.imgur.com/effwCjs.png)

-----------

## How to implement in your project

1. Place CalendarButton in your scene
2. From a script of your choice, get the CalendarButton node
3. Using the node, add a connection: calendar_button_node.connect("date_selected", self, "your_func_here")
4. Create a function "func your_func_here(date_obj)". Note that it expect an argument.
5. Do a test inside "your_func_here", such as:  print(date_obj.date("DD-MM-YYYY"))

### Manual Plugin Installation

> Follow these steps if you are unable to find the CalendarButton Node.

1. Put the addons folder in the root of your Godot Engine project.
2. Go to the "Project" menu dropdown and select "Project Settings".
3. Select the "Plugins" tab. 
4. Select "Update" if you do not see the plugin.
5. Enable it.

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

# Development & Contributions

First of all; Thank you very much for making pull requests and posting issues related to this project.
Secondly, I hope we all continue to work towards writing amazing code :)

## GDScript style guide
Please do your best to follow the official [GDscript style guide](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/gdscript_styleguide.html)  
  
The short version:
> `NodeName`, not `node_name`   
> `node_name.gd`, not `NodeName.gd`
> `my_function()`, not `MyFunction()`
> `_unused_variable`, not `unused_variable` 

## Versioning
This projects follow [semantic versioning](https://semver.org/).

> Given a version number MAJOR.MINOR.PATCH, increment the:  
>   
> MAJOR version when you make incompatible API changes,  
> MINOR version when you add functionality in a backwards compatible manner, and  
> PATCH version when you make backwards compatible bug fixes.  

-----------

## Credits 
Big thanks to all that have posted issues and written PRs

-----------

## License

MIT License (MIT)

Copyright (c) 2021 Ivan Skodje

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
