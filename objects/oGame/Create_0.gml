// initialise & globals
randomize();
global.gamePaused = false;
global.focusAttacks = true;
global.textSpeed = .75;
global.debug = true;

// room transition
global.targetRoom = -1;
global.targetRoomStartX = 120;
global.targetRoomStartY = 136;
global.targetRoomStartDirection = 0;

global.iCamera = instance_create_layer(0, 0, layer, oCamera);
global.controlledUnit = noone;

global.units = ds_list_create();
ds_list_add(global.units, UnitDefinition("p1", oPlayer, UnitStats(200), pointer_null));
ds_list_add(global.units, UnitDefinition("bat", oBat, UnitStats(100), pointer_null));
ds_list_add(global.units, UnitDefinition("slime", oSlime, UnitStats(50), pointer_null));


global.partyMembers = ds_list_create();
ds_list_add(global.partyMembers, PartyMember(0, pointer_null, global.units[| 0][? UNIT_DEFINITION.BASE_STATS], pointer_null));
ds_list_add(global.partyMembers, PartyMember(1, pointer_null, global.units[| 1][? UNIT_DEFINITION.BASE_STATS], pointer_null));

//show_debug_message("####### lalala " + string(global.units[| 0][? UNIT_DEFINITION.BASE_STATS][? STATS.HEALTH]));
//global.partyMembers[| 0][? PARTY_MEMBER.CURRENT_STATS][? STATS.HEALTH] = -10;
//show_debug_message("####### lilili " + string(global.units[| 0][? UNIT_DEFINITION.BASE_STATS][? STATS.HEALTH]));

global.activeParty = ds_list_create();
ds_list_add(global.activeParty, 0);
ds_list_add(global.activeParty, 1);

room_goto(ROOM_START);