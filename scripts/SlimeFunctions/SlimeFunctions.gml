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
			direction = point_direction(x, y, xstart, ystart) + irandom_range(-45, 45);
			xTo = x + lengthdir_x(wanderDistance, direction);
			yTo = y + lengthdir_y(wanderDistance, direction);
			state = UNIT_STATE.WANDER;
		}
	}
	else
	{
		// look at target
		direction = point_direction(x, y, target.x, target.y);
		AnimateSpriteSimple();
		
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
		direction = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(_speedThisFrame, direction);
		vSpeed = lengthdir_y(_speedThisFrame, direction);
		AnimateSpriteSimple();
		
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
		direction = point_direction(x, y, xTo, yTo);
		if(_distanceToGo > unitSpeed)
		{
			hSpeed = lengthdir_x(unitSpeed, direction);
			vSpeed = lengthdir_y(unitSpeed, direction);
		}
		else
		{
			hSpeed = lengthdir_x(_distanceToGo, direction);
			vSpeed = lengthdir_y(_distanceToGo, direction);
		}
		AnimateSpriteSimple();
		
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
		direction = point_direction(x, y, target.x, target.y);
		AnimateSpriteSimple();
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
		var _dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, _dir);
		vSpeed = lengthdir_y(unitSpeed, _dir);
		
		AnimateSpriteSimple();
		
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
		state = UNIT_STATE.IDLE;
	}
}

function SlimeDie()
{
	sprite_index = sprites[UNIT_SPRITE.DIE];
	image_speed = 1.0;
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		var _dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, _dir);
		vSpeed = lengthdir_y(unitSpeed, _dir);
		AnimateSpriteSimple();
		
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
		direction = point_direction(x, y, xstart, ystart);
		hSpeed = lengthdir_x(_speedThisFrame, direction);
		vSpeed = lengthdir_y(_speedThisFrame, direction);
		AnimateSpriteSimple();
		
		// collide and move
		UnitTileCollision();
	}
}