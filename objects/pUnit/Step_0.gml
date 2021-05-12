/// @description execute state machine
if(!global.gamePaused)
{
	if(unitScript[state] != -1)
	{
		script_execute(unitScript[state]);
		depth = -bbox_bottom;
	}
}