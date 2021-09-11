/// @description Insert description here
// You can write your code in this editor

if(playerControlled)
{
	keyLeft = keyboard_check(vk_left) || keyboard_check(ord("A")) || (gamepad_axis_value(0, gp_axislh) < -0.3);
	keyRight = keyboard_check(vk_right) || keyboard_check(ord("D")) || (gamepad_axis_value(0, gp_axislh) > 0.3);
	keyUp = keyboard_check(vk_up) || keyboard_check(ord("W")) || (gamepad_axis_value(0, gp_axislv) < -0.3);
	keyDown = keyboard_check(vk_down) || keyboard_check(ord("S")) || (gamepad_axis_value(0, gp_axislv) > 0.3);
	keyActivate = keyboard_check_pressed(vk_space);
	keyAttack = keyboard_check_pressed(ord("Z")) || gamepad_button_check(0, gp_face3);
	keyItem = keyboard_check_pressed(vk_control);

	inputDirection = point_direction(0,0,keyRight-keyLeft,keyDown-keyUp);
	inputMagnitude = (keyRight - keyLeft != 0) || (keyDown - keyUp != 0);
}

// Inherit the parent event
event_inherited();

threatTableUpdateTimer++;
if((state != UNIT_STATE.DIE) && (threatTableUpdateTimer >= threatTableUpdateRate))
{
	with(pEnemy)
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
