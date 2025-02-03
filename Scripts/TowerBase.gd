extends Node3D

# Podstawowe zmienne wieży
var range = 5.0  # Zasięg ataku
var attack_speed = 1.0  # Szybkość ataku (w sekundach)
var damage = 10  # Obrażenia
var target = null  # Aktualny cel
var cooldown_timer = 0  # Timer do kontrolowania szybkości ataku

# System XP
var xp = 0  # Aktualne XP
var xp_to_evolve = 100  # Ilość XP potrzebna do ewolucji
var next_evolution_scene: String = ""  # Ścieżka do sceny następnej ewolucji

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
		add_xp(5)  # Przyznaj XP za atak
		cooldown_timer = attack_speed  # Resetuj timer

# Funkcja dodawania XP
func add_xp(amount):
	xp += amount
	print("Zdobyto XP: ", amount, ". Aktualne XP: ", xp)
	if xp >= xp_to_evolve and next_evolution_scene != "":
		evolve()  # Wywołaj funkcję ewolucji

# Funkcja ewolucji
func evolve():
	# Użyj load() zamiast preload(), ponieważ ścieżka jest dynamiczna
	var new_tower_scene = load(next_evolution_scene).instance()
	new_tower_scene.global_transform = global_transform  # Zachowaj pozycję i rotację
	get_parent().add_child(new_tower_scene)  # Dodaj nową wieżę do sceny
	queue_free()  # Usuń starą wieżę
