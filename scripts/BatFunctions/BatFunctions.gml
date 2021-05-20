// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BatIdle()
{
	if(instance_exists(oPlayer))
	{
		var _distance = point_distance(x, y, oPlayer.x, oPlayer.y);
		if(_distance >= chasePlayerStartRadius)
		{
			timePassedMoving = 0;
			state = UNIT_STATE.WANDER;
		}
	}
}

function BatFollow()
{
	if(instance_exists(oPlayer))
	{
		var _distance = point_distance(x, y, oPlayer.x, oPlayer.y);
		if(_distance <= chasePlayerStopRadius)
		{
			timePassedMoving = 0;
			state = UNIT_STATE.IDLE;
		}
		else if(timePassedMoving >= chasePlayerMaxTime)
		{
			timePassedMoving = 0;
			x = oPlayer.x;
			y = oPlayer.y;
			state = UNIT_STATE.IDLE;
		}
		else
		{
			timePassedMoving++;
			image_speed = 1.0;
			var _speedThisFrame = unitSpeed;
			if(_distance < unitSpeed)
			{
				_speedThisFrame = _distance;
			}
			direction = point_direction(x, y, oPlayer.x, oPlayer.y);
			hSpeed = lengthdir_x(_speedThisFrame, direction);
			vSpeed = lengthdir_y(_speedThisFrame, direction);
			AnimateSpriteSimple();
		
			// collide and move
			UnitCollision();	
		}
	}
}
