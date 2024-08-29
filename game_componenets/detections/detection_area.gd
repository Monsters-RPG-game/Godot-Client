extends Area2D
class_name DetectionArea

var detected_array: Array = []

func _on_area_entered(area):
	print('entered ', detected_array)
	detected_array.push_back(area)
	
func _on_area_exited(area):
	print('areas after exited ', detected_array)
	var index = detected_array.find(area)
	if index != -1:
		detected_array.remove_at(index)
