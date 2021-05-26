event_inherited();

state = UNIT_STATE.IDLE;
hitByAttack = -1;

unitSpeed = 2.0;
speedRoll = 3.0;
distanceRoll = 52;
distanceBonk = 40;
distanceBonkHeight = 12;
speedBonk = 1.5;

spriteRoll = Sprite1_Roll;

attackRadius = 16;

sprites[UNIT_SPRITE.IDLE] = Sprite1;
sprites[UNIT_SPRITE.MOVE] = Sprite1_Walk;
sprites[UNIT_SPRITE.ATTACK] = Sprite1_AttackSlash;
sprites[UNIT_SPRITE.HURT] = Sprite1_Hurt;
sprites[UNIT_SPRITE.DIE] = -1;

unitScript[UNIT_STATE.IDLE] = PlayerStateFree;
unitScript[UNIT_STATE.WANDER] = -1;
unitScript[UNIT_STATE.CHASE] = -1;
unitScript[UNIT_STATE.ATTACK] = PlayerStateAttack;
unitScript[UNIT_STATE.HURT] = PlayerHurt;
unitScript[UNIT_STATE.DIE] = -1;

if(global.targetRoomStartX != -1)
{
	x = global.targetRoomStartX;
	y = global.targetRoomStartY;
	direction = global.targetRoomStartDirection;
}
