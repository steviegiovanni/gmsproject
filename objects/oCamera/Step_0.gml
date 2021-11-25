/// @description update camera

var currentDisplayWidth = window_get_width();
var currentDisplayHeight = window_get_height();
if((currentDisplayWidth != displayWidth) || (currentDisplayHeight != displayHeight)) {
	displayWidth = currentDisplayWidth;
	displayHeight = currentDisplayHeight;
	ReadjustCamera();
}

viewWidthHalf = camera_get_view_width(cam) * 0.5;
viewHeightHalf = camera_get_view_height(cam) * 0.5;

// update destination
if(instance_exists(global.controlledUnit))
{
	xTo = global.controlledUnit.x;
	yTo = global.controlledUnit.y;
}

// update object position
x += (xTo - x) / 15;
y += (yTo - y) / 15;

// keep camera center inside room
x = clamp(x, viewWidthHalf, room_width - viewWidthHalf);
y = clamp(y, viewHeightHalf, room_height - viewHeightHalf);

// screen shake
x += random_range(-shakeRemain, shakeRemain);
y += random_range(-shakeRemain, shakeRemain);

shakeRemain = max(0, shakeRemain - ((1 / shakeLength) * shakeMagnitude));

camera_set_view_pos(cam, x - viewWidthHalf, y - viewHeightHalf);