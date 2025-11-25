extends Resource
class_name Component

# --- ENUM ---
enum Location {
	INSIDE,
	OUTSIDE
}

# --- ATTRIBUTES ---

@export var location: Location = Location.INSIDE

@export var size: int = 0

@export var EnergyConsumption: int = 0
@export var EnergyStorage: int = 0
@export var EnergyCreation: int = 0

@export var icon: Texture2D

@export var ID: int = 0

@export var name: String = ""
