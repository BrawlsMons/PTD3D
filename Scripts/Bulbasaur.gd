extends Node3D  # Zastąpiono Spatial przez Node3D

# Zmienne wieży
var range = 4.5  # Mniejszy zasięg niż Charmandera
var attack_speed = 0.8  # Szybszy atak
var damage = 8  # Mniejsze obrażenia
var target = null  # Aktualny cel
var cooldown_timer = 0  # Timer do kontrolowania szybkości ataku

# Funkcja inicjalizacji
func _ready():
	cooldown_timer = attack_speed

# Główna pętla wieży
func _process(delta):
	# Zmniejsz timer
	if cooldown_timer > 0:
		cooldown_timer -= delta

	# Jeśli timer osiągnął zero, szukaj celu i atakuj
	if cooldown_timer <= 0:
		find_target()
		if target:
			attack()

# Funkcja wyszukiwania celu
func find_target():
	# Wykryj przeciwników w zasięgu za pomocą Area3D
	var bodies = $Area3D.get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("enemies"):  # Sprawdź, czy obiekt należy do grupy "enemies"
			target = body
			return
	target = null  # Jeśli nie ma celów, wyzeruj target

# Funkcja ataku
func attack():
	if target:
		look_at(target.global_transform.origin, Vector3.UP)  # Obróć wieżę w stronę celu
		target.take_damage(damage)  # Zadaj obrażenia przeciwnikowi
		cooldown_timer = attack_speed  # Resetuj timer
