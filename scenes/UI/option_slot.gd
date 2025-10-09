extends Button

@export var weapon : Weapon:
	set(value):
		weapon = value
		$Label.text = "Lvl " + str(weapon.level + 1)
