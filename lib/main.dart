import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'currency.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _expression = '';
  String _result = '';
  String _selectedCurrency = '';
  List<String> _history = []; // Menambah variabel untuk menyimpan history

  void _onButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _expression = '';
        _result = '';
      } else if (buttonText == '←') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
      } else if (buttonText == '=') {
        try {
          _result = _calculate(_expression);
          _history.insert(
              0, '$_expression = $_result'); // Menyimpan history operasi
        } catch (e) {
          _result = 'Error';
        }
      } else {
        _expression += buttonText;
      }
    });
  }

  String _calculate(String expression) {
    try {
      expression = expression.replaceAll('x', '*').replaceAll('%', '/100');
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  void _showCurrencyScreen() async {
    final selectedCurrency = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CurrencyConverterScreen()),
    );

    if (selectedCurrency != null) {
      setState(() {
        _selectedCurrency = selectedCurrency;
      });
      print('Mata uang terpilih: $_selectedCurrency');
    }
  }

  void _showHistoryDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('History'),
          content: Container(
            width: double.maxFinite,
            height: 300,
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_history[index]),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tentang Aplikasi'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Aplikasi ini adalah kalkulator sederhana dengan fitur konversi mata uang.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8),
              Text(
                'Dikembangkan sebagai proyek Ujian Akhir Semester (UAS) dalam matakuliah Mobile Programming Lanjut di STMIK Widya Utama Purwokerto.',
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 8),
              Text(
                'Dikembangkan oleh:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Alfan Setiadi STI202102200',
              ),
              Text(
                'Dwi Lusiani STI20210270',
              ),
              Text(
                'Tri Deka Rahmawati STI202102198',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
            icon: Icon(Icons.attach_money),
            onPressed: _showCurrencyScreen,
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('History'),
                  value: 'History',
                ),
                PopupMenuItem(
                  child: Text('About'),
                  value: 'About',
                ),
              ];
            },
            onSelected: (value) {
              if (value == 'History') {
                _showHistoryDialog();
              } else if (value == 'About') {
                _showAboutDialog();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Text(
                    _expression,
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                reverse: true,
                child: Text(
                  _result,
                  style: TextStyle(fontSize: 32, color: Colors.greenAccent),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              flex: 2,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1,
                padding: EdgeInsets.all(8.0),
                shrinkWrap: true,
                children: [
                  CalculatorButton('C',
                      onPressed: _onButtonPress, color: Colors.blueGrey[800]),
                  CalculatorButton('%',
                      onPressed: _onButtonPress, color: Colors.blueGrey[800]),
                  CalculatorButton('←',
                      onPressed: _onButtonPress, color: Colors.blueGrey[800]),
                  CalculatorButton('/',
                      onPressed: _onButtonPress, color: Colors.orangeAccent),
                  CalculatorButton('7',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('8',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('9',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('x',
                      onPressed: _onButtonPress, color: Colors.orangeAccent),
                  CalculatorButton('4',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('5',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('6',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('-',
                      onPressed: _onButtonPress, color: Colors.orangeAccent),
                  CalculatorButton('1',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('2',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('3',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('+',
                      onPressed: _onButtonPress, color: Colors.orangeAccent),
                  CalculatorButton('0',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('00',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('.',
                      onPressed: _onButtonPress, color: Colors.blueGrey[400]),
                  CalculatorButton('=',
                      onPressed: _onButtonPress, color: Colors.orangeAccent),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final void Function(String) onPressed;
  final Color? color;

  CalculatorButton(this.text, {required this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => onPressed(text),
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Colors.blueGrey,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
