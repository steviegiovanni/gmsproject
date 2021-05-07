// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function PlayerAnimateSprite()
{
	// update sprite
	var _cardinalDirection = floor(((direction div 45) + 1) * 0.5);//round(direction / 90);
	var _totalFrames = sprite_get_number(sprite_index) / 4;
	image_index = localFrame + (_cardinalDirection * _totalFrames);
	localFrame += sprite_get_speed(sprite_index) / FRAME_RATE;

	// if animation would loop on next game step
	if(localFrame >= _totalFrames)
	{
		animationEnd = true;
		localFrame -= _totalFrames;
	}
	else
	{
		animationEnd = false;
	}
}