// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(_message, _background)
{
	var _obj;
	if(instance_exists(oText))
	{
		_obj = oTextQueued;
	}
	else
	{
		_obj = oText;
	}
	with(instance_create_layer(0, 0, "Instances", _obj))
	{
		textMessage = _message;
		if(instance_exists(other))
		{
			originInstance = other.id;
		}
		else
		{
			originInstance = noone;
		}
		
		if(!is_undefined(_background))
		{
			background = _background;
		}
		else
		{
			background = 1;
		}
	}
	
	with(oPlayer)
	{
		if(state != PlayerStateLocked)
		{
			lastState = state;
			state = PlayerStateLocked;
		}
	}
}