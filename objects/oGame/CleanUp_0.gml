/// @description Insert description here
// You can write your code in this editor
if(ds_exists(global.units, ds_type_list))
{
	ds_list_destroy(global.units);
}

if(ds_exists(global.partyMembers, ds_type_list))
{
	ds_list_destroy(global.partyMembers);
}

if(ds_exists(global.activeParty, ds_type_list))
{
	ds_list_destroy(global.activeParty);
}