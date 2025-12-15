extends Control

var score = 1000
@onready var mison_manager: Node = %MisonManager

@onready var energy_text: Label = $Panel/VBoxContainer/Panel2/HBoxContainer/VBoxContainer/EnergyText
@onready var otional_text: Label = $Panel/VBoxContainer/Panel2/HBoxContainer/VBoxContainer/OtionalText
@onready var main_comp_text: Label = $Panel/VBoxContainer/Panel2/HBoxContainer/VBoxContainer2/MainCompText
@onready var aditional_text: Label = $Panel/VBoxContainer/Panel2/HBoxContainer/VBoxContainer2/AditionalText
@onready var scoreLabel: Label = $Panel/VBoxContainer/Panel/HBoxContainer/Panel/Score

@onready var comp_lib: Node = %CompLib

@export var neutralColor: Color 
@export var errorColor: Color
@export var succesColor: Color


func _ready() -> void:
	ctitErrors()

func ctitErrors() -> void:
	var values = mison_manager.values
	var messages = mison_manager.messages
	var this_mision = mison_manager.this_mision
	var insidePanels = mison_manager.insidePanels
	var outsidePanels = mison_manager.outsidePanels
	
	calcEnergy(messages, values)
	calcMissing(this_mision, insidePanels, outsidePanels)
	calcAdd(this_mision, insidePanels, outsidePanels)
	calcAdi(this_mision, insidePanels, outsidePanels)
	
	scoreLabel.text = "Skóre: " + str(score) 

func calcAdi(this_mision, insidePanels, outsidePanels) -> void:
	var adi = false
	var adiStr: String = "Přebývají komponenty: \n"

	for i in insidePanels.size():		
		if insidePanels[i] == comp_lib.Comps[14]: break
		var found = false
		for j in this_mision.neededComps.size():
			if insidePanels[i] == this_mision.neededComps[j]:
				found = true
				break
		for j in this_mision.additionalComps.size():
			if insidePanels[i] == this_mision.additionalComps[j]:
				found = true
				break
		if found == false:
			adi = true
			score -= 50
			adiStr += insidePanels[i].name + "\n"
		
		
	for i in outsidePanels.size():		
		if outsidePanels[i] == comp_lib.Comps[14]: break
		var found = false
		for j in this_mision.neededComps.size():
			if outsidePanels[i] == this_mision.neededComps[j]:
				found = true
				break
		for j in this_mision.additionalComps.size():
			if outsidePanels[i] == this_mision.additionalComps[j]:
				found = true
				break
		if found == false:
			adi = true
			score -= 50
			adiStr += outsidePanels[i].name + "\n"
				
	if adi == false: adiStr = ""
	aditional_text.text = adiStr 
	
	
func calcAdd(this_mision, insidePanels, outsidePanels) -> void:
	var can = false
	var canStr: String = "Pomocné komponenty: \n"
	
	for i in this_mision.additionalComps.size():
		var found = false
		for j in insidePanels.size():
			if insidePanels[j] == this_mision.additionalComps[i] :
				found = true
				canStr += this_mision.additionalComps[i].name + "\n"
				break
		for j in outsidePanels.size():
			if outsidePanels[j] == this_mision.additionalComps[i]:
				canStr += this_mision.additionalComps[i].name + "\n"
				found = true
				break
		if found == true: 
			can = true
			score += 150
	
	if can == false: canStr = ""
	otional_text.text = canStr
	

func calcMissing(this_mision, insidePanels, outsidePanels) -> void:
	
	var miss = false
	var missStr: String = "Chybí komponenty: \n"
	
	for i in this_mision.neededComps.size():
		var found = false
		for j in insidePanels.size():
			if insidePanels[j] == this_mision.neededComps[i] :
				found = true
				break
		for j in outsidePanels.size():
			if outsidePanels[j] == this_mision.neededComps[i] :
				found = true
				break
		if found == false: 
			miss = true
			score -= 100
			missStr += "Chybí " + this_mision.neededComps[i].name + "\n"
	
	main_comp_text.add_theme_color_override("font_color", errorColor)
	if miss == false:
		missStr = "Komponenty OK"
		main_comp_text.add_theme_color_override("font_color", succesColor)
	main_comp_text.text = missStr

func calcEnergy(messages, values) -> void:
	
	var energy = false
	var enStr: String = ""
	
	if values[0] > values[1]: 
		energy = true
		score -= 200
		enStr += messages[0] + "\n"
	if values[0] > values[2]:
		energy = true
		score -= 200
		enStr += messages[1] + "\n"
	
	energy_text.add_theme_color_override("font_color", errorColor)
	if energy == false: 
		enStr = "Energie OK"
		energy_text.add_theme_color_override("font_color", succesColor)
	energy_text.text = enStr 
