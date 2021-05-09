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
					if(entityHitScript != -1)
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