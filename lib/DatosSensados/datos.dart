import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DatosSensadosPage extends StatefulWidget {
  @override
  _DatosSensadosPageState createState() => _DatosSensadosPageState();
}

class _DatosSensadosPageState extends State<DatosSensadosPage> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  List<Map<String, dynamic>> sensorData = [];

  @override
  void initState() {
    super.initState();

    // Escucha los cambios en el nodo "Sensor/datos"
    _database.child("Sensor/datos").onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          // Convierte el valor de event.snapshot.value en una lista de Mapas
          final List<dynamic> rawData = event.snapshot.value as List<dynamic>;
          sensorData = rawData.map((item) {
            return {
              "Fecha": item["Fecha"],
              "Incendio": item["Incendio"],
              "hora": item["hora"],
              "Bocina": item["Bocina"],
            };
          }).toList();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Sensados'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (final data in sensorData)
              ListTile(
                title: Text("Bocina: ${data['Bocina'] == 1 ? 'Encendida' : 'Apagado'}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Sensor de incendio: ${data['Incendio'] == 1 ? 'Peligro de incendio' : 'Sin peligro de incendio'}"),
                    Text("Fecha: ${data['Fecha']}"),
                    Text("Hora: ${data['hora']}"),
                  ],
                ),
                // Puedes agregar más datos aquí si es necesario
              ),
          ],
        ),
      ),
    );
  }
}
