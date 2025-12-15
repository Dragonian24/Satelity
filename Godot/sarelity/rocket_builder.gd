extends Control

enum rocketBuilder {empty,
	ariane, falcon, sojuz, pslv, 
	h2, pr1, htpb, 
	kourou, mys, bajkonur, sriharikota}
var rocket = rocketBuilder.empty
var fuel = rocketBuilder.empty
var kosmodrom = rocketBuilder.empty
var strings = ["",
	"Raketa:\nAriane\n\n","Raketa:\nFalcon\n\n","Raketa:\nSojuz\n\n","Raketa:\nPSLV\n\n",
	"Palivo:\nH2 + O2\n\n","Palivo:\nRP1 + O2\n\n","Palivo:\nHTPB\n\n"
	,"Kosmodrom:\nKourou\n\n","Kosmodrom:\nMys Caneveral\n\n","Kosmodrom:\nBajkonur\n\n","Kosmodrom:\nSriharikota\n\n"]


@onready var infotext: Label = $Panel/VBoxContainer/HBoxContainer/Infotext
@onready var game: CanvasLayer = %Game
@onready var header: Label = $Panel/VBoxContainer/Header
@onready var raketaP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Raketa
@onready var palivoP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo
@onready var kosmodromP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Kosmodrom
@onready var konecP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Konec

func loadOptions(part) ->void:
	raketaP.visible = false
	palivoP.visible = false
	kosmodromP.visible = false
	konecP.visible = false
	match part:
		0:
			raketaP.visible = true
			header.text = "Vyber raketu"
		1:
			palivoP.visible = true
			header.text = "Vyber palivo"
		2:
			kosmodromP.visible = true
			header.text = "Vyber kosmodrom"
		3:
			konecP.visible = true
			header.text = "Raketa postavena"


func _ready() -> void:
	reset()
	

func loadText() -> void:
	var new_text = ""
	new_text += "Mise:\n" + game.this_Mission.name + "\n\n" + strings[rocket] + strings[fuel] + strings[kosmodrom]
	
	infotext.text = new_text

func reset() -> void:
	rocket = rocketBuilder.empty
	fuel = rocketBuilder.empty
	kosmodrom = rocketBuilder.empty
	loadOptions(0)
	loadText()


func _on_rocket_button_pressed() -> void:
	rocket = rocketBuilder.ariane
	loadOptions(1)
	loadText()


func _on_rocket_button_2_pressed() -> void:
	rocket = rocketBuilder.falcon
	loadOptions(1)
	loadText()
	
func _on_rocket_button_3_pressed() -> void:
	rocket = rocketBuilder.sojuz
	loadOptions(1)
	loadText()

func _on_rocket_button_4_pressed() -> void:
	rocket = rocketBuilder.pslv
	loadOptions(1)
	loadText()
	
func _on_kosmo_button_pressed() -> void:
	kosmodrom = rocketBuilder.kourou
	loadOptions(3)
	loadText()

func _on_kosmo_button_2_pressed() -> void:
	kosmodrom = rocketBuilder.mys
	loadOptions(3)
	loadText()

func _on_kosmo_button_3_pressed() -> void:
	kosmodrom = rocketBuilder.bajkonur
	loadOptions(3)
	loadText()
	
func _on_kosmo_button_4_pressed() -> void:
	kosmodrom = rocketBuilder.sriharikota
	loadOptions(3)
	loadText()

func _on_fuel_button_pressed() -> void:
	fuel = rocketBuilder.h2
	loadOptions(2)
	loadText()

func _on_fuel_button_2_pressed() -> void:
	fuel = rocketBuilder.pr1
	loadOptions(2)
	loadText()

func _on_fuel_button_3_pressed() -> void:
	fuel = rocketBuilder.htpb
	loadOptions(2)
	loadText()


func _on_again_pressed() -> void:
	reset()
