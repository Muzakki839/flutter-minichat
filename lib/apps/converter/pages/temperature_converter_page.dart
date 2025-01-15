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

  final TextEditingController _value1Controller = TextEditingController();
  final TextEditingController _value2Controller = TextEditingController();

  String selectedUnit1 = "Celsius";
  String selectedUnit2 = "Fahrenheit";

  void _convertFromValue1() {
    double value1 = double.tryParse(_value1Controller.text) ?? 0;
    double value2 = _convertTemperature(value1, selectedUnit1, selectedUnit2);
    _value2Controller.text = value2.toStringAsFixed(2);
  }

  void _convertFromValue2() {
    double value2 = double.tryParse(_value2Controller.text) ?? 0;
    double value1 = _convertTemperature(value2, selectedUnit2, selectedUnit1);
    _value1Controller.text = value1.toStringAsFixed(2);
  }

  double _convertTemperature(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;

    double celsiusValue;
    switch (fromUnit) {
      case "Fahrenheit":
        celsiusValue = (value - 32) * 5 / 9;
        break;
      case "Kelvin":
        celsiusValue = value - 273.15;
        break;
      default:
        celsiusValue = value;
    }

    switch (toUnit) {
      case "Fahrenheit":
        return celsiusValue * 9 / 5 + 32;
      case "Kelvin":
        return celsiusValue + 273.15;
      default:
        return celsiusValue;
    }
  }

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
              _convertFromValue2();
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
          onChanged: (_) => _convertFromValue1(),
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
              _convertFromValue1();
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
          onChanged: (_) => _convertFromValue2(),
        ),
      ],
    );
  }
}
