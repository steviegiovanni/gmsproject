// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SlimeWander()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
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
	
	// check for aggro
	if(++aggroCheck >= aggroCheckDuration)
	{
		aggroCheck = 0;
		if(instance_exists(oPlayer)
		&& (point_distance(x, y, oPlayer.x, oPlayer.y) <= enemyAggroRadius))
		{
			state = UNIT_STATE.CHASE;
			target = oPlayer;
		}
	}
}

function SlimeChase()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	if(instance_exists(target))
	{
		xTo = target.x;
		yTo = target.y;
		
		var _distanceToGo = point_distance(x, y, xTo, yTo);
		image_speed = 0.5;
		dir = point_direction(x, y, xTo, yTo);
		if(_distanceToGo > unitSpeed)
		{
			hSpeed = lengthdir_x(unitSpeed, dir);
			vSpeed = lengthdir_y(unitSpeed, dir);
		}
		else
		{
			hSpeed = lengthdir_x(_distanceToGo, dir);
			vSpeed = lengthdir_y(_distanceToGo, dir);
		}
		if(hSpeed != 0) image_xscale = sign(hSpeed);
		// collide and move
		UnitTileCollision();
	}
	
	// check if close enough to launch an attack
	if(instance_exists(target)
	&& (point_distance(x, y, target.x, target.y) <= attackRange))
	{
		state = UNIT_STATE.ATTACK;
		sprite_index = sprites[UNIT_SPRITE.ATTACK];
		image_index = 0;
		image_speed = 1.0;
		
		// target 8px past the player
		xTo += lengthdir_x(8, dir);
		yTo += lengthdir_y(8, dir);
	}
}

function SlimeAttack()
{
	// how fast to move
	var _spd = unitSpeed;
	
	// don't move while still getting ready to jump
	if(image_index < 2)
	{
		_spd = 0;
	}
	
	// freeze animation while in mid-air and also after landing finishes
	if(floor(image_index) == 3)
		|| (floor(image_index == 5))
	{
		image_speed = 0;
	}
	
	// how far we have to jumo
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	
	// begin landing end of the animation once we're nearly done
	if((_distanceToGo < 4) && (image_index < 5))
	{
		image_speed = 1.0;
	}
	
	// move
	if(_distanceToGo > _spd)
	{
		dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(_spd, dir);
		vSpeed = lengthdir_y(_spd, dir);
		if(hSpeed != 0)
		{
			image_xscale = sign(hSpeed);
		}
		
		// commit to move and stop moving if we hit a wall
		if(UnitTileCollision() == true)
		{
			xTo = x;
			yTo = y;
		}
	}
	else
	{
		x = xTo;
		y = yTo;
		if(floor(image_index) == 5)
		{
			stateTarget = UNIT_STATE.CHASE;
			stateWaitDuration = 15;
			state = UNIT_STATE.WAIT;
		}
	}
}

function SlimeHurt()
{
	sprite_index = sprites[UNIT_SPRITE.HURT];
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		image_speed = 1.0;
		dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, dir);
		vSpeed = lengthdir_y(unitSpeed, dir);
		
		if(hSpeed != 0)
		{
			image_xscale = -sign(hSpeed);
		}
		
		// collide and move, if there's a collision, then stop knockback
		if(UnitTileCollision())
		{
			xTo = x;
			yTo = y;
		}
	}
	else
	{
		x = xTo;
		y = yTo;
		if(statePrevious != UNIT_STATE.ATTACK)
		{
			state = statePrevious;
		}
		else
		{
			state = UNIT_STATE.CHASE;
		}
	}
}

function SlimeDie()
{
	sprite_index = sprites[UNIT_SPRITE.DIE];
	image_speed = 1.0;
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, dir);
		vSpeed = lengthdir_y(unitSpeed, dir);
		if(hSpeed != 0)
		{
			image_xScale = -sign(hSpeed);
		}
		
		// collide and move
		UnitTileCollision();
	}
	else
	{
		x = xTo;
		y = yTo;
	}
	
	if(image_index + (sprite_get_speed(sprite_index) / game_get_speed(gamespeed_fps)) >= image_number)
	{
		instance_destroy();
	}
}