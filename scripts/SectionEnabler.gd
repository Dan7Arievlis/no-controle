class_name SectionEnabler
extends Resource

@export_flags_2d_physics() var sections_enabled

func add_sections_enabled(value : int):
	sections_enabled |= int(pow(2, value))
	ResourceSaver.save(self, "resources/sections_enabled.tres")


func has_flag(index : int):
	return sections_enabled & int(pow(2, index))
