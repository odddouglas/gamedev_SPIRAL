extends ItemData
class_name ItemDataMedicine

#饱腹值
@export var satiety_value: int 

func use(target):
	if satiety_value != 0:
		target.aument_satiety(satiety_value)
