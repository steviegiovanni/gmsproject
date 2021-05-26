/// @description Insert description here
// You can write your code in this editor

if(global.debug)
{
	var _circleSize = 32;
	
	draw_sprite_ext
	(
	sDebugCircle,
	0,
	floor(x),
	floor(y),
	aggroLostRadius / _circleSize,
	aggroLostRadius / _circleSize,
	image_angle,
	image_blend,
	image_alpha
	);
	
	draw_sprite_ext
	(
	sDebugCircle,
	0,
	floor(x),
	floor(y),
	aggroRadius / _circleSize,
	aggroRadius / _circleSize,
	image_angle,
	c_red,
	image_alpha
	);
	
	draw_sprite_ext
	(
	sDebugCircle,
	0,
	floor(x),
	floor(y),
	attackRange / _circleSize,
	attackRange / _circleSize,
	image_angle,
	c_red,
	image_alpha
	);
}

// Inherit the parent event
event_inherited();



