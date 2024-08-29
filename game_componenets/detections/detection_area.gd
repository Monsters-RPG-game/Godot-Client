extends Area2D
class_name DetectionArea

var detected_array: Array[CharacterBody2D] = []

func _on_body_entered(body):
	print("on enter", body)
	detected_array.push_back(body)
	
func _on_body_exited(body):
	print('on exited', body)
	var index = detected_array.find(body)
	if index != -1:
		detected_array.remove_at(index)
