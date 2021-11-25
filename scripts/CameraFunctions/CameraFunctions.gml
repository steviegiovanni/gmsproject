// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ScreenShake(_magnitude, _length)
{
	with(global.iCamera)
	{
		if(_magnitude > shakeRemain)
		{
			shakeMagnitude = _magnitude;
			shakeRemain = shakeMagnitude;
			shakeLength = _length;
		}
	}
}

function ReadjustCamera() {
	var aspect = displayWidth / displayHeight;
	if(displayWidth < displayHeight) {
		// portrait
		var cameraWidth = MIN_CAMERA_W;
		var cameraHeight = cameraWidth / aspect;
		var viewportWidth = min(MIN_CAMERA_W, displayWidth);
		var viewportHeight = viewportWidth / aspect;
	}
	else {
		// landscape
		var cameraHeight = MIN_CAMERA_H;
		var cameraWidth = cameraHeight * aspect;
		var viewportHeight = min(MIN_CAMERA_H, displayHeight);
		var viewportWidth = viewportHeight * aspect;
	}
	camera_set_view_size(view_camera[0], floor(cameraWidth), floor(cameraHeight));
	view_wport[0] = viewportWidth;
	view_hport[0] = viewportHeight;
	surface_resize(application_surface, viewportWidth, viewportHeight);
}