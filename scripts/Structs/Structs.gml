function Action(_actionName, _cooldown, _actionCheck, _actionCommit) constructor
{
	actionName = _actionName;
	cooldown = _cooldown;
	timer = cooldown;
	actionCheck = _actionCheck;
	actionCommit = _actionCommit;
}