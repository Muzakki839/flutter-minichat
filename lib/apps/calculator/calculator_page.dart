import 'package:flutter/material.dart';
import 'package:minichat/widgets/buttons/card_button.dart';

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

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
              Icon(Icons.calculate_rounded, color: Colors.blue.shade700),
              Text(
                "Calculator",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue.shade700),
              ),
            ],
          ),
        ),
        actions: [SizedBox(width: 60)],
        // centerTitle: true,
      ),

      // content
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20, bottom: 100),
              child: _buildValueDisplay(theme),
            ),
          ),

          // numpad
          SizedBox(height: 420, child: _buildNumpad(theme)),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: CardButton(
                text: "=",
                backgroundColor: Colors.green.shade700,
                foregroundColor: theme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildValueDisplay(ColorScheme theme) {
    return Column(
      children: [
        // previous operation
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "4+1",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.black54),
          ),
        ),

        // result text
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            "5",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 50),
          ),
        ),
      ],
    );
  }

  Widget _buildNumpad(ColorScheme theme) {
    return GridView(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
      children: [
        CardButton(text: "7"),
        CardButton(text: "8"),
        CardButton(text: "9"),
        CardButton(
          text: "+",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
        ),
        CardButton(text: "4"),
        CardButton(text: "5"),
        CardButton(text: "6"),
        CardButton(
          text: "–",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
        ),
        CardButton(text: "1"),
        CardButton(text: "2"),
        CardButton(text: "3"),
        CardButton(
          text: "x",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
        ),
        CardButton(
          text: "C",
          backgroundColor: Colors.red.shade400,
          foregroundColor: theme.onPrimary,
        ),
        CardButton(text: "0"),
        CardButton(
          icon: Icon(Icons.backspace, color: Colors.red.shade400, size: 30),
        ),
        CardButton(
          text: "/",
          backgroundColor: Colors.blue.shade500,
          foregroundColor: theme.onPrimary,
        ),
      ],
    );
  }
}
