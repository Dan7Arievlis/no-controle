class_name Hit

var damage : float
var dealer : Node2D
var target : Node2D


func _init(_damage : float, _dealer : Node2D, _target : Node2D):
	damage = _damage
	dealer = _dealer
	target = _target


func hash():
	return hash(self.dealer)
