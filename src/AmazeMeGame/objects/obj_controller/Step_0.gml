musicPlayer.Update();

if keyboard_check(vk_enter)
{
	if (musicPlayer.CurrentGroup = musicGroup)
	{
		musicPlayer.Play(musicGroup2);
	}
	else
	{
		musicPlayer.Play(musicGroup);
	}
	
}