import 'package:flutter/material.dart';
import 'package:minichat/widgets/fields/common_text_field.dart';

class WeightConverterPage extends StatefulWidget {
  const WeightConverterPage({
    super.key,
  });

  @override
  State<WeightConverterPage> createState() => _WeightConverterPageState();
}

class _WeightConverterPageState extends State<WeightConverterPage> {
  List<String> units = [
    "Miligram (mg)",
    "Gram (g)",
    "Kilogram (kg)",
    "Ton",
  ];

  final TextEditingController _value1Controller = TextEditingController();
  final TextEditingController _value2Controller = TextEditingController();

  String selectedUnit1 = "Kilogram (kg)";
  String selectedUnit2 = "Gram (g)";

  void _convertFromValue1() {
    double value1 = double.tryParse(_value1Controller.text) ?? 0;
    double value2 = _convertWeight(value1, selectedUnit1, selectedUnit2);
    _value2Controller.text = value2.toStringAsPrecision(4);
  }

  void _convertFromValue2() {
    double value2 = double.tryParse(_value2Controller.text) ?? 0;
    double value1 = _convertWeight(value2, selectedUnit2, selectedUnit1);
    _value1Controller.text = value1.toStringAsPrecision(4);
  }

  double _convertWeight(double value, String fromUnit, String toUnit) {
    if (fromUnit == toUnit) return value;

    double baseValue;
    switch (fromUnit) {
      case "Miligram (mg)":
        baseValue = value / 1000 / 1000;
        break;
      case "Gram (g)":
        baseValue = value / 1000;
        break;
      case "Kilogram (kg)":
        baseValue = value;
        break;
      case "Ton":
        baseValue = value * 1000;
        break;
      default:
        baseValue = value;
    }

    switch (toUnit) {
      case "Miligram (mg)":
        return baseValue * 1000 * 1000;
      case "Gram (g)":
        return baseValue * 1000;
      case "Kilogram (kg)":
        return baseValue;
      case "Ton":
        return baseValue / 1000;
      default:
        return baseValue;
    }
  }

  void _swapUnits() {
    setState(() {
      String tempUnit = selectedUnit1;
      selectedUnit1 = selectedUnit2;
      selectedUnit2 = tempUnit;

      TextEditingController tempController = _value1Controller;
      _value1Controller.text = _value2Controller.text;
      _value2Controller.text = tempController.text;

      _convertFromValue1();
    });
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
          child: IconButton(
            icon: Icon(Icons.swap_horiz_rounded),
            iconSize: 40,
            onPressed: _swapUnits,
          ),
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
