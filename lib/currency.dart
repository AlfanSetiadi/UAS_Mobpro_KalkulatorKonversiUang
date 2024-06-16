import 'package:flutter/material.dart';

class CurrencyConverterScreen extends StatefulWidget {
  @override
  _CurrencyConverterScreenState createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  String _fromCurrency = 'USD';
  String _toCurrency = 'IDR';
  double _amount = 0;
  double _result = 0;
  TextEditingController _amountController = TextEditingController();

  // Data nilai tukar mata uang
  Map<String, double> exchangeRates = {
    'USD-IDR': 16486,
    'EUR-IDR': 17669,
    'JPY-IDR': 130,
    'GBP-IDR': 20000,
    'IDR-USD': 0.0000704,
    'IDR-EUR': 0.0000625,
    'IDR-JPY': 0.0077,
    'IDR-GBP': 0.0000500,
    'USD-EUR': 0.89,
    'USD-JPY': 108.77,
    'USD-GBP': 0.78,
    'EUR-USD': 1.12,
    'EUR-JPY': 121.91,
    'EUR-GBP': 0.88,
    'JPY-USD': 0.0092,
    'JPY-EUR': 0.0082,
    'JPY-GBP': 0.0072,
    'GBP-USD': 1.29,
    'GBP-EUR': 1.14,
    'GBP-JPY': 138.71,
    'AUD-USD': 0.75,
    'AUD-EUR': 0.67,
    'AUD-JPY': 78.05,
    'AUD-GBP': 0.55,
    'AUD-IDR': 10243.34,
    'CAD-USD': 0.79,
    'CAD-EUR': 0.71,
    'CAD-JPY': 82.48,
    'CAD-GBP': 0.58,
    'CAD-IDR': 9085.68,
    'CHF-USD': 1.09,
    'CHF-EUR': 0.97,
    'CHF-JPY': 112.57,
    'CHF-GBP': 0.79,
    'CHF-IDR': 15519.54,
    'CNY-USD': 0.15,
    'CNY-EUR': 0.13,
    'CNY-JPY': 15.09,
    'CNY-GBP': 0.11,
    'CNY-IDR': 2025.43,
    'HKD-USD': 0.13,
    'HKD-EUR': 0.12,
    'HKD-JPY': 13.89,
    'HKD-GBP': 0.10,
    'HKD-IDR': 1744.96,
    'INR-USD': 0.014,
    'INR-EUR': 0.013,
    'INR-JPY': 1.49,
    'INR-GBP': 0.011,
    'INR-IDR': 142.24,
    'KRW-USD': 0.00089,
    'KRW-EUR': 0.00079,
    'KRW-JPY': 0.091,
    'KRW-GBP': 0.00064,
    'KRW-IDR': 11.38,
    'MXN-USD': 0.050,
    'MXN-EUR': 0.045,
    'MXN-JPY': 5.24,
    'MXN-GBP': 0.037,
    'MXN-IDR': 629.20,
    'NOK-USD': 0.11,
    'NOK-EUR': 0.10,
    'NOK-JPY': 11.62,
    'NOK-GBP': 0.08,
    'NOK-IDR': 1233.49,
    'NZD-USD': 0.71,
    'NZD-EUR': 0.64,
    'NZD-JPY': 74.66,
    'NZD-GBP': 0.53,
    'NZD-IDR': 7741.54,
    'SEK-USD': 0.11,
    'SEK-EUR': 0.099,
    'SEK-JPY': 11.52,
    'SEK-GBP': 0.081,
    'SEK-IDR': 1161.17,
    'SGD-USD': 0.73,
    'SGD-EUR': 0.65,
    'SGD-JPY': 75.21,
    'SGD-GBP': 0.53,
    'SGD-IDR': 9496.02,
    'TRY-USD': 0.12,
    'TRY-EUR': 0.11,
    'TRY-JPY': 13.02,
    'TRY-GBP': 0.091,
    'TRY-IDR': 1161.17,
    'ZAR-USD': 0.067,
    'ZAR-EUR': 0.059,
    'ZAR-JPY': 6.91,
    'ZAR-GBP': 0.049,
    'ZAR-IDR': 778.65,
  };

  Map<String, String> currencyNames = {
    'USD': 'United States Dollar',
    'EUR': 'Euro',
    'JPY': 'Japanese Yen',
    'GBP': 'British Pound Sterling',
    'IDR': 'Indonesian Rupiah',
    'AUD': 'Australian Dollar',
    'CAD': 'Canadian Dollar',
    'CHF': 'Swiss Franc',
    'CNY': 'Chinese Yuan',
    'HKD': 'Hong Kong Dollar',
    'INR': 'Indian Rupee',
    'KRW': 'South Korean Won',
    'MXN': 'Mexican Peso',
    'NOK': 'Norwegian Krone',
    'NZD': 'New Zealand Dollar',
    'SEK': 'Swedish Krona',
    'SGD': 'Singapore Dollar',
    'TRY': 'Turkish Lira',
    'ZAR': 'South African Rand',
  };

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onButtonPress(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _amountController.clear();
        _amount = 0;
      } else if (buttonText == '←') {
        if (_amountController.text.isNotEmpty) {
          _amountController.text = _amountController.text
              .substring(0, _amountController.text.length - 1);
          _amount = double.tryParse(_amountController.text) ?? 0;
        }
      } else if (buttonText == 'AC') {
        _amountController.clear();
        _amount = 0;
      } else if (buttonText == '+/-') {
        if (_amountController.text.isNotEmpty) {
          _amountController.text = (_amount * -1).toString();
          _amount = double.tryParse(_amountController.text) ?? 0;
        }
      } else if (buttonText == '%') {
        if (_amountController.text.isNotEmpty) {
          _amountController.text = (_amount / 100).toString();
          _amount = double.tryParse(_amountController.text) ?? 0;
        }
      } else if (buttonText == '.') {
        if (!_amountController.text.contains('.')) {
          _amountController.text += buttonText;
          _amount = double.tryParse(_amountController.text) ?? 0;
        }
      } else if (buttonText == '=') {
        _convertCurrency();
      } else {
        _amountController.text += buttonText;
        _amount = double.tryParse(_amountController.text) ?? 0;
      }
    });
    _convertCurrency(); // Call _convertCurrency every time there is a change in input
  }

  void _convertCurrency() {
    String key = '$_fromCurrency-$_toCurrency';
    double rate = exchangeRates[key] ?? 1;
    setState(() {
      _result = _amount * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                DropdownButton<String>(
                  value: _fromCurrency,
                  items: <String>[
                    'USD',
                    'EUR',
                    'JPY',
                    'GBP',
                    'IDR',
                    'AUD',
                    'CAD',
                    'CHF',
                    'CNY',
                    'HKD',
                    'INR',
                    'KRW',
                    'MXN',
                    'NOK',
                    'NZD',
                    'SEK',
                    'SGD',
                    'TRY',
                    'ZAR',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('${value} - ${currencyNames[value]}'),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _fromCurrency = value!;
                    });
                    _convertCurrency();
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(labelText: 'Amount'),
                          controller: _amountController,
                          onChanged: (value) {
                            setState(() {
                              _amount = double.tryParse(value) ?? 0;
                            });
                            _convertCurrency(); // Panggil _convertCurrency setiap kali ada perubahan input
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Row(
              children: <Widget>[
                DropdownButton<String>(
                  value: _toCurrency,
                  items: <String>[
                    'USD',
                    'EUR',
                    'JPY',
                    'GBP',
                    'IDR',
                    'AUD',
                    'CAD',
                    'CHF',
                    'CNY',
                    'HKD',
                    'INR',
                    'KRW',
                    'MXN',
                    'NOK',
                    'NZD',
                    'SEK',
                    'SGD',
                    'TRY',
                    'ZAR',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text('${value} - ${currencyNames[value]}'),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _toCurrency = value!;
                    });
                    _convertCurrency();
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Result'),
                      readOnly: true,
                      controller: TextEditingController(
                          text: '${_result.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
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
            )
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: EdgeInsets.all(16),
        ),
      ),
    );
  }
}
