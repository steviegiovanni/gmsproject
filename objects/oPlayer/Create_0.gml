event_inherited();

stats = new UnitStats(200);

playerControlled = true;

state = UNIT_STATE.IDLE;
hitByAttack = -1;

unitSpeed = 2.0;
speedRoll = 3.0;
distanceRoll = 52;
distanceBonk = 40;
distanceBonkHeight = 12;
speedBonk = 1.5;

maxComboCount = 3;

spriteRoll = Sprite1_Roll;

sprites[UNIT_SPRITE.IDLE] = sA1Idle;
sprites[UNIT_SPRITE.ALERT] = sA1IdleBattle;
sprites[UNIT_SPRITE.MOVE] = sA1Move;
sprites[UNIT_SPRITE.ATTACK] = sA1Attack;
sprites[UNIT_SPRITE.HURT] = sA1Hurt;
sprites[UNIT_SPRITE.DIE] = sA1Die;

unitScript[UNIT_STATE.IDLE] = PlayerStateFree;
unitScript[UNIT_STATE.WANDER] = -1;
unitScript[UNIT_STATE.CHASE] = AllyChase;
unitScript[UNIT_STATE.DIE] = -1;
unitScript[UNIT_STATE.RESET] = AllyReset;

spriteAnimationFunctions[UNIT_SPRITE.IDLE] = AnimateSprite4Dir;
spriteAnimationFunctions[UNIT_SPRITE.ALERT] = AnimateSprite2Dir;
spriteAnimationFunctions[UNIT_SPRITE.MOVE] = AnimateSprite4Dir;
spriteAnimationFunctions[UNIT_SPRITE.HURT] = AnimateSprite2Dir;

if(global.targetRoomStartX != -1)
{
	x = global.targetRoomStartX;
	y = global.targetRoomStartY;
	direction = global.targetRoomStartDirection;
}

// skills
ds_list_add(skillTable, new Skill("attack1", 60, A1Attack1));
ds_list_add(skillTable, new Skill("attack2", 60, A1Attack2));
ds_list_add(skillTable, new Skill("attack3", 60, A1Attack3));

// actions
ds_list_add(actionTable, new Action("attack1", 0, A1CheckAttack1));
ds_list_add(actionTable, new Action("attack2", 1, A1CheckAttack2));
ds_list_add(actionTable, new Action("attack3", 2, A1CheckAttack3));

// combos
combos = [0, 1, 2];
