enum _MSC_GROUP
{
	GAIN,
	TARGET_GAIN,
	TIME
}

function __approach(from, to, amount)
{
	if (from < to)
	{
		from += amount;
		if (from > to)
			return to;
	}
	else
	{
		from -= amount;
		if (from < to)
			return to;
	}
	return from;
}

function MusicGroup(soundIDs) constructor
{
	
	Group = audio_create_sync_group(true);
	SoundIdArray = [];
	
	GainArray = [];
	
	Gain = 1;
	GainTarget = 1;
	GainTime = 0;
	
	var _i = 0;
	var _childData;
	repeat(argument_count)
	{
		audio_play_in_sync_group(Group, argument[_i]);
		SoundIdArray[_i] = argument[_i];
		
		_childData = [];
		
		_childData[_MSC_GROUP.TIME] = 0;
		_childData[_MSC_GROUP.TARGET_GAIN] = 1;
		_childData[_MSC_GROUP.GAIN] = 1;
		
		GainArray[_i] = _childData;
		_i++;
	}
	
	
	static Play = function()
	{
		audio_start_sync_group(Group);
	}
	
	static Stop = function()
	{
		audio_stop_sync_group(Group);
	}
	
	static SetTrackGain = function(index, level, time)
	{
		if (time = 0) time = 1;
		var _childData = GainArray[index];
		
		_childData[_MSC_GROUP.TARGET_GAIN] = level;
		_childData[_MSC_GROUP.TIME] = (_childData[_MSC_GROUP.TARGET_GAIN]-_childData[_MSC_GROUP.GAIN])/time;
		
		GainArray[index] = _childData;
		
		Update();
	}
	
	static SetGain = function(level, time)
	{
		if (time = 0) time = 1;
	
		GainTarget = level;
		GainTime = (GainTarget-Gain)/time;
		
		Update();
	}
	
	static GetGain = function()
	{
		return Gain;
	}
	
	static Update = function()
	{
		
		Gain += GainTime;
		
		if (Gain == GainTarget) GainTime = 0;
		
		var _i = 0;
		var _childData;
		repeat(array_length(GainArray))
		{
			_childData = GainArray[_i];
			
			_childData[_MSC_GROUP.GAIN] += _childData[_MSC_GROUP.TIME];
			
			if (_childData[_MSC_GROUP.GAIN] = _childData[_MSC_GROUP.TARGET_GAIN]) _childData[_MSC_GROUP.TIME] = 0;
			
			show_debug_message(_childData[_MSC_GROUP.GAIN]);
			
			GainArray[_i] = _childData;
			
			audio_sound_gain(SoundIdArray[_i], _childData[_MSC_GROUP.GAIN]*Gain, 0);
			
			_i++;
		}
	}

}

function MusicPlayer() constructor
{
	CurrentGroup = undefined;
	NextGroup = undefined; // one to fade to
	
	static Play = function(musicGroup)
	{
		if (CurrentGroup == undefined)
		{	
			musicGroup.SetGain(0,0);
			musicGroup.Play();
			musicGroup.SetGain(1, 1000);
			CurrentGroup = musicGroup;
		}
		else
		{
			NextGroup = musicGroup;
			CurrentGroup.SetGain(0,200);
		}
		
	}
	
	static Update = function()
	{
		CurrentGroup.Update();
		
		if (NextGroup != undefined && CurrentGroup.GetGain() == 0)
		{
			CurrentGroup.Stop();
			CurrentGroup = NextGroup;
			NextGroup = undefined;
			
			CurrentGroup.SetGain(1, 200);
			CurrentGroup.Play();
		}
	}
}