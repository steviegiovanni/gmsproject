// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UnitWander()
{
	sprite_index = sprMove;
	
	// at destination or given up?
	if(((x == xTo) && (y == yTo)) || timePassedWandering > wanderDistance / unitSpeed)
	{
		hSpeed = 0;
		vSpeed = 0;
		
		// end our move animation
		if(image_index < 1)
		{
			image_speed = 0.0;
			image_index = 0;
		}
		
		// set new target destination
		if(++timePassedBeforeWandering >= waitTimeBeforeWandering)
		{
			timePassedBeforeWandering = 0;
			timePassedWandering = 0;
			dir = point_direction(x, y, xstart, ystart) + irandom_range(-45, 45);
			xTo = x + lengthdir_x(wanderDistance, dir);
			yTo = y + lengthdir_y(wanderDistance, dir);
		}
	}
	else // move towards new destination
	{
		timePassedWandering++;
		image_speed = 1.0;
		var _distanceToGo = point_distance(x, y, xTo, yTo);
		var _speedThisFrame = unitSpeed;
		if(_distanceToGo < unitSpeed)
		{
			_speedThisFrame = _distanceToGo;
		}
		dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(_speedThisFrame, dir);
		vSpeed = lengthdir_y(_speedThisFrame, dir);
		if(hSpeed != 0)
		{
			image_xscale = sign(hSpeed);
		}
		
		// collide and move
		UnitTileCollision();
	}
}