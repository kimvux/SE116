class_name ShieldDecorator
extends PowerupDecorator

## Blocks one hit on the fox, then DecoratorManager takes it off.

func blocks_damage() -> bool:
	return true
