import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';
import 'package:minichat/widgets/buttons/card_button.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String prevOperation = ""; // e.g. "4+1"
  String value = "0"; // e.g. "5"

  void appendToValue(String newValue) {
    setState(() {
      if (value == "0") {
        value = newValue;
      } else {
        value += newValue;
      }
    });
  }

  void count() {
    setState(() {
      prevOperation = value;
      try {
        final expression = Expression.parse(value);
        final evaluator = const ExpressionEvaluator();
        final result = evaluator.eval(expression, {});
        value = result.toString();
      } catch (e) {
        value = "Error";
      }
    });
  }

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
            children: [
              Icon(Icons.calculate_rounded, color: Colors.blue.shade700),
              SizedBox(width: 10),
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
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, bottom: 55),
            child: _buildValueDisplay(theme),
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
                onTap: count,
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
            prevOperation,
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
            value,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 60),
            overflow: TextOverflow.ellipsis,
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
        CardButton(
          text: "7",
          onTap: () => appendToValue("7"),
        ),
        CardButton(
          text: "8",
          onTap: () => appendToValue("8"),
        ),
        CardButton(
          text: "9",
          onTap: () => appendToValue("9"),
        ),
        CardButton(
          text: "+",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
          onTap: () => appendToValue("+"),
        ),
        CardButton(
          text: "4",
          onTap: () => appendToValue("4"),
        ),
        CardButton(
          text: "5",
          onTap: () => appendToValue("5"),
        ),
        CardButton(
          text: "6",
          onTap: () => appendToValue("6"),
        ),
        CardButton(
          text: "–",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
          onTap: () => appendToValue("-"),
        ),
        CardButton(
          text: "1",
          onTap: () => appendToValue("1"),
        ),
        CardButton(
          text: "2",
          onTap: () => appendToValue("2"),
        ),
        CardButton(
          text: "3",
          onTap: () => appendToValue("3"),
        ),
        CardButton(
          text: "x",
          backgroundColor: Colors.blue.shade400,
          foregroundColor: theme.onPrimary,
          onTap: () => appendToValue("*"),
        ),
        CardButton(
          text: "C",
          backgroundColor: Colors.red.shade400,
          foregroundColor: theme.onPrimary,
          onTap: () {
            setState(() {
              value = "0";
            });
          },
        ),
        CardButton(
          text: "0",
          onTap: () => appendToValue("0"),
        ),
        CardButton(
          icon: Icon(Icons.backspace, color: Colors.red.shade400, size: 30),
          onTap: () {
            setState(() {
              if (value.length > 1) {
                value = value.substring(0, value.length - 1);
              } else {
                value = "0";
              }
            });
          },
        ),
        CardButton(
          text: "/",
          backgroundColor: Colors.blue.shade500,
          foregroundColor: theme.onPrimary,
          onTap: () => appendToValue("/"),
        ),
      ],
    );
  }
}
