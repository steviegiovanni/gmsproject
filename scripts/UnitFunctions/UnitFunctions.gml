function AnimateSprite4Dir()
{
	image_speed = 0;
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

function AnimateSprite2Dir()
{
	image_speed = 0;
	var _totalFrames = sprite_get_number(sprite_index) / 2;
	image_index = localFrame + (LEFTRIGHT_DIR * _totalFrames);
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
	image_speed = 1;
	var _dir = lengthdir_x(1, direction);
	if(_dir != 0)
	{
		image_xscale = sign(_dir);
	}
}

function UnitCollision()
{
	var _collision = false;
	var _entityList = ds_list_create();
	
	// horizontal tiles
	if(tilemap_get_at_pixel(collisionMap, x + hSpeed, y))
	{
		x -= x mod TILE_SIZE;
		if(sign(hSpeed) == 1)
		{
			x += TILE_SIZE - 1;
		}
		hSpeed = 0;
		_collision = true;
	}
	
	// horizontal entities
	var _entityCount = instance_position_list(x + hSpeed, y, pEntity, _entityList, false);
	var _snapX;
	while(_entityCount > 0)
	{
		var _entityCheck = _entityList[| 0];
		if(_entityCheck.entityCollision == true)
		{
			// move as close as we can 
			if(sign(hSpeed) == -1)
			{
				_snapX = _entityCheck.bbox_right + 1;
			}
			else _snapX = _entityCheck.bbox_left - 1;
			x = _snapX;
			hSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	
	// horizontal move commit
	x += hSpeed;
	
	// clear list between axis
	ds_list_clear(_entityList);
	
	// vertical tiles
	if(tilemap_get_at_pixel(collisionMap, x, y + vSpeed))
	{
		y -= y mod TILE_SIZE;
		if(sign(vSpeed) == 1)
		{
			y += TILE_SIZE - 1;
		}
		vSpeed = 0;
		_collision = true;
	}
	
	// vertical entities
	var _entityCount = instance_position_list(x, y + vSpeed, pEntity, _entityList, false);
	var _snapY;
	while(_entityCount > 0)
	{
		var _entityCheck = _entityList[| 0];
		if(_entityCheck.entityCollision == true)
		{
			// move as close as we can 
			if(sign(vSpeed) == -1)
			{
				_snapY = _entityCheck.bbox_bottom + 1;
			}
			else _snapY = _entityCheck.bbox_top - 1;
			y = _snapY;
			vSpeed = 0;
			_collision = true;
			_entityCount = 0;
		}
		ds_list_delete(_entityList, 0);
		_entityCount--;
	}
	
	// vertical move commit
	y += vSpeed;
	
	ds_list_destroy(_entityList);
	
	return _collision;
}

function UnitLocked()
{}

function DamageUnit(_unit, _damage, _source, _knockback)
{
	with(_unit)
	{
		if(state != UNIT_STATE.DIE)
		{
			stats[? STATS.HEALTH] -= _damage;
			flash = 1;
			
			// hurt or dead?
			if(stats[? STATS.HEALTH] <= 0)
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
			
			timePassedKnockbacked = 0;
		}
	}
}

function GetClosestUnitFromThreatTable()
{
	var _closestUnit = noone;
	var _closestDistance = 9999;
	var _unit = ds_map_find_first(threatTable);
	while(!is_undefined(_unit))
	{
		if(instance_exists(_unit) && (_unit.state != UNIT_STATE.DIE))
		{
			var _distance = point_distance(x, y, _unit.x, _unit.y); 
			if((_distance < aggroLostRadius) && (_distance < _closestDistance))
			{
				_closestUnit = _unit;
				_closestDistance = _distance;
			}
		}
		_unit = ds_map_find_next(threatTable, _unit);
	}
	return _closestUnit;
}

function GetHighestEnmityUnitFromThreatTable()
{
	var _highestEnmityUnit = noone;
	var _highestEnmity = 0;
	var _unit = ds_map_find_first(threatTable);
	while(!is_undefined(_unit))
	{
		if(instance_exists(_unit) && (_unit.state != UNIT_STATE.DIE) && (threatTable[? _unit] > _highestEnmity))
		{
			_highestEnmity = threatTable[? _unit];
			_highestEnmityUnit = _unit;
		}
		_unit = ds_map_find_next(threatTable, _unit);
	}
	return _highestEnmityUnit;
}

function GetHighestEnmityUnitFromThreatTableGeneralized()
{
	var _highestEnmityUnit = noone;
	if((object_is_ancestor(object_index, pAlly)) && global.focusAttacks && instance_exists(global.controlledUnit))
	{
		with(global.controlledUnit)
		{
			_highestEnmityUnit = GetHighestEnmityUnitFromThreatTable();
		}
	}
	else
	{
		_highestEnmityUnit = GetHighestEnmityUnitFromThreatTable();
	}
	return _highestEnmityUnit;
}

function UnitLatchOn()
{
	var _highestEnmityUnit = GetHighestEnmityUnitFromThreatTableGeneralized();
	if(instance_exists(_highestEnmityUnit))
	{
		target = _highestEnmityUnit;
		if(point_distance(x, y, target.x, target.y) > meleeRange)
		{
			chaseStopRadius = meleeRange;
			state = UNIT_STATE.CHASE;
		}
	}
}

function UnitActionLoop()
{
	for(var _it = 0; _it < ds_list_size(actionTable); ++_it)
	{
		action = _it;
		var _skillId = actionTable[| action].skillId;
		if((_skillId < ds_list_size(skillTable))
		&& (skillTable[| _skillId].skillTimer > skillTable[| _skillId].skillCooldown)
		&& script_execute(actionTable[| action].actionCheck))
		{
			break;
		}
		action = -1;
	}
}

function ActionCheckAttack()
{
	var _highestEnmityUnit = GetHighestEnmityUnitFromThreatTableGeneralized();
	if(instance_exists(_highestEnmityUnit))
	{
		target = _highestEnmityUnit;
		if(point_distance(x, y, target.x, target.y) <= meleeRange)
		{
			ActionCommit();
		}
		else
		{
			chaseStopRadius = meleeRange;
			state = UNIT_STATE.CHASE;
		}
		return true;
	}
	return false;
}

function ActionCommit()
{
	if((action != -1) 
	&& (action < ds_list_size(actionTable))
	&& (actionTable[| action].skillId < ds_list_size(skillTable)))
	{
		skillTable[| (actionTable[| action].skillId)].skillTimer = 0;
	}
	image_index = 0;
	image_speed = 1.0;
	state = UNIT_STATE.COMMIT;
}

function UnitCommit()
{
	if((action != -1) 
	&& (action < ds_list_size(actionTable))
	&& (actionTable[| action].skillId < ds_list_size(skillTable)))
	{
		script_execute(skillTable[| (actionTable[| action].skillId)].skillCommit);
	}
}

function UnitAttack()
{
	sprite_index = sprites[UNIT_SPRITE.ATTACK];
	if(instance_exists(target))
	{
		direction = point_direction(x, y, target.x, target.y);
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.ATTACK]);
	}
	
	if(image_index > image_number -1)
	{
		if(instance_exists(target))
		{
			DamageUnit(target, 5, id, 10);
		}
		
		if(++comboCount == maxComboCount)
		{
			comboCount = 0;
		}
		
		state = UNIT_STATE.IDLE;
	}
}

function UnitHurt()
{
	if(++timePassedKnockbacked > knockbackRecoveryTime)
	{
		state = UNIT_STATE.IDLE;
		return;
	}
	
	sprite_index = sprites[UNIT_SPRITE.HURT];
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		image_speed = 1.0;
		var _dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, _dir);
		vSpeed = lengthdir_y(unitSpeed, _dir);
		
		script_execute(spriteAnimationFunctions[UNIT_SPRITE.HURT]);
		
		// collide and move, if there's a collision, then stop knockback
		if(UnitCollision())
		{
			xTo = x;
			yTo = y;
		}
	}
	else
	{
		x = xTo;
		y = yTo;
		//state = UNIT_STATE.IDLE;
	}
}
