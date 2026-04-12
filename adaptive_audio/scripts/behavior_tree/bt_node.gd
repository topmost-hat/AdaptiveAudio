class_name BT_Node
extends Node

# Behavior Tree nodes based on lecture notes by Alexandre Tolstenko
# https://gameguild.gg/p/ai4games2/week-02

enum Status { NULL = -1, FAILURE, SUCCESS, RUNNING }

func evaluate() -> Status:
	push_warning("BT_Node: Using default BT_Node type.")
	return Status.NULL
