import 'package:calculator_app/neumorphic_button/CalculatorFunctionButton.dart';
import 'package:calculator_app/neumorphic_button/CalculatorOperatorButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:math_expressions/math_expressions.dart';
import 'neumorphic_button/CalculatorKeyButton.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String expression = "";
  String result = "0";

  void onButtonTap(String value) {
    setState(() {
      switch (value) {
        case 'C':
          expression = "";
          result = "0";
          break;

        case '=':
          _calculate();
          break;

        case '+/-':
          if (expression.isEmpty) return;

          // Находим последнее число в выражении
          final regex = RegExp(r'(-?\d+\.?\d*)$');
          final match = regex.firstMatch(expression);

          if (match != null) {
            String lastNumber = match.group(0)!;

            // Инвертируем знак
            String inverted = lastNumber.startsWith('-')
                ? lastNumber.substring(1)
                : '-$lastNumber';

            // Заменяем последнее число на инвертированное
            expression = expression.replaceRange(
                match.start, match.end, inverted);
          }
          break;
        case '%':
          if (expression.isEmpty) return;

          // Находим конструкцию: число оператор число
          final regex = RegExp(r'(\d+\.?\d*)([+\-×÷])(\d+\.?\d*)$');
          final match = regex.firstMatch(expression);

          if (match != null) {
            double first = double.parse(match.group(1)!);
            String operator = match.group(2)!;
            double second = double.parse(match.group(3)!);

            double percentValue;

            if (operator == '+' || operator == '-') {
              // 100 + 8%  →  100 * 8 / 100
              percentValue = first * second / 100;
            } else {
              // 100 × 8%  →  8 / 100
              percentValue = second / 100;
            }

            String formatted = percentValue
                .toStringAsFixed(10)
                .replaceAll(RegExp(r'0+$'), '')
                .replaceAll(RegExp(r'\.$'), '');

            expression = expression.replaceRange(
                match.start, match.end,
                '${match.group(1)}$operator$formatted');
          }

          break;



        default:
          expression += value;
      }
    });
  }



  void _calculate() {
    if (expression.isEmpty) return;
    try {
      // Заменяем отображаемые символы на операторы, которые понимает библиотека
      String finalExpression = expression
          .replaceAll('×', '*')
          .replaceAll('÷', '/')
          .replaceAll('−', '-'); // Обрабатываем минус, если он пришел как спецсимвол

      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      result = eval.toString();

    } catch (e) {
      result = "Error";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Дисплей
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      expression,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      result,
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.w200,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(19),
              child:
                  // Сетка кнопок
                  StaggeredGrid.count(
                    crossAxisCount: 4, // Всего 4 колонки
                    mainAxisSpacing: 12, // Отступ по вертикали
                    crossAxisSpacing: 12, // Отступ по горизонтали
                    children: [
                      CalculatorFunctionButton(label: 'C', onTap: () { onButtonTap('C'); }),
                      CalculatorFunctionButton(label: '+/-', onTap: () { onButtonTap('+/-'); }),
                      CalculatorFunctionButton(label: '%', onTap: () { onButtonTap('%'); }),
                      CalculatorOperatorButton(label: '÷', onTap: () { onButtonTap('÷'); }),

                      CalculatorKeyButton(label: '7', onTap: () { onButtonTap('7'); }),
                      CalculatorKeyButton(label: '8', onTap: () { onButtonTap('8'); }),
                      CalculatorKeyButton(label: '9', onTap: () { onButtonTap('9'); }),
                      CalculatorOperatorButton(label: '×', onTap: () { onButtonTap('×'); }),

                      CalculatorKeyButton(label: '4', onTap: () { onButtonTap('4'); }),
                      CalculatorKeyButton(label: '5', onTap: () { onButtonTap('5'); }),
                      CalculatorKeyButton(label: '6', onTap: () { onButtonTap('6'); }),
                      CalculatorOperatorButton(label: '−', onTap: () { onButtonTap('-'); }),

                      CalculatorKeyButton(label: '1', onTap: () { onButtonTap('1'); }),
                      CalculatorKeyButton(label: '2', onTap: () { onButtonTap('2'); }),
                      CalculatorKeyButton(label: '3', onTap: () { onButtonTap('3'); }),
                      CalculatorOperatorButton(label: '+', onTap: () { onButtonTap('+'); }),

                      StaggeredGridTile.count(crossAxisCellCount: 2, mainAxisCellCount: 1, child: CalculatorKeyButton(label: '0', onTap: () { onButtonTap('0'); })),
                      CalculatorKeyButton(label: '.', onTap: () { onButtonTap('.'); }),
                      CalculatorOperatorButton(label: '=', onTap: () { onButtonTap('='); }),
                    ],

                  ),
            ),
          ],
        ),
      ),
    );
  }
}



