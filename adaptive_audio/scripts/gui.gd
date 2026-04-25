class_name GUI
extends Control

signal start_button_pressed
signal restart_button_pressed

# title screen
@onready var title_screen: Control = $TitleScreen
@onready var title_text: Label = $TitleScreen/TitleText
@onready var instructions_text: Label = $TitleScreen/InstructionsText
@onready var start_button: Button = $TitleScreen/StartButton

# gameplay screen
@onready var gameplay_screen: Control = $GameplayScreen
@onready var health_ui: Label = $GameplayScreen/HealthUI
@onready var ammo_ui: Label = $GameplayScreen/AmmoUI

# game over screen
@onready var game_over_screen: Control = $GameOverScreen
@onready var game_over_text: Label = $GameOverScreen/GameOverText
@onready var restart_button: Button = $GameOverScreen/RestartButton

# game over screen > statistics
@onready var statistics: Control = $GameOverScreen/Statistics
@onready var stats_text: Label = $GameOverScreen/Statistics/StatsText
@onready var seconds_survived: Label = $GameOverScreen/Statistics/SecondsSurvived
@onready var shots_fired: Label = $GameOverScreen/Statistics/ShotsFired
@onready var approachers_defeated: Label = $GameOverScreen/Statistics/ApproachersDefeated
@onready var shooters_defeated: Label = $GameOverScreen/Statistics/ShootersDefeated
@onready var chargers_defeated: Label = $GameOverScreen/Statistics/ChargersDefeated

func start_game():
	title_screen.visible = false
	gameplay_screen.visible = true
	game_over_screen.visible = false
	
	update_health_ui()
	update_ammo_ui()

func game_over(survived: float):
	title_screen.visible = false
	gameplay_screen.visible = false
	game_over_screen.visible = true
	
	update_statistics(survived)

func update_health_ui(): health_ui.text = "Health: " + str(WorldState.get_fact("PlayerHealth"))
func update_ammo_ui(): ammo_ui.text = "Ammo: " + str(WorldState.get_fact("PlayerAmmo"))
func update_statistics(survived: float):
	seconds_survived.text = "Seconds survived: " + str(survived as int)
	shots_fired.text = ("Shots fired: "
		+ str(WorldState.get_fact("PlayerShotsFired")))
	approachers_defeated.text = ("Yellow defeated: "
		+ str(WorldState.get_fact("NumApproachersDefeated")))
	shooters_defeated.text = ("Red defeated: "
		+ str(WorldState.get_fact("NumShootersDefeated")))
	chargers_defeated.text = ("Purple defeated: "
		+ str(WorldState.get_fact("NumChargersDefeated")))

func _on_start_button_pressed(): start_button_pressed.emit()
func _on_restart_button_pressed(): restart_button_pressed.emit()
