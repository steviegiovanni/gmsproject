/// @description all entities that can battle

// Inherit the parent event
event_inherited();

// threat table
threatTable = ds_map_create();
threatTableUpdateRate = 5;
threatTableUpdateTimer = threatTableUpdateRate;

// action table
actionTable = ds_list_create();
action = -1;

// state management variables
state = UNIT_STATE.IDLE;
lastState = state;

// chase parameters
chaseStopRadius = 0;

// stats
hp = 50;

// movement parameters
hSpeed = 0;
vSpeed = 0;
xTo = xstart;
yTo = ystart;
unitSpeed = 0.75;
z = 0;

// sprite logic parameters
localFrame = 0;

// wander around behavior parameters
timePassedMoving = 0;
waitTimeBeforeWandering = 60;
timePassedBeforeWandering = 0;
wanderDistance = 32;

// aggro parameters
aggroRadius = 40;
aggroLostRadius = 100;

// auto attack parameters
attackRange = 16;
attackSpeed = 240;
attackTime = attackSpeed;

// targetting parameters
target = noone;

// sprites
sprites[UNIT_SPRITE.IDLE] = sSlime;
sprites[UNIT_SPRITE.MOVE] = sSlime;
sprites[UNIT_SPRITE.ATTACK] = sSlime;
sprites[UNIT_SPRITE.HURT] = sSlime;
sprites[UNIT_SPRITE.DIE] = sSlime;

// unit scripts
unitScript[UNIT_STATE.IDLE] = -1;
unitScript[UNIT_STATE.WANDER] = -1;
unitScript[UNIT_STATE.CHASE] = -1;
unitScript[UNIT_STATE.ATTACK] = -1;
unitScript[UNIT_STATE.HURT] = -1;
unitScript[UNIT_STATE.DIE] = -1;
unitScript[UNIT_STATE.RESET] = -1;
unitScript[UNIT_STATE.LOCKED] = UnitLocked;
