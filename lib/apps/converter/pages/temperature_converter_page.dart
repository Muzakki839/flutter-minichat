import 'package:flutter/material.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({
    super.key,
  });

  @override
  State<TemperatureConverterPage> createState() =>
      _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  List<String> units = [
    "Celsius",
    "Fahrenheit",
    "Kelvin",
  ];

  TextEditingController _value1Controller = TextEditingController(text: "0");
  TextEditingController _value2Controller = TextEditingController(text: "0");

  String selectedUnit1 = "Celsius";
  String selectedUnit2 = "Fahrenheit";

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        // value1
        DropdownButton<String>(
          value: selectedUnit1,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          items: units.map((unit) {
            return DropdownMenuItem(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedUnit1 = value!;
            });
          },
        ),
        SizedBox(height: 20),
        CommonTextField(
          hintText: "0",
          textColor: Colors.black,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          inputBorder: OutlineInputBorder(),
          controller: _value1Controller,
        ),

        // swap icon
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Icon(Icons.swap_horiz_rounded, size: 40),
        ),

        // value2
        DropdownButton<String>(
          value: selectedUnit2,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          items: units.map((unit) {
            return DropdownMenuItem(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedUnit2 = value!;
            });
          },
        ),
        SizedBox(height: 20),
        CommonTextField(
          hintText: "0",
          textColor: Colors.black,
          textAlign: TextAlign.right,
          keyboardType: TextInputType.number,
          inputBorder: OutlineInputBorder(),
          controller: _value2Controller,
        ),
      ],
    );
  }
}
