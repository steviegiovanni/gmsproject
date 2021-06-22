// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function EnemyIdle()
{
	// look at target if exists
	if(instance_exists(target))
	{
		direction = point_direction(x, y, target.x, target.y);
	}
	
	var _alerted = ds_map_size(threatTable) > 0;
	if(_alerted)
	{
		sprite_index = sprites[UNIT_SPRITE.ALERT];
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.ALERT]);
	}
	else
	{
		sprite_index = sprites[UNIT_SPRITE.IDLE];
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.IDLE]);
	}
	
	// if there's no threat, we want to wander around
	if((ds_map_size(threatTable) <= 0) && (++timePassedBeforeWandering >= waitTimeBeforeWandering))
	{
		timePassedBeforeWandering = 0;
		timePassedMoving = 0;
		direction = point_direction(x, y, xstart, ystart) + irandom_range(-45, 45);
		xTo = x + lengthdir_x(wanderDistance, direction);
		yTo = y + lengthdir_y(wanderDistance, direction);
		state = UNIT_STATE.WANDER;
		return;
	}
	
	UnitLatchOn();
	UnitActionLoop();
}

function EnemyWander()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
	// at destination or given up, or threat table has values now
	if(((x == xTo) && (y == yTo))
	|| (timePassedMoving > wanderDistance / unitSpeed)
	|| (ds_map_size(threatTable) > 0))
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
		timePassedMoving = 0;
		state = UNIT_STATE.IDLE;
	}
	else // move towards new destination
	{
		timePassedMoving++;
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
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.MOVE]);
		
		// collide and move
		UnitCollision();
	}
}

function EnemyChase()
{
	// if our target is not valid, stop chasing and reset
	if(!instance_exists(target))
	{
		target = noone;
		timePassedMoving = 0;
		state = UNIT_STATE.RESET;
		return;
	}
	
	// special reset case, unit is chasing to attack OR doing default latch on but the unit to follow is super far
	if(point_distance(x, y, target.x, target.y) > aggroLostRadius)
	{
		target = noone;
		timePassedMoving = 0;
		maxResetTime = point_distance(x, y, xstart, ystart) / unitSpeed;
		state = UNIT_STATE.RESET;
		return;
	}
	
	// if we have reach the desired distance, continue action or back to idle
	if(point_distance(x, y, target.x, target.y) <= chaseStopRadius)
	{
		if(action == -1)
		{
			timePassedMoving = 0;
			state = UNIT_STATE.IDLE;
		}
		else if(action < ds_list_size(actionTable))
		{
			ActionCommit();
		}
		return;
	}
	
	sprite_index = sprites[UNIT_SPRITE.MOVE];

	// configure movement speed while chasing
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
	script_execute(spriteAnimationFunctions[UNIT_SPRITE.MOVE]);
		
	// collide and move
	UnitCollision();
}

function EnemyDie()
{
	sprite_index = sprites[UNIT_SPRITE.DIE];
	image_speed = 1.0;
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		var _dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, _dir);
		vSpeed = lengthdir_y(unitSpeed, _dir);
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.DIE]);
		
		// collide and move
		UnitCollision();
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

function EnemyReset()
{
	target = noone;
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
	// back at the start or given up?
	if(((x == xstart) && (y == ystart))
	|| (timePassedMoving > maxResetTime))
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
		
		timePassedMoving = 0;
		state = UNIT_STATE.WANDER;
	}
	else // move towards the start
	{
		timePassedMoving++;
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
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.MOVE]);
		
		// collide and move
		UnitCollision();
	}
}