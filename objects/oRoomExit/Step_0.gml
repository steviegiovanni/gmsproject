/// @description cause a room transition
if((instance_exists(global.controlledUnit)) && (position_meeting(global.controlledUnit.x, global.controlledUnit.y, id)))
{
	if(!instance_exists(oTransition))
	{
		global.targetRoom = targetRoom;
		global.targetRoomStartX = targetRoomStartX;
		global.targetRoomStartY = targetRoomStartY;
		global.targetRoomStartDirection = global.controlledUnit.direction;
		with(pUnit) state = UNIT_STATE.LOCKED;
		with(all) image_speed = 0;
		RoomTransition(TRANS_TYPE.SLIDE, targetRoom);
		instance_destroy();
	}
}