extends "res://Scripts/TowerBase.gd"

func _ready():
	range = 5.0
	attack_speed = 1.0
	damage = 10
	xp_to_evolve = 100
	next_evolution_scene = "res://Scenes/Charmeleon.tscn"  # Ścieżka do następnej ewolucji
