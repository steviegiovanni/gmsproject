function PlayerStateFree()
{
	// movement
	hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);

	PlayerCollision();

	// update sprite index
	var _oldSprite = sprite_index;
	if(inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = sprites[UNIT_SPRITE.MOVE];
	}
	else
	{
		sprite_index = sprites[UNIT_SPRITE.IDLE];
	}

	if(_oldSprite != sprite_index)
	{
		localFrame = 0;
	}

	// update image index
	PlayerAnimateSprite();
	
	/*if(!instance_exists(target))
	{
		var _potentialTarget = instance_nearest(x, y, pEnemy);
		if(instance_exists(_potentialTarget) && point_distance(x, y, _potentialTarget.x, _potentialTarget.y) <= attackRadius)
		{
			target = _potentialTarget;
		} 
	}*/
	
	if(instance_exists(target) && point_distance(x, y, target.x, target.y) <= attackRadius)
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

function PlayerStateAttack()
{
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
	PlayerAnimateSprite();
	
	if(animationEnd)
	{
		state = UNIT_STATE.IDLE;
		animationEnd = false;
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
						HurtEnemy(id, 5, other.id, 10);
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

function HurtEnemy(_enemy, _damage, _source, _knockback)
{
	with(_enemy)
	{
		if(state != UNIT_STATE.DIE)
		{
			enemyHP -= _damage;
			flash = 1;
			
			// hurt or dead?
			if(enemyHP <= 0)
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

function PlayerStateBonk(){
	// movement
	hSpeed = lengthdir_x(speedBonk, direction - 180);
	vSpeed = lengthdir_y(speedBonk, direction - 180);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedBonk);
	var _collided = PlayerCollision();
	
	// update sprite
	sprite_index = Sprite1_Hurt;
	
	switch(CARDINAL_DIR)
	{
		case 0: 
		{
			image_index = 2;
		}break;
		case 2:
		{
			image_index = 0;
		}break;
		case 3:
		{
			image_index = 1;
		}break;
		default:
		{
			image_index = 3;
		}break;
	}
	
	// change height
	z = sin(((moveDistanceRemaining / distanceBonk) * pi)) * distanceBonkHeight;
	
	// change state
	if(moveDistanceRemaining <= 0)
	{
		state = UNIT_STATE.IDLE;
	}
}

function PlayerStateRoll()
{
	// movement
	hSpeed = lengthdir_x(speedRoll, direction);
	vSpeed = lengthdir_y(speedRoll, direction);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedRoll);
	var _collided = PlayerCollision();
	
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