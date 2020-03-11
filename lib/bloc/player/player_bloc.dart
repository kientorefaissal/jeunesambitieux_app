import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcastapp/bloc/player/player_event.dart';
import 'package:podcastapp/bloc/player/player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  PlayerState get initialState => Loading();

  @override
  Stream<PlayerState> mapEventToState(PlayerEvent event) async* {
    if (event is StartPlayer) {
      int result = await audioPlayer.play(event.contentUrl);
      if (result == 1) {
        yield Play();
      } else {
        yield Loading();
      }
    } else if (event is PausePlayer) {
      int result = await audioPlayer.pause();
      if (result == 1) {
        yield Pause();
      }
    } else if (event is ResumePlayer) {
      int result = await audioPlayer.resume();
      if (result == 1) {
        yield Resume();
      }
    }
  }
}