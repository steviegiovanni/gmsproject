// initialise & globals
randomize();
global.gamePaused = false;
global.focusAttacks = true;
global.textSpeed = .75;
global.debug = true;

// room transition
global.targetRoom = -1;
global.targetRoomStartX = -1;
global.targetRoomStartY = -1;
global.targetRoomStartDirection = 0;

global.iCamera = instance_create_layer(0, 0, layer, oCamera);
global.controlledUnit = noone;

surface_resize(application_surface, RESOLUTION_W, RESOLUTION_H);

room_goto(ROOM_START);