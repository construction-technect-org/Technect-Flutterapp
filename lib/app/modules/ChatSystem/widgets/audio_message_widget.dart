import 'package:construction_technect/app/core/utils/audio_manager.dart';
import 'package:construction_technect/app/core/utils/imports.dart';
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
  bool _isLoading = true; // Track if audio is loading
  bool _isLoaded = false; // Track if audio is fully loaded
  double _loadingProgress = 0.0; // Loading progress percentage
  String? _currentUrl; // Track current URL to ensure correct audio

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      if (widget.audioUrl.isEmpty) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _isLoaded = false;
          });
        }
        return;
      }

      final url = widget.audioUrl.startsWith('http')
          ? widget.audioUrl
          : 'http://43.205.117.97${widget.audioUrl}';

      _currentUrl = url;

      // Don't load automatically - show download button (WhatsApp style)
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoaded = false;
          _loadingProgress = 0.0;
        });
      }

      // Set up listeners but don't load the audio yet
      // Listen to buffering state for loading progress (when download starts)
      _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
        if (mounted && _totalDuration.inMilliseconds > 0) {
          final progress =
              bufferedPosition.inMilliseconds / _totalDuration.inMilliseconds;
          setState(() {
            _loadingProgress = progress.clamp(0.0, 1.0);
            // Consider loaded when buffered position is close to total duration
            if (progress >= 0.95 ||
                bufferedPosition.inMilliseconds >=
                    _totalDuration.inMilliseconds - 500) {
              _isLoading = false;
              _isLoaded = true;
            }
          });
        }
      });

      _audioPlayer.positionStream.listen((position) {
        if (mounted) {
          // Check if audio has reached the end (backup check)
          if (_totalDuration.inMilliseconds > 0 &&
              position.inMilliseconds >= _totalDuration.inMilliseconds - 100 &&
              !_hasCompleted &&
              _isPlaying) {
            // Audio reached the end, handle completion
            _hasCompleted = true;
            _handleAudioCompletion();
          } else {
            setState(() {
              _position = position;
            });
          }
        }
      });

      _audioPlayer.playerStateStream.listen((state) {
        if (mounted) {
          // Check if audio has completed first
          if (state.processingState == ProcessingState.completed &&
              !state.playing &&
              !_hasCompleted) {
            // Audio completed, reset to 0:00 and update icon
            _hasCompleted = true;
            _handleAudioCompletion();
            return; // Don't update playing state, let completion handler do it
          } else if (state.playing) {
            // Reset flag when playing starts again
            _hasCompleted = false;
          }

          // Check if audio was stopped externally (e.g., when recording starts)
          // This happens when playing becomes false but not due to completion
          if (state.playing == false &&
              _isPlaying == true &&
              state.processingState != ProcessingState.completed) {
            // Audio was stopped externally, reset to 0:00 and show play button
            _hasCompleted = false;
            setState(() {
              _isPlaying = false;
              _position = Duration.zero;
            });
            // Ensure position is reset in the player
            _audioPlayer.seek(Duration.zero).catchError((_) {
              // Ignore errors
            });
            return;
          }

          setState(() {
            // Only update playing state if not completed
            if (!_hasCompleted) {
              _isPlaying = state.playing;
            }

            // Update loading state based on processing state
            if (state.processingState == ProcessingState.loading) {
              _isLoading = true;
              _isLoaded = false;
            } else if (state.processingState == ProcessingState.ready) {
              _isLoading = false;
              _isLoaded = true;
            }
          });
        }
      });
    } catch (e) {
      debugPrint('Error initializing audio: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoaded = false;
        });
      }
    }
  }

  /// Download/load audio when download button is clicked (WhatsApp style)
  Future<void> _downloadAudio() async {
    try {
      if (_currentUrl == null || _currentUrl!.isEmpty) return;

      // Show loading state
      setState(() {
        _isLoading = true;
        _isLoaded = false;
        _loadingProgress = 0.0;
      });

      // Stop any previous audio
      try {
        await _audioPlayer.stop();
      } catch (e) {
        // Ignore errors
      }

      // Load the audio
      await _audioPlayer.setUrl(_currentUrl!);

      // Wait for duration to be available
      _totalDuration = _audioPlayer.duration ?? Duration.zero;

      // Wait for audio to be ready
      while (_audioPlayer.processingState != ProcessingState.ready) {
        await Future.delayed(const Duration(milliseconds: 100));
        if (!mounted) return;
      }

      // Set loaded state
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoaded = true;
        });
      }
    } catch (e) {
      debugPrint('Error downloading audio: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isLoaded = false;
        });
      }
    }
  }

  Future<void> _handleAudioCompletion() async {
    try {
      // Stop playback completely (not just pause)
      await _audioPlayer.stop();
      await _audioPlayer.seek(Duration.zero);

      // Ensure position is reset and playing state is false
      if (mounted) {
        setState(() {
          _position = Duration.zero;
          _isPlaying = false;
        });
      }

      // Release from AudioManager to prevent auto-restart
      AudioManager().releasePlayer(_audioPlayer);

      // Small delay to ensure state is updated
      await Future.delayed(const Duration(milliseconds: 50));

      // Double-check state is correct
      if (mounted) {
        setState(() {
          _isPlaying = false;
          _position = Duration.zero;
        });
      }
    } catch (e) {
      debugPrint('Error handling audio completion: $e');
      // Force reset even if there's an error
      if (mounted) {
        setState(() {
          _position = Duration.zero;
          _isPlaying = false;
        });
      }
      AudioManager().releasePlayer(_audioPlayer);
    }
  }

  Future<void> _loadAndPlay() async {
    try {
      // If not loaded, download first (this will show loader)
      if (!_isLoaded) {
        await _downloadAudio();
        // After download, play the audio
        if (_isLoaded) {
          _hasCompleted = false;
          await AudioManager().playAudio(_audioPlayer, _currentUrl!);
        }
      } else {
        // Already loaded, just play directly (no loader)
        _hasCompleted = false;
        await AudioManager().playAudio(_audioPlayer, _currentUrl!);
      }
    } catch (e) {
      debugPrint('Error loading/playing audio: $e');
      // If error playing, might need to reload
      if (_isLoaded) {
        setState(() {
          _isLoaded = false;
        });
        await _downloadAudio();
        if (_isLoaded) {
          _hasCompleted = false;
          await AudioManager().playAudio(_audioPlayer, _currentUrl!);
        }
      }
    }
  }

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        AudioManager().releasePlayer(_audioPlayer);
      } else {
        // If audio is already loaded, play directly without showing loader
        if (_isLoaded && _currentUrl != null) {
          _hasCompleted = false;
          await AudioManager().playAudio(_audioPlayer, _currentUrl!);
        } else {
          // Not loaded yet, download first (will show loader)
          await _loadAndPlay();
        }
      }
    } catch (e) {
      debugPrint('Error toggling playback: $e');
      // If error, try to reload
      if (_isLoaded) {
        setState(() {
          _isLoaded = false;
        });
        await _loadAndPlay();
      }
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
            onTap: _isLoading
                ? null
                : (_isLoaded
                      ? _togglePlayPause
                      : _downloadAudio), // Download first, then play
            child: _isLoading
                ? SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: _loadingProgress > 0 ? _loadingProgress : null,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        widget.isMine ? Colors.white : MyColors.primary,
                      ),
                    ),
                  )
                : _isLoaded
                ? Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: widget.isMine ? Colors.white : MyColors.primary,
                    size: 28,
                  )
                : Icon(
                    Icons.download,
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
                      _isLoading
                          ? '${(_loadingProgress * 100).toInt()}%'
                          : _formatDuration(_position),
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
