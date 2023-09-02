import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class BateriaPage extends StatefulWidget {
  @override
  _BateriaPageState createState() => _BateriaPageState();
}

class _BateriaPageState extends State<BateriaPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  int _nivelBateria = 0; // Valor inicial

  @override
  void initState() {
    super.initState();
    _cargarNivelBateria();
  }

  void _cargarNivelBateria() {
    _database.child("Bateria/nivel_bateria").onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          _nivelBateria = event.snapshot.value as int;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bateria'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Nivel de Batería:', style: TextStyle(fontSize: 20)),
            Text('$_nivelBateria%', style: TextStyle(fontSize: 40)),
            SizedBox(height: 20),
            Container(
              width: 400,
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 100,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    leftTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      margin: 1,
                    ),
                    bottomTitles: SideTitles(
                      showTitles: true,
                      getTitles: (value) {
                        DateTime dateTime = DateTime.now().add(Duration(hours: value.toInt()));
                        String formattedHour = DateFormat.Hm().format(dateTime);
                        return formattedHour;                      },
                      margin: 10,
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: const Color(0xff37434d),
                      width: 1,
                    ),
                  ),
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [BarChartRodData(y: _nivelBateria.toDouble(), colors: [Colors.blue])],
                      showingTooltipIndicators: [0],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
