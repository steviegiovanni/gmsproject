// layer management
//layer_set_visible("Col", false);

for(var i = 0; i < ds_list_size(global.activeParty); i++) {
	instance_create_layer(global.targetRoomStartX, global.targetRoomStartY, "Instances", global.units[| global.partyMembers[| global.activeParty[| i]].uid].unit);	
}
