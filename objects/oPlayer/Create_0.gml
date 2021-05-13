state = PlayerStateFree;
stateAttack = AttackSlash;
hitByAttack = -1;
lastState = state;

hSpeed = 0;
vSpeed = 0;
unitSpeed = 2.0;
speedRoll = 3.0;
distanceRoll = 52;
distanceBonk = 40;
distanceBonkHeight = 12;
speedBonk = 1.5;
z = 0;

spriteRoll = Sprite1_Roll;
localFrame = 0;

sprites[UNIT_SPRITE.IDLE] = Sprite1;
sprites[UNIT_SPRITE.MOVE] = Sprite1_Walk;
sprites[UNIT_SPRITE.ATTACK] = Sprite1_AttackSlash;
sprites[UNIT_SPRITE.HURT] = -1;
sprites[UNIT_SPRITE.DIE] = -1;

if(global.targetRoomStartX != -1)
{
	x = global.targetRoomStartX;
	y = global.targetRoomStartY;
	direction = global.targetRoomStartDirection;
}
