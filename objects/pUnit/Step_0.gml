/// @description execute state machine
if(!global.gamePaused)
{
	// clean threat table
	var it = ds_map_find_first(threatTable);
	while(!is_undefined(it))
	{
		var _unit = it;
		it = ds_map_find_next(threatTable, it);
		if(!instance_exists(_unit)
		|| (_unit.state == UNIT_STATE.DIE)
		|| (point_distance(x, y, _unit.x, _unit.y) >= aggroLostRadius))
		{
			ds_map_delete(threatTable, _unit);
		}
	}
	
	// update skill cooldowns
	for(var _it = 0; _it < ds_list_size(skillTable); ++_it)
	{
		if((action == -1)
		|| (actionTable[| action].skillId != _it))
		{
			skillTable[| _it].skillTimer++;
		}
	}
	
	// combo decay
	if(++comboTimer > comboDecay)
	{
		comboCount = 0;
		comboTimer = 0;
	}
	
	if(unitScript[state] != -1)
	{
		script_execute(unitScript[state]);
		depth = -bbox_bottom;
	}
}