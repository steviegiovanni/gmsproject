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