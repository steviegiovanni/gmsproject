// Inherit the parent event
event_inherited();

state = UNIT_STATE.WANDER;

// enemy sprites
sprMove = sSlime;
sprAttack = sSlimeAttack;
sprDie = sSlimeDie;
sprHurt = sSlimeHurt;

// enemy scripts
unitScript[UNIT_STATE.WANDER] = SlimeWander;
unitScript[UNIT_STATE.CHASE] = SlimeChase;
unitScript[UNIT_STATE.ATTACK] = SlimeAttack;
unitScript[UNIT_STATE.HURT] = SlimeHurt;
unitScript[UNIT_STATE.DIE] = SlimeDie;
