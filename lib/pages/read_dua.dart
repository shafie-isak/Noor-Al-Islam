import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class ReadDua extends StatefulWidget {
  final List<Map<String, dynamic>> subDuas;

  const ReadDua({Key? key, required this.subDuas}) : super(key: key);

  @override
  State<ReadDua> createState() => _ReadDuaState();
}

class _ReadDuaState extends State<ReadDua> {
  final Map<int, AudioPlayer> _audioPlayers = {};
  int? _currentlyPlayingIndex;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.subDuas.length; i++) {
      _audioPlayers[i] = AudioPlayer();
    }
  }

  @override
  void dispose() {
    for (var player in _audioPlayers.values) {
      player.dispose();
    }
    super.dispose();
  }

  Future<void> _handlePlayPause(String audioPath, int index) async {
    if (_currentlyPlayingIndex == index && _audioPlayers[index]!.playing) {
      await _audioPlayers[index]!.pause();
    } else {
      try {
        if (_currentlyPlayingIndex != null && _currentlyPlayingIndex != index) {
          // Stop the currently playing audio
          await _audioPlayers[_currentlyPlayingIndex!]!.stop();
        }
        await _audioPlayers[index]!.setAsset(audioPath);
        await _audioPlayers[index]!.play();
        setState(() {
          _currentlyPlayingIndex = index;
        });
      } catch (e) {
        print("Error playing audio: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error playing audio')),
        );
      }
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Morning Adhkar"),
      ),
      body: ListView.builder(
        itemCount: widget.subDuas.length,
        itemBuilder: (context, index) {
          final subDua = widget.subDuas[index];
          final audioPlayer = _audioPlayers[index]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  subDua['title'] ?? 'Untitled',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        subDua['arabicDua'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    ExpansionPanelList(
                      expansionCallback: (int panelIndex, bool isExpanded) {
                        setState(() {
                          subDua['isExpanded'] = !(subDua['isExpanded'] ?? false);
                        });
                      },
                      children: [
                        ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return const ListTile(
                              title: Text(
                                "Translation",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                          body: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              subDua['translation'] ?? 'No translation available.',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          isExpanded: subDua['isExpanded'] ?? false,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: StreamBuilder<Duration>(
                        stream: audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          final duration = audioPlayer.duration ?? Duration.zero;

                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  if (subDua['audio'] != null) {
                                    _handlePlayPause(subDua['audio']!, index);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Audio URL is missing')),
                                    );
                                  }
                                },
                                icon: Icon(
                                  _currentlyPlayingIndex == index && audioPlayer.playing
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill,
                                  size: 36,
                                  color: Colors.blue,
                                ),
                              ),
                              Text(_formatDuration(position)),
                              Expanded(
                                child: Slider(
                                  value: position.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                                  max: duration.inSeconds.toDouble(),
                                  onChanged: (value) async {
                                    if (duration > Duration.zero) {
                                      final newPosition = Duration(seconds: value.toInt());
                                      await audioPlayer.seek(newPosition);
                                    }
                                  },
                                ),
                              ),
                              Text(_formatDuration(duration)),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
