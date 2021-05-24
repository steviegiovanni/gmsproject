// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

unitSpeed = 1.5;
attackSpeed = 60;

// enemy sprites
sprites[UNIT_SPRITE.MOVE] = sBat;
sprites[UNIT_SPRITE.ATTACK] = sBat;
sprites[UNIT_SPRITE.HURT] = sBat;
sprites[UNIT_SPRITE.DIE] = sBat;

// enemy scripts
unitScript[UNIT_STATE.IDLE] = BatIdle;
unitScript[UNIT_STATE.WANDER] = SlimeWander;
unitScript[UNIT_STATE.CHASE] = BatChase;
unitScript[UNIT_STATE.ATTACK] = BatAttack;
unitScript[UNIT_STATE.HURT] = SlimeHurt;
unitScript[UNIT_STATE.DIE] = SlimeDie;
unitScript[UNIT_STATE.RESET] = BatReset;

