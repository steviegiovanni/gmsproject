/// @description cause a room transition
if((instance_exists(oPlayer)) && (position_meeting(oPlayer.x, oPlayer.y, id)))
{
	if(!instance_exists(oTransition))
	{
		global.targetRoom = targetRoom;
		global.targetRoomStartX = targetRoomStartX;
		global.targetRoomStartY = targetRoomStartY;
		global.targetRoomStartDirection = oPlayer.direction;
		with(pUnit) state = UNIT_STATE.LOCKED;
		with(all) image_speed = 0;
		RoomTransition(TRANS_TYPE.SLIDE, targetRoom);
		instance_destroy();
	}
}