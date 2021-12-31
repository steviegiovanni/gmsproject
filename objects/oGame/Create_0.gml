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
ds_list_add(global.units, new UnitDefinition("p1", oPlayer, new UnitStats(200), pointer_null));
ds_list_add(global.units, new UnitDefinition("bat", oBat, new UnitStats(100), pointer_null));

global.partyMembers = ds_list_create();
ds_list_add(global.partyMembers, new PartyMember(0, pointer_null, new UnitStats(global.units[| 0].baseStats.hp), pointer_null));
ds_list_add(global.partyMembers, new PartyMember(1, pointer_null, new UnitStats(global.units[| 1].baseStats.hp), pointer_null));

global.activeParty = ds_list_create();
ds_list_add(global.activeParty, 1);
ds_list_add(global.activeParty, 0);

room_goto(ROOM_START);