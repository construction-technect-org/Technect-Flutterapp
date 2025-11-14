import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:construction_technect/app/core/utils/audio_manager.dart';
import 'package:just_audio/just_audio.dart';

class AudioMessageWidget extends StatefulWidget {
  final String audioUrl;
  final String duration; // Duration in MM:SS format
  final bool isMine;

  const AudioMessageWidget({
    super.key,
    required this.audioUrl,
    required this.duration,
    required this.isMine,
  });

  @override
  State<AudioMessageWidget> createState() => _AudioMessageWidgetState();
}

class _AudioMessageWidgetState extends State<AudioMessageWidget> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _hasCompleted = false; // Flag to prevent multiple resets

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      final url = widget.audioUrl.startsWith('http')
          ? widget.audioUrl
          : 'http://43.205.117.97${widget.audioUrl}';

      await _audioPlayer.setUrl(url);
      _totalDuration = _audioPlayer.duration ?? Duration.zero;

      _audioPlayer.positionStream.listen((position) {
        if (mounted) {
          setState(() {
            _position = position;
          });
        }
      });

      _audioPlayer.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
          });

          // Check if audio has completed
          if (state.processingState == ProcessingState.completed &&
              !state.playing &&
              !_hasCompleted) {
            // Audio completed, reset to 0:00 and update icon
            _hasCompleted = true;
            _audioPlayer
                .seek(Duration.zero)
                .then((_) {
                  if (mounted) {
                    setState(() {
                      _position = Duration.zero;
                      _isPlaying = false;
                    });
                  }
                  AudioManager().releasePlayer(_audioPlayer);
                })
                .catchError((e) {
                  debugPrint('Error resetting audio position: $e');
                });
          } else if (state.playing) {
            // Reset flag when playing starts again
            _hasCompleted = false;
          }
        }
      });
    } catch (e) {
      debugPrint('Error initializing audio: $e');
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        AudioManager().releasePlayer(_audioPlayer);
      } else {
        // Reset completion flag when starting to play
        _hasCompleted = false;
        final url = widget.audioUrl.startsWith('http')
            ? widget.audioUrl
            : 'http://43.205.117.97${widget.audioUrl}';
        await AudioManager().playAudio(_audioPlayer, url);
      }
    } catch (e) {
      debugPrint('Error toggling playback: $e');
    }
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    AudioManager().releasePlayer(_audioPlayer);
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final progress = _totalDuration.inMilliseconds > 0
        ? _position.inMilliseconds / _totalDuration.inMilliseconds
        : 0.0;

    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: widget.isMine
            ? Colors.white.withValues(alpha: 0.2)
            : Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _togglePlayPause,
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: widget.isMine ? Colors.white : MyColors.primary,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: widget.isMine
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.isMine ? Colors.white : MyColors.primary,
                    ),
                    minHeight: 3,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(_position),
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isMine ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    Text(
                      widget.duration,
                      style: TextStyle(
                        fontSize: 12,
                        color: widget.isMine ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
