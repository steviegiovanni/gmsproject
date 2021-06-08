#macro FRAME_RATE 60
#macro TILE_SIZE 16
#macro CARDINAL_DIR round(direction / 90)
#macro LEFTRIGHT_DIR round(direction / 180)
#macro ROOM_START rVillage

#macro RESOLUTION_W 320
#macro RESOLUTION_H 180

#macro TRANSITION_SPEED 0.02
#macro OUT 0
#macro IN 1

enum UNIT_STATE
{
	IDLE,
	WANDER,
	CHASE,
	ATTACK,
	HURT,
	DIE,
	RESET,
	LOCKED
}

function UnitStateToString(_unitState)
{
	switch(_unitState)
	{
		case UNIT_STATE.IDLE:
		return "Idle";
		case UNIT_STATE.WANDER:
		return "Wander";
		case UNIT_STATE.CHASE:
		return "Chase";
		case UNIT_STATE.ATTACK:
		return "Attack";
		case UNIT_STATE.HURT:
		return "Hurt";
		case UNIT_STATE.DIE:
		return "Die";
		case UNIT_STATE.RESET:
		return "Reset";
		case UNIT_STATE.LOCKED:
		return "Locked";
		default:
		return "ERROR";
	}
}

enum UNIT_SPRITE
{
	IDLE,
	ALERT,
	MOVE,
	ATTACK,
	HURT,
	DIE
}