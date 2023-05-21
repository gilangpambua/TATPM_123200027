import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KonversiWaktuPage extends StatefulWidget {
  @override
  _KonversiWaktuPageState createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  final List<String> locations = ['WIB', 'WIT', 'WITA', 'London'];

  String _selectedLocation = '';
  String _currentTime = '';
  String _convertedTime = '';

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedLocation = locations[0];
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _updateTimes();
      });
    });
  }

  void _updateTimes() {
    DateTime now = DateTime.now();
    _currentTime = DateFormat('yyyy-MM-dd').format(now) + '\n' + DateFormat('HH:mm:ss').format(now);

    if (_selectedLocation == 'WIB') {
      DateTime wibTime = now.toUtc().add(Duration(hours: 7));
      _convertedTime = DateFormat('yyyy-MM-dd').format(wibTime) + '\n' + DateFormat('HH:mm:ss').format(wibTime);
    } else if (_selectedLocation == 'WIT') {
      DateTime witTime = now.toUtc().add(Duration(hours: 9));
      _convertedTime = DateFormat('yyyy-MM-dd').format(witTime) + '\n' + DateFormat('HH:mm:ss').format(witTime);
    } else if (_selectedLocation == 'WITA') {
      DateTime witaTime = now.toUtc().add(Duration(hours: 8));
      _convertedTime = DateFormat('yyyy-MM-dd').format(witaTime) + '\n' + DateFormat('HH:mm:ss').format(witaTime);
    } else if (_selectedLocation == 'London') {
      DateTime londonTime = now.toUtc().add(Duration(hours: 1));
      _convertedTime = DateFormat('yyyy-MM-dd').format(londonTime) + '\n' + DateFormat('HH:mm:ss').format(londonTime);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Current Time:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              _currentTime,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            Text(
              'Converted Time:',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              _convertedTime,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            DropdownButton<String>(
              value: _selectedLocation,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedLocation = newValue;
                    _updateTimes();
                  });
                }
              },
              items: locations.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
