extends Node2D

const MAX_GAS: float = 100
var gas_deplete_rate = 5
var gas = MAX_GAS:
		set(val):
			gas = clamp(val, 0, MAX_GAS)

func _process(delta):
	gas -= gas_deplete_rate * delta
	get_tree().call_group("user_interface", "set_gas", gas)
