# Behavior Tree nodes based on lecture notes by Alexandre Tolstenko
# https://gameguild.gg/p/ai4games2/week-02

@abstract
class_name BT_Node
extends Node

enum Status { FAILURE, SUCCESS, RUNNING }

@abstract func evaluate() -> Status
