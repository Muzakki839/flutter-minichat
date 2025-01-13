import 'package:flutter/material.dart';
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
            iconColor: theme.error,
            onTap: () {},
          ),
          Card.outlined(),
          Card.outlined(),
          Card.outlined(),
          Card.outlined(),
        ],
      ),
    );
  }
}
