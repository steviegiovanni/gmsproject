/// @description cause a room transition
if((instance_exists(oPlayer)) && (position_meeting(oPlayer.x, oPlayer.y, id)))
{
	if(!instance_exists(oTransition))
	{
		global.targetRoom = targetRoom;
		global.targetRoomStartX = targetRoomStartX;
		global.targetRoomStartY = targetRoomStartY;
		global.targetRoomStartDirection = oPlayer.direction;
		with(oPlayer) state = PlayerStateTransition;
		RoomTransition(TRANS_TYPE.SLIDE, targetRoom);
		instance_destroy();
	}
}