/// @description set up camera
cam = view_camera[0];
xTo = xstart;
yTo = ystart;

shakeLength = 0;
shakeMagnitude = 0;
shakeRemain = 0;

displayWidth = window_get_width();
displayHeight = window_get_height();

ReadjustCamera();