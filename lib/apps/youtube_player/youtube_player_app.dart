import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerPage extends StatefulWidget {
  const YoutubePlayerPage({super.key});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  late YoutubePlayerController _youtubePlayerController;
  final TextEditingController _urlFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initYoutubePlayer();
  }

  void _initYoutubePlayer() {
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId:
          YoutubePlayer.convertUrlToId("https://youtu.be/6X9HaLYiK24")!,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        forceHD: false,
        showLiveFullscreenButton: true,
      ),
    );

    _youtubePlayerController.addListener(_checkFullScreen);
  }

  // true fullscreen dependencies
  void _checkFullScreen() {
    _toggleFullScreen(_youtubePlayerController.value.isFullScreen);
  }

  bool _isFullScreen = false;
  void _toggleFullScreen(bool isFullScreen) {
    setState(() {
      _isFullScreen = isFullScreen;
    });
  }

  void playVideoByUrl(String url) {
    final videoUrl = url;
    final videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _youtubePlayerController.load(videoId);
      _youtubePlayerController.play();
    }
  }

  @override
  void dispose() {
    _youtubePlayerController.removeListener(_checkFullScreen);
    _youtubePlayerController.dispose();
    _urlFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // page title
      appBar: _isFullScreen
          ? null
          : AppBar(
              title: Transform.scale(
                scale: 1.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Icon(Icons.play_circle_outline_rounded,
                        color: Colors.red.shade700),
                    Text(
                      "Youtube Player",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700),
                    ),
                  ],
                ),
              ),
              actions: [SizedBox(width: 60)],
              // centerTitle: true,
            ),

      // content
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // youtube player
          YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _youtubePlayerController,
            ),
            builder: (context, player) {
              return Column(
                children: [
                  player,
                ],
              );
            },
          ),

          // url input
          if (!_youtubePlayerController.value.isFullScreen)
            Card(
              margin: const EdgeInsets.only(
                  top: 30, bottom: 0, left: 10, right: 10),
              elevation: 10,
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.link, color: theme.scrim),
                  suffixIcon: GestureDetector(
                    onTap: () => playVideoByUrl(_urlFieldController.text),
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(color: theme.primary),
                      child: Icon(
                        Icons.play_circle,
                        color: theme.onPrimary,
                      ),
                    ),
                  ),
                  hintText: "https://youtu.be/6X9HaLYiK24",
                  fillColor: theme.surfaceContainerLowest,
                  filled: true,
                  border: InputBorder.none,
                ),
                textAlignVertical: TextAlignVertical.center,
                controller: _urlFieldController,
                onEditingComplete: () {
                  playVideoByUrl(_urlFieldController.text);
                  FocusScope.of(context).unfocus();
                },
                onTapOutside: (event) {
                  playVideoByUrl(_urlFieldController.text);
                  FocusScope.of(context).unfocus();
                },
                onTap: () {
                  // select all text in this field
                  _urlFieldController.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: _urlFieldController.text.length,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
