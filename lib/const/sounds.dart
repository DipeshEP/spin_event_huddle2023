    import 'package:just_audio/just_audio.dart';

 AudioPlayer audioPlayer = AudioPlayer();

  const spinPlaySound = 'assets/audio/spinwheel.mp3';
  const congratulationSound = 'assets/audio/winnier.mp3';
  const betterLuckSound = 'assets/audio/betterLuckNext.mp3';


  
  spinplayAudio() async {
    await audioPlayer.stop();
    await audioPlayer.setAsset(spinPlaySound);
    await audioPlayer.play();
  }


 congratulationAudio() async {
    await audioPlayer.stop();
    await audioPlayer.setAsset(congratulationSound);
    await audioPlayer.play();
  }

  betterLuckAudio() async {
    await audioPlayer.stop();
    await audioPlayer.setAsset(betterLuckSound);
    await audioPlayer.play();
  
  }
