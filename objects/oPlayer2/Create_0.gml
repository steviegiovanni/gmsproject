/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

state = UNIT_STATE.IDLE;

unitSpeed = 2.0;

sprites[UNIT_SPRITE.IDLE] = Sprite1;
sprites[UNIT_SPRITE.MOVE] = Sprite1_Walk;
sprites[UNIT_SPRITE.ATTACK] = Sprite1_AttackSlash;
sprites[UNIT_SPRITE.HURT] = -1;
sprites[UNIT_SPRITE.DIE] = -1;

//unitScript[UNIT_STATE.IDLE] = PlayerStateFree;

if(global.targetRoomStartX != -1)
{
	x = global.targetRoomStartX;
	y = global.targetRoomStartY;
	direction = global.targetRoomStartDirection;
}