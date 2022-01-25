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

function UnitStats(_hp)
{
	var unitStats = ds_map_create();
	unitStats[? STATS.HEALTH] = _hp;
	return unitStats;
}

function UnitDefinition(_uuid, _unit, _baseStats, _statGrowths)
{
	var unitDefinition = ds_map_create();
	unitDefinition[? UNIT_DEFINITION.UUID] = _uuid;
	unitDefinition[? UNIT_DEFINITION.UNIT] = _unit;
	unitDefinition[? UNIT_DEFINITION.BASE_STATS] = _baseStats;
	unitDefinition[? UNIT_DEFINITION.STAT_GROWTHS] = _statGrowths;
	return unitDefinition;
}

function PartyMember(_uid, _lvl, _currentStats, _equips)
{
	var partyMember = ds_map_create();
	partyMember[? PARTY_MEMBER.UID] = _uid;
	partyMember[? PARTY_MEMBER.LEVEL] = _lvl;
	partyMember[? PARTY_MEMBER.CURRENT_STATS] = ds_map_create();
	ds_map_copy(partyMember[? PARTY_MEMBER.CURRENT_STATS], _currentStats);
	partyMember[? PARTY_MEMBER.EQUIPS] = _equips;
	return partyMember;
}
