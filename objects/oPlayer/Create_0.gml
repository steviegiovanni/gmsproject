event_inherited();

//playerControlled = true;

state = UNIT_STATE.IDLE;
hitByAttack = -1;

unitSpeed = 2.0;
speedRoll = 3.0;
distanceRoll = 52;
distanceBonk = 40;
distanceBonkHeight = 12;
speedBonk = 1.5;

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
unitScript[UNIT_STATE.ATTACK] = PlayerStateAttack;
unitScript[UNIT_STATE.DIE] = -1;
unitScript[UNIT_STATE.RESET] = AllyReset;

spriteAnimationFunctions[UNIT_SPRITE.IDLE] = AnimateSprite4Dir;
spriteAnimationFunctions[UNIT_SPRITE.ALERT] = AnimateSprite2Dir;
spriteAnimationFunctions[UNIT_SPRITE.MOVE] = AnimateSprite4Dir;

if(global.targetRoomStartX != -1)
{
	x = global.targetRoomStartX;
	y = global.targetRoomStartY;
	direction = global.targetRoomStartDirection;
}
