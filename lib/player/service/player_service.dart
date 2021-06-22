import 'dart:async';
import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_flutter/common/models/entities.dart';

void lightMusicPlayer() async {
  AudioServiceBackground.run(() => LightMusicPlayerService());
}

class LightMusicPlayerService extends BackgroundAudioTask {
  List<BaseMusic> _queue;

  List<BaseMusic> get queue => _queue;

  AudioPlayer _player;
  AudioProcessingState _skipState;
  int timesPositionChanged = 0;
  int _index = 0;
  int lastPlayerPosition = 0;

  // Enable Repeat & Random
  bool enableRepeat = false;
  bool enableRandom = false;

  AudioSession session;

  StreamSubscription<PlaybackEvent> _eventSubscription;

  bool get hasNext => _index + 1 < _queue.length;

  bool get hasPrevious => _index > 0;

  MediaItem get mediaItem => MediaItem(
        id: _queue[_index].id as String,
        album: _queue[_index].name,
        title: _queue[_index].name,
        artist: _queue[_index].song?.album?.name ?? "",
        duration: Duration(milliseconds: _queue[_index].duration?? _queue[_index].song.duration),
        artUri: Uri.dataFromString(_queue[_index].musicUrl),
      );

  @override
  Future<void> onSkipToPrevious() async {
    if (_player.position < Duration(seconds: 3)) {
      _skip(-1);
    } else {
      _player.seek(Duration(seconds: 0));
    }
  }

  @override
  Future<void> onSkipToNext() async {
    if (enableRandom) {
      _index = Random().nextInt(_queue.length);
      BaseMusic music = _queue[_index];
      await AudioServiceBackground.setMediaItem(MediaItem(
        id: music.id as String,
        album: music.name,
        title: music.name,
        artist: music.song?.album?.name ?? "",
        duration: Duration(milliseconds: music.duration?? music.song.duration),
        artUri: Uri.dataFromString(music.musicUrl),
      ));
      await _player.setUrl(music.musicUrl);
      onPlay();
      return;
    }
    _skipState = AudioProcessingState.skippingToNext;
    _skip(1);
  }

  @override
  Future<void> onPlay() async {
    await session.setActive(true);
    await _player.play();
  }

  @override
  Future<Function> onStart(Map<String, dynamic> params) async {
    _queue = <BaseMusic>[];
    session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.music());
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(0.4);
            break;
          case AudioInterruptionType.pause:
            onPause();
            break;
          case AudioInterruptionType.unknown:
            onPause();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(1);
            break;
          case AudioInterruptionType.pause:
            onPlay();
            break;
          case AudioInterruptionType.unknown:
            // The interruption ended but we should not resume.
            break;
        }
      }
    });

    session.becomingNoisyEventStream.listen((_) {
      _player.pause();
    });

    _player = new AudioPlayer();
    _eventSubscription = _player.playbackEventStream.listen((event) {
      // _broadcastState();
    });

    _player.processingStateStream.listen((state) {
      switch (state) {
        case ProcessingState.completed:
          // _handlePlaybackCompleted();
          break;
        case ProcessingState.ready:
        // If we just came from skipping between tracks, clear the skip
        // state now that we're ready to play.
          _skipState = null;
          break;
        default:
          break;
      }
    });
  }

  Future<void> _skip(int offset) async {}
}
