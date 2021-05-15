// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

// enemy sprites
sprites[UNIT_SPRITE.MOVE] = sSlime;
sprites[UNIT_SPRITE.ATTACK] = sSlimeAttack;
sprites[UNIT_SPRITE.HURT] = sSlimeHurt;
sprites[UNIT_SPRITE.DIE] = sSlimeDie;

// enemy scripts
unitScript[UNIT_STATE.IDLE] = SlimeIdle;
unitScript[UNIT_STATE.WANDER] = SlimeWander;
unitScript[UNIT_STATE.CHASE] = SlimeChase;
unitScript[UNIT_STATE.ATTACK] = SlimeAttack;
unitScript[UNIT_STATE.HURT] = SlimeHurt;
unitScript[UNIT_STATE.DIE] = SlimeDie;
unitScript[UNIT_STATE.RESET] = SlimeReset;
