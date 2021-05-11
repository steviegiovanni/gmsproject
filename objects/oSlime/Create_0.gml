// Inherit the parent event
event_inherited();

state = ENEMYSTATE.WANDER;

// enemy sprites
sprMove = sSlime;
sprAttack = sSlimeAttack;
sprDie = sSlimeDie;
sprHurt = sSlimeHurt;

// enemy scripts
enemyScript[ENEMYSTATE.WANDER] = SlimeWander;
enemyScript[ENEMYSTATE.CHASE] = SlimeChase;
enemyScript[ENEMYSTATE.ATTACK] = SlimeAttack;
enemyScript[ENEMYSTATE.HURT] = SlimeHurt;
enemyScript[ENEMYSTATE.DIE] = SlimeDie;
