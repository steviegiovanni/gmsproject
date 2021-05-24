/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

threatTableUpdateTimer++;
if((state != UNIT_STATE.DIE) && (threatTableUpdateTimer >= threatTableUpdateRate))
{
	with(pAlly)
	{
		if((state != UNIT_STATE.DIE)
		&& (point_distance(x, y, other.x, other.y) <= aggroRadius)
		&& (is_undefined(other.threatTable[? id])))
		{
			other.threatTable[? id] = 1;
		}
	}
	threatTableUpdateTimer = 0;
}