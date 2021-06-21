// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

// enemy sprites
sprites[UNIT_SPRITE.MOVE] = sSlime;
sprites[UNIT_SPRITE.ATTACK] = sSlimeAttack;
sprites[UNIT_SPRITE.HURT] = sSlimeHurt;
sprites[UNIT_SPRITE.DIE] = sSlimeDie;

// enemy scripts
unitScript[UNIT_STATE.IDLE] = EnemyIdle;
unitScript[UNIT_STATE.WANDER] = EnemyWander;
unitScript[UNIT_STATE.CHASE] = EnemyChase;
unitScript[UNIT_STATE.DIE] = EnemyDie;
unitScript[UNIT_STATE.RESET] = EnemyReset;

// actions
ds_list_add(actionTable, new Action("attack", 240, ActionCheckAttack, ActionCommitAttack));
