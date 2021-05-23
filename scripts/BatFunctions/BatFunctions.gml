// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BatIdle()
{
	if((fleeing || (ds_map_size(threatTable)  <= 0))
	&& instance_exists(oPlayer)
	&& (point_distance(x, y, oPlayer.x, oPlayer.y) > attackRange))
	{
		timePassedMoving = 0;
		state = UNIT_STATE.RESET;
		return;
	}
}

function BatReset()
{
	if(!fleeing && (ds_map_size(threatTable)  > 0)
	|| !instance_exists(oPlayer)
	|| (point_distance(x, y, oPlayer.x, oPlayer.y) <= attackRange))
	{
		timePassedMoving = 0;
		state = UNIT_STATE.IDLE;
		return;
	}
	
	if(++timePassedMoving > chasePlayerMaxTime)
	{
		timePassedMoving = 0;
		do
		{
			var _direction = point_direction(oPlayer.x, oPlayer.y, x, y) + irandom_range(-90, 90);
			var _x = oPlayer.x + lengthdir_x(attackRange, _direction);
			var _y = oPlayer.y + lengthdir_y(attackRange, _direction);
			var _collision = tilemap_get_at_pixel(collisionMap, _x, _y);
			
			if(!_collision)
			{
				x = _x;
				y = _y;
			}
		} until(!_collision);
		state = UNIT_STATE.IDLE;
		return;
	}
	
	image_speed = 1.0;
	var _speedThisFrame = unitSpeed;
	var _distance = point_distance(x, y, oPlayer.x, oPlayer.y);
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
