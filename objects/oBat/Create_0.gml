// Inherit the parent event
event_inherited();

playerControlled = true;

state = UNIT_STATE.IDLE;

unitSpeed = 1.5;
attackSpeed = 60;

// enemy sprites
sprites[UNIT_SPRITE.IDLE] = sBat;
sprites[UNIT_SPRITE.ALERT] = sBat;
sprites[UNIT_SPRITE.MOVE] = sBat;
sprites[UNIT_SPRITE.ATTACK] = sBat;
sprites[UNIT_SPRITE.HURT] = sBatHurt;
sprites[UNIT_SPRITE.DIE] = sBat;

// enemy scripts
unitScript[UNIT_STATE.IDLE] = PlayerStateFree;
unitScript[UNIT_STATE.CHASE] = AllyChase;
unitScript[UNIT_STATE.RESET] = AllyReset;

// actions
ds_list_add(actionTable, new Action("attack", 180, ActionCheckAttack, ActionCommitAttack));
