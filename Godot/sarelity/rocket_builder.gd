extends Control

enum rocketBuilder {empty,
	ariane, falcon, sojuz, pslv, 
	h2, rp1, htpb, 
	kourou, mys, bajkonur, sriharikota,
	biomass, galileo, sentinel, meteosat, custom}
var rocket = rocketBuilder.empty
var fuel = rocketBuilder.empty
var kosmodrom = rocketBuilder.empty
var satelite = rocketBuilder.empty
var strings = ["",
	"Raketa:\nAriane\n\n","Raketa:\nFalcon\n\n","Raketa:\nSojuz\n\n","Raketa:\nPSLV\n\n",
	"Palivo:\nH2 + O2\n\n","Palivo:\nRP1 + O2\n\n","Palivo:\nHTPB\n\n"
	,"Kosmodrom:\nKourou\n\n","Kosmodrom:\nMys Caneveral\n\n","Kosmodrom:\nBajkonur\n\n","Kosmodrom:\nSriharikota\n\n"
	,"Družice:\nBiomass\n\n","Družice:\nGalileo\n\n","Družice:\nSentinel\n\n","Družice:\nMeteosat\n\n","Družice:\nPostavena\n\n"]


@onready var infotext: Label = $Panel/VBoxContainer/HBoxContainer/NinePatchRect/Infotext
@onready var game: CanvasLayer = %Game
@onready var header: Label = $Panel/VBoxContainer/Header
@onready var raketaP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Raketa
@onready var palivoP: Panel = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo
@onready var kosmodromP: Panel = $Panel/VBoxContainer/HBoxContainer/Panel/Kosmodrom
@onready var konecP: HBoxContainer = $Panel/VBoxContainer/HBoxContainer/Panel/Konec
@onready var mapText: Label = $Panel/VBoxContainer/HBoxContainer/Panel/Kosmodrom/NinePatchRect/Infotext
@onready var timer: Timer = $Panel/VBoxContainer/HBoxContainer/Panel/Kosmodrom/Timer
@onready var satelity: Panel = $Panel/VBoxContainer/HBoxContainer/Panel/Satelity
@onready var sat_build: Button = $Panel/VBoxContainer/HBoxContainer/Panel/Konec/SatBuild



func loadOptions(part) ->void:
	raketaP.visible = false
	palivoP.visible = false
	kosmodromP.visible = false
	konecP.visible = false
	satelity.visible = false
	match part:
		0:
			raketaP.visible = true
			header.text = "Vyber raketu"
		1:
			palivoP.visible = true
			header.text = "Vyber palivo"
			topFuel = fuels.empty
			botFuel = fuels.empty
			fuelUpdateText()
		2:
			kosmodromP.visible = true
			header.text = "Vyber kosmodrom"
		3:
			konecP.visible = true
			sat_build.visible = !game.sat_build
			header.text = "Raketa postavena"
		4:
			satelity.visible = true
			header.text = "Vyber družici"


func _ready() -> void:
	reset(4)
	

func loadText() -> void:
	var new_text = ""
	new_text += "Mise:\n" + game.this_Mission.name + "\n\n" + strings[satelite] + strings[rocket] + strings[fuel] + strings[kosmodrom]
	
	
	infotext.text = new_text

func reset(where) -> void:
	rocket = rocketBuilder.empty
	fuel = rocketBuilder.empty
	kosmodrom = rocketBuilder.empty
	if game.sat_build: satelite = rocketBuilder.custom
	else: satelite = rocketBuilder.empty
	loadOptions(where)
	loadText()


func chooseCosmo(cosmo):
	match cosmo: 
		1:
			if rocket == rocketBuilder.ariane:
				kosmodrom = rocketBuilder.kourou
				loadOptions(3)
				loadText()
			else: 
				mapText.modulate.a = 1
				timer.start()
		2:
			if rocket == rocketBuilder.falcon:
				kosmodrom = rocketBuilder.mys
				loadOptions(3)
				loadText()
			else: 
				mapText.modulate.a = 1
				timer.start()
		3:
			if rocket == rocketBuilder.sojuz:
				kosmodrom = rocketBuilder.bajkonur
				loadOptions(3)
				loadText()
			else: 
				mapText.modulate.a = 1
				timer.start()
		4:
			if rocket == rocketBuilder.pslv:
				kosmodrom = rocketBuilder.sriharikota
				loadOptions(3)
				loadText()
			else: 
				mapText.modulate.a = 1
				timer.start()


#region rocket buttons

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
#endregion
	
#region kosmodrom butons 
func _on_kosmo_button_pressed() -> void:
	chooseCosmo(1)

func _on_kosmo_button_2_pressed() -> void:
	chooseCosmo(2)

func _on_kosmo_button_3_pressed() -> void:
	chooseCosmo(3)
	
func _on_kosmo_button_4_pressed() -> void:
	chooseCosmo(4)
#endregion

#region fuel buttons
func _on_fuel_button_pressed() -> void:
	fuel = rocketBuilder.h2
	loadOptions(2)
	loadText()

func _on_fuel_button_2_pressed() -> void:
	fuel = rocketBuilder.rp1
	loadOptions(2)
	loadText()


#endregion

enum fuels{
	empty, o2, h2 , rp1, htpb
}
var fuelTxt = ["","O2","H2","RP-1","HTPB"]
var topFuel = fuels.empty
var botFuel = fuels.empty

@onready var fuel_timer: Timer = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo/FuelTimer
@onready var fuel_infotext: Label = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo/SateliteChoose/FuelInfotext


func fuelUpdate(new_fuel: fuels):
	match new_fuel:
		fuels.o2:
			topFuel = fuels.o2
			if botFuel == fuels.htpb: botFuel = fuels.empty
		fuels.htpb:
			topFuel = fuels.htpb
			botFuel = fuels.htpb
		fuels.h2:
			if topFuel == fuels.htpb: topFuel= fuels.empty
			botFuel = fuels.h2
		fuels.rp1:
			if topFuel == fuels.htpb: topFuel= fuels.empty
			botFuel = fuels.rp1
	fuelUpdateText()

@onready var top_text: Label = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo/TopText
@onready var bot_text: Label = $Panel/VBoxContainer/HBoxContainer/Panel/Palivo/BotText


func fuelUpdateText():
	top_text.text = fuelTxt[topFuel]
	bot_text.text = fuelTxt[botFuel]

@onready var sat_timer: Timer = $Panel/VBoxContainer/HBoxContainer/Panel/Satelity/SatTimer
@onready var satInfotext: Label = $Panel/VBoxContainer/HBoxContainer/Panel/Satelity/SateliteChoose/Infotext

func pickSatelite(sat):
	match sat:
		1:
			if game.this_Mission == game.missions[1] or game.this_Mission == game.missions[3]: 
				satelite = rocketBuilder.biomass
				loadOptions(0)
				loadText()
			else:
				satInfotext.self_modulate.a = 1
				sat_timer.start()
		3:
			if game.this_Mission == game.missions[0] or game.this_Mission == game.missions[1] or game.this_Mission == game.missions[3] or game.this_Mission == game.missions[4] or game.this_Mission == game.missions[5]: 
				satelite = rocketBuilder.galileo
				loadOptions(0)
				loadText()
			else:
				satInfotext.self_modulate.a = 1
				sat_timer.start()
		2:
			if game.this_Mission == game.missions[2]: 
				satelite = rocketBuilder.sentinel
				loadOptions(0)
				loadText()
			else:
				satInfotext.self_modulate.a = 1
				sat_timer.start()
		4:
			if game.this_Mission == game.missions[4] or game.this_Mission == game.missions[0] or game.this_Mission == game.missions[5]: 
				satelite = rocketBuilder.meteosat
				loadOptions(0)
				loadText()
			else:
				satInfotext.self_modulate.a = 1
				sat_timer.start()


func _on_again_pressed() -> void:
	if game.sat_build: reset(0)
	else: reset(4)


func _on_timer_timeout() -> void:
	var tween := create_tween()
	tween.tween_property(
		mapText,
		"modulate",
		Color(modulate.r, modulate.g, modulate.b, 0.0),
		0.5
	)

#region satelite buttons

func _on_satelite_button_4_pressed() -> void:
	pickSatelite(4)


func _on_satelite_button_3_pressed() -> void:
	pickSatelite(3)


func _on_satelite_button_2_pressed() -> void:
	pickSatelite(2)


func _on_satelite_button_pressed() -> void:
	pickSatelite(1)

#endregion

#region fuel buttons
func _on_fuel_button_o_2_pressed() -> void:
	fuelUpdate(fuels.o2)


func _on_fuel_button_h_2_pressed() -> void:
		fuelUpdate(fuels.h2)


func _on_fuel_button_htpb_pressed() -> void:
		fuelUpdate(fuels.htpb)


func _on_fuel_button_rp_1_pressed() -> void:
		fuelUpdate(fuels.rp1)
		


func _on_fuel_button_end_pressed() -> void:
	match botFuel:
		fuels.empty:
			fuel_infotext.text = "Zvolte palivo"
			fuel_infotext.self_modulate.a = 1
			fuel_timer.start()
		fuels.htpb:
			fuel = rocketBuilder.htpb
			loadOptions(2)
			loadText()
		fuels.rp1:
			if topFuel == fuels.o2:
				fuel = rocketBuilder.rp1
				loadOptions(2)
				loadText()
			else:
				fuel_infotext.text = "Chybí okysličovadlo"
				fuel_infotext.self_modulate.a = 1
				fuel_timer.start()
		fuels.h2:
			if topFuel == fuels.o2:
				fuel = rocketBuilder.h2
				loadOptions(2)
				loadText()
			else:
				fuel_infotext.text = "Chybí okysličovadlo"
				fuel_infotext.self_modulate.a = 1
				fuel_timer.start()

#endregion


func _on_sat_timer_timeout() -> void:
	var tween := create_tween()
	tween.tween_property(
		satInfotext,
		"self_modulate",
		Color(modulate.r, modulate.g, modulate.b, 0.0),
		0.5
	)


func _on_fuel_timer_timeout() -> void:
	var tween := create_tween()
	tween.tween_property(
		fuel_infotext,
		"self_modulate",
		Color(modulate.r, modulate.g, modulate.b, 0.0),
		0.5
	)
