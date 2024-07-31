extends "res://fish/Species/Species.gd"
class_name Eyefish

func generate(bones:Node2D, multi_colour_chance:float, colour:String):
	var prev_bone:Node2D = null
	var x_pos:float = 0
	# worm initial values
	num_bones = randi_range(10, 12)
	max_distance = randi_range(15, 15)
	max_radius = randi_range(30, 50)
	
	var scaling_max:float = min(num_bones, 20)
	var min_turn_angle:float = (scaling_max * 0.01)
	var turn_speed:float = 12-(scaling_max * 0.45)
	
	
	for i in range(0, num_bones):
		var bone:FishBone = fish_bone_object.instantiate()
		var scale_factor:float = 1-(i*(0.75/num_bones))
		var use_individual_colours = false
		bone.colour = colour
		if randf() < multi_colour_chance:
			use_individual_colours = true
		var has_eyes:bool = true
		if i > 0:
			bone.init(prev_bone, use_individual_colours, max_distance, max_radius*scale_factor, min_turn_angle*scale_factor, turn_speed, has_eyes)
		else:
			bone.init(prev_bone, use_individual_colours, max_distance, max_radius, min_turn_angle, turn_speed, has_eyes)
			bone.move_speed = randf_range(400,  600)
		x_pos -= bone.radius
		
		var fin:FishBone = null
		if i == num_bones-1:
			fin = fish_bone_object.instantiate()
			var fin_radius:float = bone.radius*1.75
			var fin_max_distance:float = max_distance * 1.25
			var fin_min_turn_angle:float = min_turn_angle
			var fin_turn_speed:float = turn_speed * 1.5
			fin.init(bone, use_individual_colours, fin_max_distance, fin_radius, fin_min_turn_angle, fin_turn_speed, true)
			fin.move_speed = bone.move_speed
			fin.position.x = x_pos - bone.radius
			fin.position.y = -fin_radius
			fin.rotation = 0
		
		bone.position.x = x_pos
		bone.rotation = 0
		
		bones.add_child(bone)
		if fin:
			bones.add_child(fin)
		prev_bone = bone
