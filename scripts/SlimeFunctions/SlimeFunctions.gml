// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function SlimeIdle()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	image_index = 0;
	image_speed = 0;
	
	if(!instance_exists(target))
	{
		// there's no target, try to find one
		if(instance_exists(oPlayer)
		&& (point_distance(x, y, oPlayer.x, oPlayer.y) <= enemyAggroRadius))
		{
			// there's a player in the aggro radius
			target = oPlayer;
			if(!instance_exists(oPlayer.target))
			{
				oPlayer.target = id;
			}
			state = UNIT_STATE.CHASE;
		}
		else if(++timePassedBeforeWandering >= waitTimeBeforeWandering)
		{
			// there's no player in the aggro radius, go to wander around mode
			timePassedBeforeWandering = 0;
			timePassedWandering = 0;
			dir = point_direction(x, y, xstart, ystart) + irandom_range(-45, 45);
			xTo = x + lengthdir_x(wanderDistance, dir);
			yTo = y + lengthdir_y(wanderDistance, dir);
			state = UNIT_STATE.WANDER;
		}
	}
	else
	{
		// look at target
		dir = point_direction(x, y, target.x, target.y);
		hSpeed = lengthdir_x(1, dir);
		if(hSpeed != 0)
		{
			image_xscale = sign(hSpeed);
		}
		
		// check if close enough to launch an attack
		if(point_distance(x, y, target.x, target.y) <= attackRange)
		{
			if(attackTime >= attackSpeed)
			{
				attackTime = 0;
				sprite_index = sprites[UNIT_SPRITE.ATTACK];
				image_index = 0;
				image_speed = 1.0;
				state = UNIT_STATE.ATTACK;
			}
		}
		else
		{
			state = UNIT_STATE.CHASE;
		}
		
		// reset if too far from the target
		if(point_distance(x, y, target.x, target.y) >= aggroResetRadius)
		{
			target = noone;
			state = UNIT_STATE.RESET;
		}
	}
}

function SlimeWander()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
	// at destination or given up?
	if(((x == xTo) && (y == yTo))
	|| (timePassedWandering > wanderDistance / unitSpeed))
	{
		hSpeed = 0;
		vSpeed = 0;
		
		// end our move animation
		if(image_index < 1)
		{
			image_speed = 0.0;
			image_index = 0;
		}
		
		timePassedBeforeWandering = 0;
		timePassedWandering = 0;
		state = UNIT_STATE.IDLE;
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
	
	// check for aggro while wandering
	if(instance_exists(oPlayer)
	&& (point_distance(x, y, oPlayer.x, oPlayer.y) <= enemyAggroRadius))
	{
		target = oPlayer;
		if(!instance_exists(oPlayer.target))
		{
			oPlayer.target = id;
		}
		state = UNIT_STATE.CHASE;
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
		image_speed = 1.0;
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
		if(attackTime >= attackSpeed)
		{
			attackTime = 0;
			sprite_index = sprites[UNIT_SPRITE.ATTACK];
			image_index = 0;
			image_speed = 1.0;
			state = UNIT_STATE.ATTACK;
		}
		else
		{
			state = UNIT_STATE.IDLE;
		}
	}
	
	// reset if too far from the target
	if(instance_exists(target)
	&& (point_distance(x, y, target.x, target.y) >= aggroResetRadius))
	{
		target = noone;
		state = UNIT_STATE.RESET;
	}
}

function SlimeAttack()
{
	if(instance_exists(target))
	{
		dir = point_direction(x, y, target.x, target.y);
		hSpeed = lengthdir_x(1, dir);
		if(hSpeed != 0)
		{
			image_xscale = sign(hSpeed);
		}
	}
	
	if(image_index > image_number -1)
	{
		state = UNIT_STATE.IDLE;
		attackTime = 0;
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
			image_xscale = -sign(hSpeed);
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

function SlimeReset()
{
	target = noone;
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
	// back at the start or given up?
	if(((x == xstart) && (y == ystart))
	|| (timePassedResetting > aggroResetRadius / unitSpeed))
	{
		x = xstart;
		y = ystart;
		hSpeed = 0;
		vSpeed = 0;
		
		// end our move animation
		if(image_index < 1)
		{
			image_speed = 0.0;
			image_index = 0;
		}
		
		timePassedResetting = 0;
		state = UNIT_STATE.WANDER;
	}
	else // move towards the start
	{
		timePassedResetting++;
		image_speed = 1.0;
		var _distanceToGo = point_distance(x, y, xstart, ystart);
		var _speedThisFrame = unitSpeed;
		if(_distanceToGo < unitSpeed)
		{
			_speedThisFrame = _distanceToGo;
		}
		dir = point_direction(x, y, xstart, ystart);
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