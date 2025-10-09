extends PanelContainer

var _enabled : bool = false

@export var enabled:bool:
	get:
		return _enabled
	set(value):
		_enabled = value
		visible = value

@export var weapon : Weapon:
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown

func _ready() -> void:
	unfocused_style_box()


func _on_cooldown_timeout() -> void:
	if weapon:
		$Cooldown.wait_time = weapon.cooldown
		weapon.activate(owner, owner.nearest_enemy, get_tree())

func focused_style_box() -> void:
	var focused_box = StyleBoxFlat.new()
	focused_box.bg_color = Color("2e2e2e3e")
	
	focused_box.border_blend = true
	focused_box.border_width_left = 2
	focused_box.border_width_right = 2
	focused_box.border_width_top = 2
	focused_box.border_width_bottom = 2
	focused_box.border_color = Color("e60000")
	
	add_theme_stylebox_override("panel",focused_box)

func unfocused_style_box() -> void:
	var focused_box = StyleBoxFlat.new()
	focused_box.bg_color = Color("2e2e2e3e")
	
	focused_box.border_blend = true
	focused_box.border_width_left = 2
	focused_box.border_width_right = 2
	focused_box.border_width_top = 2
	focused_box.border_width_bottom = 2
	focused_box.border_color = Color("000000")
	
	add_theme_stylebox_override("panel",focused_box)
