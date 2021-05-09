// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function AttackSlash()
{
	// attack just started
	if(sprite_index != Sprite1_AttackSlash)
	{
		// set up correct animation
		sprite_index = Sprite1_AttackSlash;
		localFrame = 0;
		image_index = 0;
		
		// clear hit list
		if(!ds_exists(hitByAttack, ds_type_list))
		{
			hitByAttack = ds_list_create();
		}
		ds_list_clear(hitByAttack);
	}
	
	CalcAttack(sPlayerAttackSlashHB);
	
	// update sprite
	PlayerAnimateSprite();
	
	if(animationEnd)
	{
		state =	PlayerStateFree;
		animationEnd = false;
	}

}