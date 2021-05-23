function AnimateSprite4Dir()
{
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

function AnimateSpriteSimple()
{
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
			hp -= _damage;
			flash = 1;
			
			// hurt or dead?
			if(hp <= 0)
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
