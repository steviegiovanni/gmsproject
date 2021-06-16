/// @description Pause the game
if(keyboard_check_pressed(vk_escape))
{
	global.gamePaused = !global.gamePaused;
	
	if(global.gamePaused)
	{
		with(all)
		{
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
		}
	}
	else
	{
		with(all)
		{
			image_speed = gamePausedImageSpeed;
		}
	}
}

if(keyboard_check_pressed(ord("E")))
{
	with(pAlly)
	{
		fleeing = true;
	}
}

if(keyboard_check_released(ord("E")))
{
	with(pAlly)
	{
		fleeing = false;
	}
}

if(keyboard_check_pressed(ord("F")))
{
	global.focusAttacks = !global.focusAttacks;
}

if(keyboard_check_pressed(ord("T")))
{
	global.debug = !global.debug;
}

if(!instance_exists(global.controlledUnit))
{
	with(pAlly)
	{
		if(playerControlled)
		{
			global.controlledUnit = id;
			break;
		}
	}
}
