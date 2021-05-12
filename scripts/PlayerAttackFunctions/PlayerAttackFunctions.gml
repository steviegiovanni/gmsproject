function AttackSlash()
{
	// attack just started
	if(sprite_index != Sprite1_AttackSlash)
	{
		// set up correct animation
		sprite_index = Sprite1_AttackSlash;
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
		state =	PlayerStateFree;
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
				if(state != UNIT_STATE.HURT)
				{
					statePrevious = state;
				}
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