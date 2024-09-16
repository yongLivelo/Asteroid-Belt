extends Node2D

var gas_scene: PackedScene = load("res://Scenes/gas.tscn")

signal no_gas()
const MAX_GAS: float = 100
var gas_deplete_rate = 5
var gas = MAX_GAS:
		set(val):
			gas = clamp(val, 0, MAX_GAS)

func _process(delta):
	gas -= gas_deplete_rate * delta
	get_tree().call_group("user_interface", "set_gas", gas)
	if gas == 0:
		no_gas.emit()

func leave_gas(pos: Vector2):
	var gasNode = gas_scene.instantiate()
	gasNode.gas_absorb.connect(add_gas)
	gasNode.position = pos
	add_child(gasNode)


func add_gas():
	gas += 10
	AudioManager.player_get_gas.play()
