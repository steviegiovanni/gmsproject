// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AllyIdle()
{
	if(!instance_exists(global.controlledUnit))
	{
		return;
	}
	
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
	
	if(fleeing 
	|| (!global.focusAttacks && (ds_map_size(threatTable)  <= 0))
	|| (global.focusAttacks && (ds_map_size(global.controlledUnit.threatTable) <= 0)))
	{
		if(point_distance(x, y, global.controlledUnit.x, global.controlledUnit.y) > attackRange)
		{
			timePassedMoving = 0;
			state = UNIT_STATE.RESET;
		}
		return;
	}
	
	UnitLatchOn();
	UnitActionLoop();
}

function AllyChase()
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
			script_execute(actionTable[| action].actionCommit);
		}
		return;
	}
	
	sprite_index = sprites[UNIT_SPRITE.MOVE];

	// configure movement speed while chasing
	xTo = target.x;
	yTo = target.y;
		
	var _distanceToGo = point_distance(x, y, xTo, yTo);
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

function AllyReset()
{
	sprite_index = sprites[UNIT_SPRITE.MOVE];
	
	if(!instance_exists(global.controlledUnit)
	|| (!fleeing && ((!global.focusAttacks && (ds_map_size(threatTable)  > 0)) || (global.focusAttacks && (ds_map_size(global.controlledUnit.threatTable)  > 0))))
	|| (point_distance(x, y, global.controlledUnit.x, global.controlledUnit.y) <= attackRange))
	{
		timePassedMoving = 0;
		state = UNIT_STATE.IDLE;
		return;
	}
	
	if(++timePassedMoving > maxResetTime)
	{
		timePassedMoving = 0;
		do
		{
			var _direction = point_direction(global.controlledUnit.x, global.controlledUnit.y, x, y) + irandom_range(-90, 90);
			var _x = global.controlledUnit.x + lengthdir_x(attackRange, _direction);
			var _y = global.controlledUnit.y + lengthdir_y(attackRange, _direction);
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
	
	var _speedThisFrame = unitSpeed;
	var _distance = point_distance(x, y, global.controlledUnit.x, global.controlledUnit.y);
	if(_distance < unitSpeed)
	{
		_speedThisFrame = _distance;
	}
	direction = point_direction(x, y, global.controlledUnit.x, global.controlledUnit.y);
	hSpeed = lengthdir_x(_speedThisFrame, direction);
	vSpeed = lengthdir_y(_speedThisFrame, direction);
	script_execute(spriteAnimationFunctions[UNIT_SPRITE.MOVE]);
		
	// collide and move
	UnitCollision();	
}
