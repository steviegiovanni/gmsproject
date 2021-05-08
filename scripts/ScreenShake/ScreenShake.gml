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