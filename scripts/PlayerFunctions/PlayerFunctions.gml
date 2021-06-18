function PlayerStateFree()
{
	if(playerControlled)
	{
		PlayerIdleControlled();
	}
	else
	{
		AllyIdle();
	}
}

function PlayerIdleControlled()
{
	// movement
	hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);

	UnitCollision();

	var _alerted = ds_map_size(threatTable) > 0;

	// update sprite index
	var _oldSprite = sprite_index;
	if(inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = sprites[UNIT_SPRITE.MOVE];
	}
	else
	{
		if(_alerted)
		{
			sprite_index = sprites[UNIT_SPRITE.ALERT];
		}
		else
		{
			sprite_index = sprites[UNIT_SPRITE.IDLE];
		}
	}

	if(_oldSprite != sprite_index)
	{
		localFrame = 0;
	}

	// update image index
	if(_alerted && (inputMagnitude == 0))
	{
		AnimateSprite2Dir();
	}
	else
	{
		AnimateSprite4Dir();
	}
	
	if(!instance_exists(target))
	{
		var _potentialTarget = instance_nearest(x, y, pEnemy);
		if(instance_exists(_potentialTarget) && point_distance(x, y, _potentialTarget.x, _potentialTarget.y) <= attackRadius)
		{
			target = _potentialTarget;
		} 
	}
	
	if((attackTime >= attackSpeed)
	&& instance_exists(target)
	&& (point_distance(x, y, target.x, target.y) <= attackRadius))
	{
		state = UNIT_STATE.ATTACK;
	}
	
	// attack key logic
	if(keyAttack)
	{
		state = UNIT_STATE.ATTACK;
	}
	
	// activate key logic
	if(keyActivate)
	{
		// 1. check for an entity to activate
		// 2. if there is nothing, or there is something, but it has no script - roll
		// 3. otherwise, there is something and it has a script! activate!
		// 4. if the thing we activate is an npc, make it face towards us
		var _activateX = x + lengthdir_x(10, direction);
		var _activateY = y + lengthdir_y(10, direction);
		var _activateSize = 4;
		var _activateList = ds_list_create();
		activate = noone;
		var _entitiesFound = collision_rectangle_list(
			_activateX - _activateSize,
			_activateY - _activateSize,
			_activateX + _activateSize,
			_activateY + _activateSize,
			pEntity,
			false,
			true,
			_activateList,
			true
		);
		
		// if the first instance we find is either our lifted entity or it has no script: try the next one
		while(_entitiesFound > 0)
		{
			var _check = _activateList[| --_entitiesFound];
			if(_check.entityActivateScript != -1)
			{
				activate = _check;
				break;
			}
		}
		
		ds_list_destroy(_activateList);
		
		if(activate == noone)
		{
			//state = PlayerStateRoll;
			//moveDistanceRemaining = distanceRoll;
		}
		else
		{
			ScriptExecuteArray(activate.entityActivateScript, activate.entityActivateArgs);
			
			if(activate.entityNPC)
			{
				with(activate)
				{
					direction = point_direction(x, y, other.x, other.y);
					image_index = CARDINAL_DIR;
				}
			}
		}
	}
}

function PlayerIdleAI()
{
	if(!instance_exists(global.controlledUnit))
	{
		return;
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
	
	// look at target if exists
	if(instance_exists(target))
	{
		direction = point_direction(x, y, target.x, target.y);
		var _alerted = ds_map_size(threatTable) > 0;
		if(_alerted)
		{
			sprite_index = sprites[UNIT_SPRITE.ALERT];
		}
		else
		{
			sprite_index = sprites[UNIT_SPRITE.IDLE];
		}
	}
}

function PlayerStateAttack()
{
	// movement
	hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);
	
	UnitCollision();
	
	// attack just started
	if(sprite_index != sprites[UNIT_SPRITE.ATTACK])
	{
		// set up correct animation
		sprite_index = sprites[UNIT_SPRITE.ATTACK];
		localFrame = 0;
		image_index = 0;
		
		// clear hit list
		if(!ds_exists(hitByAttack, ds_type_list))
		{
			hitByAttack = ds_list_create();
		}
		ds_list_clear(hitByAttack);
	}
	
	CalcAttack(sPlayerAttackSlashHB);
	
	// update sprite
	var _animationEnd = AnimateSprite2Dir();
	
	if(_animationEnd)
	{
		attackTime = 0;
		state = UNIT_STATE.IDLE;
	}
}

// use attack hitbox & check for hit
function CalcAttack(_HBSprite)
{
	mask_index = _HBSprite;
	
	var _hitByAttackNow = ds_list_create();
	var _hits = instance_place_list(x, y, pEntity, _hitByAttackNow, false);
	if(_hits > 0)
	{
		for(var i = 0; i < _hits; i++)
		{
			// if this instance has not yet been hit by this attack, hit it!
			var _hitID = _hitByAttackNow[| i];
			if(ds_list_find_index(hitByAttack, _hitID) == -1)
			{
				ds_list_add(hitByAttack, _hitID);
				with(_hitID)
				{
					if(object_is_ancestor(object_index, pEnemy))
					{
						DamageUnit(id, 5, other.id, 10);
					}
					else if(entityHitScript != -1)
					{
						script_execute(entityHitScript);
					}
				}
			}
		}
	}
	
	ds_list_destroy(_hitByAttackNow);
	mask_index = Sprite1;
}

function PlayerHurt()
{
	sprite_index = sprites[UNIT_SPRITE.HURT];
	var _distanceToGo = point_distance(x, y, xTo, yTo);
	if(_distanceToGo > unitSpeed)
	{
		image_speed = 1.0;
		var _dir = point_direction(x, y, xTo, yTo);
		hSpeed = lengthdir_x(unitSpeed, _dir);
		vSpeed = lengthdir_y(unitSpeed, _dir);
		
		AnimateSprite2Dir();
		
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
		state = UNIT_STATE.IDLE;
	}
}

function PlayerStateRoll()
{
	// movement
	hSpeed = lengthdir_x(speedRoll, direction);
	vSpeed = lengthdir_y(speedRoll, direction);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedRoll);
	var _collided = UnitCollision();
	
	// update sprite
	sprite_index = spriteRoll;
	var _totalFrames = sprite_get_number(sprite_index)/4;
	image_index = (CARDINAL_DIR * _totalFrames) + min((1 - (moveDistanceRemaining / distanceRoll)) * _totalFrames, _totalFrames - 1);
	
	// change state
	if(moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
	
	if(_collided)
	{
		state = PlayerStateBonk;
		moveDistanceRemaining = distanceBonk;
		ScreenShake( 8, 30);
	}
}