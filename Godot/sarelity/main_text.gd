extends Label

var displayText = ""

@onready var main_text: Label = $"."
@onready var manager: Node = %DragDropManager


	
func panels_to_string() -> String:
	var result : String = ""
	
	var max_size : int = max(manager.insidePanels.size(), manager.outsidePanels.size())
	
	for i in range(max_size):
		var inside_name := "-"
		var outside_name := "-"
		
		if i < manager.insidePanels.size():
			inside_name = manager.insidePanels[i].name
		
		if i < manager.outsidePanels.size():
			outside_name = manager.outsidePanels[i].name
		
		result += str(i) + ": " + inside_name + " | " + outside_name + "\n"
	
	return result
