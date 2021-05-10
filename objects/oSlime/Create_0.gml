// Inherit the parent event
event_inherited();

state = ENEMYSTATE.WANDER;

// enemy sprites
sprMove = sSlime;

// enemy scripts
enemyScript[ENEMYSTATE.WANDER] = SlimeWander;
