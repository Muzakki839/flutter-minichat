import 'package:flutter/material.dart';
import 'package:minichat/apps/youtube_player/youtube_player_page.dart';
import 'package:minichat/widgets/items/grid_tile_button.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      // page title
      appBar: AppBar(
        title: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.apps_rounded, color: theme.primary),
              Text(
                "Tool Apps",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: theme.primary),
              ),
            ],
          ),
        ),
      ),

      // tools grid
      body: GridView(
        padding: EdgeInsets.all(20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        children: [
          GridTileButton(
            nameText: "Youtube Player",
            icon: Icons.play_circle_fill_rounded,
            iconColor: Colors.red.shade700,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => YoutubePlayerPage()),
              );
            },
          ),
          GridTileButton(
            nameText: "Calculator",
            icon: Icons.calculate_rounded,
            iconColor: Colors.blue.shade700,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ),
              // );
            },
          ),
          GridTileButton(
            nameText: "Converter",
            icon: Icons.swap_horizontal_circle_rounded,
            iconColor: Colors.purple.shade600,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ),
              // );
            },
          ),
        ],
      ),
    );
  }
}
