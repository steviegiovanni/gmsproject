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

function UnitStats(_hp) constructor
{
	hp = _hp;
}

function UnitDefinition(_uuid, _unit, _baseStats, _statGrowths) constructor
{
	uuid = _uuid;
	unit = _unit;
	baseStats = _baseStats;
	statGrowths = _statGrowths;
}

function PartyMember(_uid, _lvl, _currentStats, _equips) constructor
{
	uid = _uid;
	lvl = _lvl;
	currentStats = _currentStats;
	equips = _equips;
}
