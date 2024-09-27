import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState(); // Removed the underscore to make it public
}

class CalculatorState extends State<Calculator> {
  String _display = "0";
  String _operand = '';
  double _firstNumber = 0;
  double _secondNumber = 0;
  String _result = "0";

  void _buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _display = "0";
        _firstNumber = 0;
        _secondNumber = 0;
        _operand = '';
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _operand = value;
        _firstNumber = double.tryParse(_display) ?? 0;
        _display = "0";
      } else if (value == '=') {
        _secondNumber = double.tryParse(_display) ?? 0;
        _calculateResult();
      } else {
        if (_display == "0") {
          _display = value;
        } else {
          _display += value;
        }
      }
    });
  }

  void _calculateResult() {
    switch (_operand) {
      case '+':
        _result = (_firstNumber + _secondNumber).toString();
        break;
      case '-':
        _result = (_firstNumber - _secondNumber).toString();
        break;
      case '*':
        _result = (_firstNumber * _secondNumber).toString();
        break;
      case '/':
        if (_secondNumber != 0) {
          _result = (_firstNumber / _secondNumber).toString();
        } else {
          _result = "Error"; // Division by zero error
        }
        break;
      default:
        return;
    }
    _display = _result;
    _operand = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display Screen
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                _display,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Divider(color: Colors.white),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonRow(['7', '8', '9', '/']),
                _buildButtonRow(['4', '5', '6', '*']),
                _buildButtonRow(['1', '2', '3', '-']),
                _buildButtonRow(['C', '0', '=', '+']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((String value) {
        return _buildButton(value);
      }).toList(),
    );
  }

  Widget _buildButton(String value) {
    Color buttonColor;
    Color textColor = Colors.white;

    if (value == 'C') {
      buttonColor = Colors.redAccent; // Clear button
    } else if (value == '=' || value == '+' || value == '-' || value == '*' || value == '/') {
      buttonColor = Colors.orangeAccent; // Operator buttons
    } else {
      buttonColor = Colors.grey[800]!; // Number buttons
    }

    return ElevatedButton(
      onPressed: () => _buttonPressed(value),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(22),
        shape: const CircleBorder(),
        backgroundColor: buttonColor,
        foregroundColor: textColor,
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}