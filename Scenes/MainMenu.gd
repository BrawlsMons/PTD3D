extends Control

# Funkcja wywoływana po naciśnięciu przycisku "Nowa gra"
func _on_start_button_pressed():
	print("Próba załadowania sceny MainGame")  # Komunikat debugowania
	get_tree().change_scene_to_file("res://Scenes/MainGame.tscn")  # Nowa metoda zmiany sceny <button class="citation-flag" data-index="4">

# Funkcja wywoływana po naciśnięciu przycisku "Wybierz mapę"
func _on_MapButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/MapSelection.tscn")  # Załaduj scenę wyboru mapy <button class="citation-flag" data-index="4">

# Funkcja wywoływana po naciśnięciu przycisku "Ustawienia"
func _on_SettingsButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Settings.tscn")  # Załaduj scenę ustawień <button class="citation-flag" data-index="4">
