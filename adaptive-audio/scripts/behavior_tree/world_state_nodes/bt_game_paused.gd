class_name BT_GamePaused
extends BT_Node

func evaluate() -> Status:
	if(WorldState.get_game_paused()): return Status.SUCCESS
	return Status.FAILURE
