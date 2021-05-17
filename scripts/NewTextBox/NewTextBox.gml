// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function NewTextBox(_message, _background, _responses)
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
		
		if(!is_undefined(_responses))
		{
			// trim markers from responses
			responses = _responses;
			for(var i = 0; i < array_length_1d(responses); i++)
			{
				var _markerPosition = string_pos(":", responses[i]);
				responseScripts[i] = real(string_copy(responses[i], 1, _markerPosition - 1));
				responses[i] = string_delete(responses[i], 1, _markerPosition);
			}
		}
		else
		{
			responses = [-1];
			responseScripts = [-1];
		}
	}
	
	with(pUnit)
	{
		if(state != UNIT_STATE.LOCKED)
		{
			lastState = state;
			gamePausedImageSpeed = image_speed;
			image_speed = 0;
			state = UNIT_STATE.LOCKED;
		}
	}
}