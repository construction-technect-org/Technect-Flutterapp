import 'package:just_audio/just_audio.dart';

/// Global audio manager to ensure only one audio plays at a time
class AudioManager {
  static final AudioManager _instance = AudioManager._internal();
  factory AudioManager() => _instance;
  AudioManager._internal();

  AudioPlayer? _currentPlayer;
  String? _currentAudioUrl;

  /// Play audio, stopping any currently playing audio
  Future<void> playAudio(AudioPlayer player, String audioUrl) async {
    // Stop current player if different audio
    if (_currentPlayer != null && _currentPlayer != player) {
      try {
        // Reset position to 0:00 before stopping
        await _currentPlayer!.seek(Duration.zero);
        await _currentPlayer!.stop();
        // Don't dispose, just stop and reset - widget will handle disposal
      } catch (e) {
        // Ignore errors
      }
    }

    _currentPlayer = player;
    _currentAudioUrl = audioUrl;

    try {
      await player.play();
    } catch (e) {
      _currentPlayer = null;
      _currentAudioUrl = null;
      rethrow;
    }
  }

  /// Stop all audio playback
  Future<void> stopAll() async {
    if (_currentPlayer != null) {
      try {
        // Reset position to 0:00 before stopping
        await _currentPlayer!.seek(Duration.zero);
        await _currentPlayer!.stop();
        // Don't dispose, just stop and reset - widget will handle disposal
      } catch (e) {
        // Ignore errors
      }
      _currentPlayer = null;
      _currentAudioUrl = null;
    }
  }

  /// Check if audio is currently playing
  bool isPlaying(String? audioUrl) {
    return _currentPlayer != null && _currentAudioUrl == audioUrl;
  }

  /// Release current player (when widget is disposed)
  void releasePlayer(AudioPlayer player) {
    if (_currentPlayer == player) {
      _currentPlayer = null;
      _currentAudioUrl = null;
    }
  }
}
