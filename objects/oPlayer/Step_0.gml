/// @description Insert description here
// You can write your code in this editor
// get player input
keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A"));
keyRight = keyboard_check(vk_right) || keyboard_check(ord("D"));
keyUp = keyboard_check(vk_up) || keyboard_check(ord("W"));
keyDown = keyboard_check(vk_down) || keyboard_check(ord("S"));
keyActivate = keyboard_check_pressed(vk_space);
keyAttack = keyboard_check_pressed(ord("Z"));
keyItem = keyboard_check_pressed(vk_control);

inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);

with(pEnemy)
{
	ds_map_replace(other.threatTable, id, 5);
}

var it = ds_map_find_first(threatTable);
while(!is_undefined(it))
{
	var _currentId = it;
	it = ds_map_find_next(threatTable, it);
	if(!instance_exists(_currentId))
	{
		ds_map_delete(threatTable, _currentId);
	}
	
}
for(var i = ds_map_find_first(threatTable); !is_undefined(i); i = ds_map_find_next(threatTable, i))
{
	show_debug_message(string(i) + ":" + string(threatTable[? i]));
}

event_inherited();
