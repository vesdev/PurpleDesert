camera = new Camera(640,480, display_get_width(), display_get_height())

musicPlayer = new MusicPlayer();
musicGroup = new MusicGroup(testloop_kick, testloop_hat)
musicGroup2 = new MusicGroup(testloop_hat2)

musicPlayer.Play(musicGroup);

