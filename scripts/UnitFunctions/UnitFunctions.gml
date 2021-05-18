function AnimateSprite4Dir()
{
	// update sprite
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (CARDINAL_DIR * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;

	// if animation would loop on next game step
	if(localFrame >= _totalFrames)
	{
		localFrame -= _totalFrames;
		return true;
	}
	else
	{
		return false;
	}
}

function AnimateSpriteSimple()
{
	var _dir = lengthdir_x(1, direction);
	if(_dir != 0)
	{
		image_xscale = sign(_dir);
	}
}

function UnitLocked()
{
	//image_speed = 0;
}