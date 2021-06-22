function Action(_actionName, _skillId, _actionCheck) constructor
{
	actionName = _actionName;
	skillId = _skillId;
	actionCheck = _actionCheck;
}

function Skill(_skillName, _skillCooldown, _skillCommit) constructor
{
	skillName = _skillName;
	skillCommit = _skillCommit;
	skillCooldown = _skillCooldown;
	skillTimer = skillCooldown;
}