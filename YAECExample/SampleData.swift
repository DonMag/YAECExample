//
//  SampleData.swift
//  YAECExample
//
//  Created by Don Mag on 3/9/21.
//

import UIKit

struct MyStruct {
	var title: String = ""
	var desc: String = ""
	var isExpanded: Bool = false
}

class SampleData: NSObject {
	
	func getSampleData() -> [MyStruct] {
		
	let data: [[String]] = [
		[
			"Label",
			"""
			A label can contain an arbitrary amount of text, but UILabel may shrink, wrap, or truncate the text, depending on the size of the bounding rectangle and properties you set. You can control the font, text color, alignment, highlighting, and shadowing of the text in the label.
			"""
		],
		[
			"Button",
			"""
			You can set the title, image, and other appearance properties of a button. In addition, you can specify a different appearance for each button state.
			"""
		],
		[
			
			"Segmented Control",
			"""
			The segments can represent single or multiple selection, or a list of commands.
			
			Each segment can display text or an image, but not both.
			"""
		],
		[
			"Text Field",
			"""
			Displays a rounded rectangle that can contain editable text. When a user taps a text field, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text field can handle the input in an application-specific way. UITextField supports overlay views to display additional information, such as a bookmarks icon. UITextField also provides a clear text control a user taps to erase the contents of the text field.
			"""
		],
		[
			"Slider",
			"""
			UISlider displays a horizontal bar, called a track, that represents a range of values. The current value is shown by the position of an indicator, or thumb. A user selects a value by sliding the thumb along the track. You can customize the appearance of both the track and the thumb.
			"""
		],
		[
			"Switch",
			"""
			Displays an element that shows the user the boolean state of a given value.  By tapping the control, the state can be toggled.
			"""
		],
		[
			"Activity Indicator View",
			"""
			Used to indicate processing for a task with unknown completion percentage.
			"""
		],
		[
			"Progress View",
			"""
			Shows that a lengthy task is underway, and indicates the percentage of the task that has been completed.
			"""
		],
		[
			"Page Control",
			"""
			UIPageControl indicates the number of open pages in an application by displaying a dot for each open page. The dot that corresponds to the currently viewed page is highlighted. UIPageControl supports navigation by sending the delegate an event when a user taps to the right or to the left of the currently highlighted dot.
			"""
		],
		[
			"Stepper",
			"""
			Often combined with a label or text field to show the value being incremented.
			"""
		],
		[
			"Horizontal Stack View",
			"""
			An UIStackView creates and manages the constraints necessary to create horizontal or vertical stacks of views. It will dynamically add and remove its constraints to react to views being removed or added to its stack. With customization it can also react and influence the layout around it.
			"""
		],
		[
			"Vertical Stack View",
			"""
			An UIStackView creates and manages the constraints necessary to create horizontal or vertical stacks of views. It will dynamically add and remove its constraints to react to views being removed or added to its stack. With customization it can also react and influence the layout around it.
			"""
		],
		[
			"Table View",
			"""
			Coordinates with a data source and delegate to display a scrollable list of rows. Each row in a table view is a UITableViewCell object.
			
			The rows can be grouped into sections, and the sections can optionally have headers and footers.
			
			The user can edit a table by inserting, deleting, and reordering table cells.
			"""
		],
		[
			"Table View Cell",
			"""
			Defines the attributes and behavior of cells in a table view. You can set a table cell's selected-state appearance, support editing functionality, display accessory views (such as a switch control), and specify background appearance and content indentation.
			"""
		],
		[
			"Image View",
			"""
			Shows an image, or series of images as an animation.
			"""
		],
		[
			"Collection View",
			"""
			Coordinates with a data source and delegate to display a scrollable collection of cells. Each cell in a collection view is a UICollectionViewCell object.
			
			Collection views support flow layout as well a custom layouts, and cells can be grouped into sections, and the sections and cells can optionally have supplementary views.
			"""
		],
		[
			"Collection View Cell",
			"""
			A single view representing one cell in a collection view. Populate it with subviews, like labels and image views, to provide appearance.
			"""
		],
		[
			"Collection View Reusable View",
			"""
			Defines the attributes and behavior of reusable views in a collection view, such as a section header or footer.
			"""
		],
		[
			"Text View",
			"""
			When a user taps a text view, a keyboard appears; when a user taps Return in the keyboard, the keyboard disappears and the text view can handle the input in an application-specific way. You can specify attributes, such as font, color, and alignment, that apply to all text in a text view.
			"""
		],
		[
			"Scroll View",
			"""
			UIScrollView provides a mechanism to display content that is larger than the size of the application’s window and enables users to scroll within that content by making swiping gestures.
			"""
		],
		[
			"Date Picker",
			"""
			Provides an object that uses multiple rotating wheels to allow users to select dates and times. Examples of a date picker are the Timer and Alarm (Set Alarm) panes of the Clock application. You may also use a UIDatePicker as a countdown timer.
			"""
		],
		[
			"Picker View",
			"""
			Provides a potentially multidimensional user-interface element consisting of rows and components. A component is a wheel, which has a series of items (rows) at indexed locations on the wheel. Each row on a component has content, which is either a string or a view object such as a label or an image.
			"""
		],
		
	]

		var d: [MyStruct] = []
		data.forEach {
			let s = MyStruct(title: $0[0], desc: $0[1])
			d.append(s)
		}
		return d
	}
	
}
