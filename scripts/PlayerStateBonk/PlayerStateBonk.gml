// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerStateBonk(){
	// movement
	hSpeed = lengthdir_x(speedBonk, direction - 180);
	vSpeed = lengthdir_y(speedBonk, direction - 180);
	
	moveDistanceRemaining = max(0, moveDistanceRemaining - speedBonk);
	var _collided = PlayerCollision();
	
	// update sprite
	sprite_index = Sprite1_Hurt;
	
	switch(CARDINAL_DIR)
	{
		case 0: 
		{
			image_index = 2;
		}break;
		case 2:
		{
			image_index = 0;
		}break;
		case 3:
		{
			image_index = 1;
		}break;
		default:
		{
			image_index = 3;
		}break;
	}
	
	// change height
	z = sin(((moveDistanceRemaining / distanceBonk) * pi)) * distanceBonkHeight;
	
	// change state
	if(moveDistanceRemaining <= 0)
	{
		state = PlayerStateFree;
	}
}