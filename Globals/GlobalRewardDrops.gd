class_name GlobalDrops
extends Node

static var drop_table = [
	{ "item" : "CommonBuff",		"weight": 60 },
	{ "item" : "UncommonBuff",		"weight": 25 },
	{ "item" : "RareBuff",			"weight": 10 },
	{ "item" : "EpicBuff",			"weight": 4  },
	{ "item" : "LegendaryBuff",		"weight": 1 },
]

# Common Loot tables
static var common_reward = [0,1,0,0]
static var uncommon_reward = [0,0,1,0,0]
static var rare_reward = [0,0,0,0,0,
				 0,0,0,1,0,
				 0,0,0,0,0,
				 0,0,0,0,0]

static func get_common_probability() -> float:
	var div = 0.0
	for i in common_reward:
		div += common_reward[i]
		
	return div / common_reward.size()

static func get_uncommon_probability() -> float:
	var div = 0.0
	for i in uncommon_reward:
		div += uncommon_reward[i]
		
	return div / uncommon_reward.size()

static func get_rare_probability() -> float:
	var div = 0.0
	for i in rare_reward:
		div += rare_reward[i]
		
	return div / rare_reward.size()

static func pick_drop(table):
	var total_weight = 0
	for e in table:
		total_weight += e.weight

	var r = randf() * total_weight
	var cumulative = 0
	
	for e in table:
		cumulative += e.weight
		if r < cumulative:
			return e.item

	# fallback in case of rounding errors
	return table[-1].item
		
