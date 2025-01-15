import 'package:flutter/material.dart';

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
        children: [
          // previous operation
          Container(color: theme.primary, height: 80,),
          // result text
          Container(color: theme.secondary, height: 120,),

          // numpad
          Expanded(child: Container(color: theme.tertiary)),
        ],
      ),
    );
  }
}
