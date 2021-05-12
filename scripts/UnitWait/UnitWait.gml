// when unit is on cooldown
function UnitWait()
{
	if(++stateWait >= stateWaitDuration)
	{
		stateWait = 0;
		state = stateTarget;
	}
}