extends Resource

class_name Mask

@export var name : String
@export var portrait_texture: Texture2D
@export var character_texture: Texture2D

func on_equip(player):
	player.character_sprite.texture = portrait_texture

func on_unequip(player):
	player.character_sprite.texture = null
