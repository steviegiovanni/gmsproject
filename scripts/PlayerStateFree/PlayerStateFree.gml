// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateFree()
{
	// movement
	hSpeed = lengthdir_x(inputMagnitude * speedWalk, inputDirection);
	vSpeed = lengthdir_y(inputMagnitude * speedWalk, inputDirection);

	PlayerCollision();

	// update sprite index
	var _oldSprite = sprite_index;
	if(inputMagnitude != 0)
	{
		direction = inputDirection;
		sprite_index = spriteRun;
	}
	else
	{
		sprite_index = spriteIdle;
	}

	if(_oldSprite != sprite_index)
	{
		localFrame = 0;
	}

	// update image index
	PlayerAnimateSprite();
	
	// attack key logic
	if(keyAttack)
	{
		state = PlayerStateAttack;
		stateAttack = AttackSlash;
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
			state = PlayerStateRoll;
			moveDistanceRemaining = distanceRoll;
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