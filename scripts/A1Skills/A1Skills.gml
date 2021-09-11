function A1Attack1()
{
	if(playerControlled)
	{
		// movement
		hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
		vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);
	
		UnitCollision();
	}
	
	// attack just started
	if(sprite_index != sA1Attack2)
	{
		// set up correct animation
		sprite_index = sA1Attack2;
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
		comboDecay = 30;
		comboTimer = 0;
		if(++comboCount == maxComboCount)
		{
			comboCount = 0;
		}
		
		state = UNIT_STATE.IDLE;
	}
}

function A1CheckAttack1()
{
	var _highestEnmityUnit = GetHighestEnmityUnitFromThreatTableGeneralized();
	if(instance_exists(_highestEnmityUnit) && (comboCount == 0))
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

function A1Attack2()
{
	if(playerControlled)
	{
		// movement
		hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
		vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);
	
		UnitCollision();
	}
	
	// attack just started
	if(sprite_index != sA1Attack)
	{
		// set up correct animation
		sprite_index = sA1Attack;
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
		comboDecay = 30;
		comboTimer = 0;
		if(++comboCount == maxComboCount)
		{
			comboCount = 0;
		}
		
		state = UNIT_STATE.IDLE;
	}
}

function A1CheckAttack2()
{
	var _highestEnmityUnit = GetHighestEnmityUnitFromThreatTableGeneralized();
	if(instance_exists(_highestEnmityUnit) && (comboCount == 1))
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

function A1Attack3()
{
	if(playerControlled)
	{
		// movement
		hSpeed = lengthdir_x(inputMagnitude * unitSpeed, inputDirection);
		vSpeed = lengthdir_y(inputMagnitude * unitSpeed, inputDirection);
	
		UnitCollision();
	}
	
	// attack just started
	if(sprite_index != sA1Attack3)
	{
		// set up correct animation
		sprite_index = sA1Attack3;
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
		comboDecay = 30;
		comboTimer = 0;
		if(++comboCount == maxComboCount)
		{
			comboCount = 0;
		}
		
		state = UNIT_STATE.IDLE;
	}
}

function A1CheckAttack3()
{
	var _highestEnmityUnit = GetHighestEnmityUnitFromThreatTableGeneralized();
	if(instance_exists(_highestEnmityUnit) && (comboCount == 2))
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
