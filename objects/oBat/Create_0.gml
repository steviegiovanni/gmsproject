// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

unitSpeed = 1.5;

// enemy sprites
sprites[UNIT_SPRITE.MOVE] = sBat;
sprites[UNIT_SPRITE.ATTACK] = sBat;
sprites[UNIT_SPRITE.HURT] = sBat;
sprites[UNIT_SPRITE.DIE] = sBat;

// enemy scripts
unitScript[UNIT_STATE.IDLE] = BatIdle;
unitScript[UNIT_STATE.WANDER] = BatFollow;
unitScript[UNIT_STATE.CHASE] = SlimeChase;
unitScript[UNIT_STATE.ATTACK] = SlimeAttack;
unitScript[UNIT_STATE.HURT] = SlimeHurt;
unitScript[UNIT_STATE.DIE] = SlimeDie;
unitScript[UNIT_STATE.RESET] = SlimeReset;

