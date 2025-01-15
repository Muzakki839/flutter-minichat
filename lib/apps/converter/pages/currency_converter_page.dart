import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minichat/widgets/fields/common_text_field.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({
    super.key,
  });

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  List<String> units = [
    "IDR",
    "USD",
    "EUR",
    "JPY",
  ]; // Add more currencies as needed

  final TextEditingController _value1Controller = TextEditingController();
  final TextEditingController _value2Controller = TextEditingController();

  String selectedUnit1 = "IDR";
  String selectedUnit2 = "USD";

  Future<double> _fetchConversionRate(String fromUnit, String toUnit) async {
    final response = await http.get(Uri.parse(
        'https://api.frankfurter.app/latest?from=$fromUnit&to=$toUnit'));
    if (response.statusCode == 200) {
      final rates = json.decode(response.body)['rates'];
      return rates[toUnit];
    } else {
      print('Failed to load conversion rate: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load conversion rate');
    }
  }

  void _convertFromValue1() async {
    double value1 = double.tryParse(_value1Controller.text) ?? 0;
    try {
      double rate = await _fetchConversionRate(selectedUnit1, selectedUnit2);
      double value2 = value1 * rate;
      _value2Controller.text = value2.toStringAsFixed(2);
    } catch (e) {
      print('Error converting from value1: $e');
    }
  }

  void _convertFromValue2() async {
    double value2 = double.tryParse(_value2Controller.text) ?? 0;
    try {
      double rate = await _fetchConversionRate(selectedUnit2, selectedUnit1);
      double value1 = value2 * rate;
      _value1Controller.text = value1.toStringAsFixed(2);
    } catch (e) {
      print('Error converting from value2: $e');
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
