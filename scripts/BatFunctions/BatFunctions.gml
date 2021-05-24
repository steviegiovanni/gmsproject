// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function BatIdle()
{
	if(!instance_exists(oPlayer))
	{
		return;
	}
	
	if(fleeing 
	|| (!global.focusAttacks && (ds_map_size(threatTable)  <= 0))
	|| (global.focusAttacks && (ds_map_size(oPlayer.threatTable) <= 0)))
	{
		if(point_distance(x, y, oPlayer.x, oPlayer.y) > attackRange)
		{
			timePassedMoving = 0;
			state = UNIT_STATE.RESET;
		}
		return;
	}
	
	// get highest enmity unit or player's highest enmity unit based on global.focusAttacks
	var _highestEnmityUnit = noone;
	if(global.focusAttacks)
	{
		with(oPlayer)
		{
			_highestEnmityUnit = GetHighestEnmityUnitFromThreatTable();
		}
	}
	else
	{
		_highestEnmityUnit = GetHighestEnmityUnitFromThreatTable();
	}
	
	// if there's threat, latch onto the highest enmity unit by default 
	target = _highestEnmityUnit;
	if(instance_exists(target) && (point_distance(x, y, target.x, target.y) > attackRange))
	{
		chaseStopRadius = attackRange;
		chaseState = UNIT_STATE.IDLE;
		state = UNIT_STATE.CHASE;
	}
	
	// if auto attack is not on cooldown, overwrite the action to auto attack
	if((attackTime >= attackSpeed) && instance_exists(_highestEnmityUnit))
	{
		target = _highestEnmityUnit;
		if(point_distance(x, y, target.x, target.y) <= attackRange)
		{
			attackTime = 0;
			sprite_index = sprites[UNIT_SPRITE.ATTACK];
			image_index = 0;
			image_speed = 1.0;
			state = UNIT_STATE.ATTACK;
		}
		else
		{
			chaseStopRadius = attackRange;
			chaseState = UNIT_STATE.ATTACK;
			state = UNIT_STATE.CHASE;
		}
	}
	
	// look at target if exists
	if(instance_exists(target))
	{
		direction = point_direction(x, y, target.x, target.y);
		AnimateSpriteSimple();
	}
}

function BatChase()
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
	if(((chaseState == UNIT_STATE.ATTACK) || (chaseState == UNIT_STATE.IDLE))
	&& (point_distance(x, y, target.x, target.y) > aggroLostRadius))
	{
		target = noone;
		timePassedMoving = 0;
		state = UNIT_STATE.RESET;
		return;
	}
	
	// if we have reach the desired distance, update the state to the previously set chaseState
	if(point_distance(x, y, target.x, target.y) <= chaseStopRadius)
	{
		state = chaseState;
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
	AnimateSpriteSimple();
		
	// collide and move
	UnitCollision();
}

function BatAttack()
{
	sprite_index = sprites[UNIT_SPRITE.ATTACK];
	if(instance_exists(target))
	{
		direction = point_direction(x, y, target.x, target.y);
		AnimateSpriteSimple();
	}
	
	if(image_index > image_number -1)
	{
		if(instance_exists(target))
		{
			DamageUnit(target, 5, id, 10);
		}
		
		state = UNIT_STATE.IDLE;
		attackTime = 0;
	}
}

function BatReset()
{
	if(!instance_exists(oPlayer)
	|| (!fleeing && ((!global.focusAttacks && (ds_map_size(threatTable)  > 0)) || (global.focusAttacks && (ds_map_size(oPlayer.threatTable)  > 0))))
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
