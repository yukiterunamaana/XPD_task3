import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polynomist/diff.dart';
import 'package:polynomist/parser.dart';
import 'package:polynomist/term.dart'; // For Clipboard

void main() {
  runApp(DerivativeCalculatorApp());
}

class DerivativeCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Derivative Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DerivativeCalculator(),
    );
  }
}

class DerivativeCalculator extends StatefulWidget {
  @override
  _DerivativeCalculatorState createState() => _DerivativeCalculatorState();
}

class _DerivativeCalculatorState extends State<DerivativeCalculator> {
  final TextEditingController _functionController = TextEditingController();
  final TextEditingController _variableController = TextEditingController();
  String _result = '';

  void _calculateDerivative() {
    String functionInput = _functionController.text.trim();
    String variableInput = _variableController.text.trim();

    if (functionInput.isEmpty || variableInput.isEmpty) {
      // Show a snackbar if the input is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both function and variable!')),
      );
      return;
    }

    // Call your logic to calculate the derivative here
    // For demonstration, we'll just show the input
    setState(() {
      _result = presentAnswer(diff(parse(functionInput),
          variableInput)); // Replace with actual calculation
    });
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _result)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Result copied to clipboard!')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Derivative Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _functionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter function',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _variableController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter variable',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateDerivative,
              child: Text('Calculate Derivative'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _copyToClipboard,
              child: Text('Copy Result'),
            ),
          ],
        ),
      ),
    );
  }
}
