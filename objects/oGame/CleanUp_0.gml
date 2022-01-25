/// @description Insert description here
// You can write your code in this editor
if(ds_exists(global.units, ds_type_list))
{
	for(var i = 0; i < ds_list_size(global.units); i++)
	{
		if(ds_exists(global.units[| i], ds_type_map))
		{
			if(ds_exists(global.units[| i][? UNIT_DEFINITION.BASE_STATS], ds_type_map))
			{
				ds_map_destroy(global.units[| i][? UNIT_DEFINITION.BASE_STATS]);
			}
			ds_map_destroy(global.units[| i]);
		}
	}
	ds_list_destroy(global.units);
}

if(ds_exists(global.partyMembers, ds_type_list))
{
	for(var i = 0; i < ds_list_size(global.partyMembers); i++)
	{
		if(ds_exists(global.partyMembers[| i], ds_type_map))
		{
			if(ds_exists(global.partyMembers[| i][? PARTY_MEMBER.CURRENT_STATS], ds_type_map))
			{
				ds_map_destroy(global.partyMembers[| i][? PARTY_MEMBER.CURRENT_STATS]);
			}
			ds_map_destroy(global.partyMembers[| i]);
		}
	}
	ds_list_destroy(global.partyMembers);
}

if(ds_exists(global.activeParty, ds_type_list))
{
	ds_list_destroy(global.activeParty);
}