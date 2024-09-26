extends Area2D

@onready var rich_text_label: RichTextLabel = $"../RichTextLabel"
var tween : Tweener


func _on_body_entered(_body: Node2D) -> void:
	tween = get_tree().create_tween().tween_property(rich_text_label, "visible_ratio", 1, 0.73)
