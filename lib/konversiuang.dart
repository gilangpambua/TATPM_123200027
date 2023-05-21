import 'package:flutter/material.dart';

class KonversiUangPage extends StatefulWidget {
  const KonversiUangPage({Key? key}) : super(key: key);

  @override
  _KonversiUangPageState createState() => _KonversiUangPageState();
}

class _KonversiUangPageState extends State<KonversiUangPage> {
  String _selectedCurrency = 'USD';
  double _amount = 0;
  double _convertedAmount = 0;

  final Map<String, double> conversionRates = {
    'USD': 0.000067, // contoh konversi dari IDR ke USD
    'EUR': 0.000062, // contoh konversi dari IDR ke EUR
    'GBP': 0.000054, // contoh konversi dari IDR ke GBP
    'JPY': 0.0092, // contoh konversi dari IDR ke JPY
  };

  void _convertCurrency() {
    setState(() {
      _convertedAmount = _amount * conversionRates[_selectedCurrency]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konversi Uang'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Masukkan Nilai Dalam IDR',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _amount = double.tryParse(value) ?? 0;
                    });
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Pilih Mata Uang',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: _selectedCurrency,
                  items: conversionRates.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCurrency = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _convertCurrency,
                  child: const Text('Konversi'),
                ),
                const SizedBox(height: 20),
                Text(
                  'Hasil Konversi:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '${_convertedAmount.toStringAsFixed(2)} $_selectedCurrency',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
