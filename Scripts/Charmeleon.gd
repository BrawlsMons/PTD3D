extends "res://Scripts/TowerBase.gd"

func _ready():
	range = 7.0
	attack_speed = 0.8
	damage = 20
	xp_to_evolve = 200
	next_evolution_scene = "res://Scenes/Charizard.tscn"  # Ścieżka do następnej ewolucji
