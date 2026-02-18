import 'package:flutter/material.dart';
import 'calculator_screen.dart';


void main() {
  runApp(const NeumorphismCalculator());
}

class NeumorphismCalculator extends StatelessWidget {
  const NeumorphismCalculator({super.key});

  @override
  Widget build(BuildContext context) {



    return MaterialApp( theme: ThemeData.light(), // Настройки для дня
      darkTheme: ThemeData.dark(), // Настройки для ночи
      themeMode: ThemeMode.system, // Слушаться настроек телефона
      debugShowCheckedModeBanner: false,
      home:  CalculatorScreen(),
    );
  }
}


