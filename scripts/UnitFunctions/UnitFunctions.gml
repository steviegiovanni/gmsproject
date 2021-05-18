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
{}

function DamageUnit(_unit, _damage, _source, _knockback)
{
	with(_unit)
	{
		if(state != UNIT_STATE.DIE)
		{
			hp -= _damage;
			flash = 1;
			
			// hurt or dead?
			if(hp <= 0)
			{
				state = UNIT_STATE.DIE;
			}
			else
			{
				state = UNIT_STATE.HURT;
			}
			
			image_index = 0;
			if(_knockback != 0)
			{
				var _knockDirection = point_direction(x, y, (_source).x, (_source).y);
				xTo = x - lengthdir_x(_knockback, _knockDirection);
				yTo = y - lengthdir_y(_knockback, _knockDirection);
			}
		}
	}
}