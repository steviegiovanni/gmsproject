function Action(_actionName, _skillId, _actionCheck, _actionCommit) constructor
{
	actionName = _actionName;
	skillId = _skillId;
	actionCheck = _actionCheck;
	actionCommit = _actionCommit;
}

function Skill(_skillName, _skillCooldown) constructor
{
	skillName = _skillName;
	skillCooldown = _skillCooldown;
	skillTimer = skillCooldown;
}