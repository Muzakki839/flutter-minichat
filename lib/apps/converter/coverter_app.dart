import 'package:flutter/material.dart';
import 'package:minichat/apps/converter/pages/currency_converter_page.dart';
import 'package:minichat/apps/converter/pages/temperature_converter_page.dart';
import 'package:minichat/apps/converter/pages/weight_converter_page.dart';

class CoverterApp extends StatefulWidget {
  const CoverterApp({super.key});

  @override
  State<CoverterApp> createState() => _CoverterAppState();
}

class _CoverterAppState extends State<CoverterApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // page title
      appBar: AppBar(
        title: Transform.scale(
          scale: 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.swap_horizontal_circle_rounded,
                  color: Colors.purple.shade600),
              SizedBox(width: 10),
              Text(
                "Converter",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.purple.shade600),
              ),
            ],
          ),
        ),
        actions: [SizedBox(width: 60)],
        // centerTitle: true,
      ),

      // content
      body: _buildConverterPage(context),
    );
  }

  Widget _buildConverterPage(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // tab bar
        appBar: TabBar(tabs: <Widget>[
          Tab(
            icon: Icon(Icons.ac_unit_rounded),
            text: "Temperature",
          ),
          Tab(
            icon: Icon(Icons.scale_rounded),
            text: "Weight",
          ),
          Tab(
            icon: Icon(Icons.currency_exchange_rounded),
            text: "Currency",
          ),
        ]),

        // tab views
        body: TabBarView(children: <Widget>[
          TemperatureConverterPage(),
          WeightConverterPage(),
          CurrencyConverterPage(),
        ]),
      ),
    );
  }
}
