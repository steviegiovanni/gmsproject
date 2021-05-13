/// @description all entities that can battle

// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

// movement parameters
hSpeed = 0;
vSpeed = 0;
xTo = xstart;
yTo = ystart;
dir = 0;
unitSpeed = 0.75;

// sprite logic parameters
localFrame = 0;

// wander around behavior parameters
timePassedWandering = 0;
waitTimeBeforeWandering = 60;
timePassedBeforeWandering = 0;
wanderDistance = 32;

// unit waiting for cooldown parameters
stateTarget = state;
statePrevious = state;
stateWait = 0;
stateWaitDuration = 0;

// sprites
sprites[UNIT_SPRITE.IDLE] = -1;
sprites[UNIT_SPRITE.MOVE] = -1;
sprites[UNIT_SPRITE.ATTACK] = -1;
sprites[UNIT_SPRITE.HURT] = -1;
sprites[UNIT_SPRITE.DIE] = -1;

// unit scripts
unitScript[UNIT_STATE.IDLE] = -1;
unitScript[UNIT_STATE.WANDER] = -1;
unitScript[UNIT_STATE.CHASE] = -1;
unitScript[UNIT_STATE.ATTACK] = -1;
unitScript[UNIT_STATE.HURT] = -1;
unitScript[UNIT_STATE.DIE] = -1;
unitScript[UNIT_STATE.WAIT] = UnitWait;
