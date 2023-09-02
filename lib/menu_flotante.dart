import 'package:amst_examenfinal_grupo1_miranda_pulley/DatosSensados/datos.dart';
import 'package:amst_examenfinal_grupo1_miranda_pulley/EstadoBateria/bateria.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset(150, button.size.height)); // Ajusta la posición para que aparezca encima del botón.

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy,
        offset.dx + button.size.width,
        offset.dy + button.size.height,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Datos Sensados',
          child: const Text('Datos Sensados'),
        ),
        PopupMenuItem<String>(
          value: 'Estado de la Batería',
          child: const Text('Estado de la Batería'),
        ),
      ],
    ).then((String? value) {
      if (value != null) {
        _onMenuItemSelected(value);
      }
    });
  }

  void _onMenuItemSelected(String item) {
    // Aquí puedes manejar las acciones correspondientes a las opciones del menú.
    if (item == 'Datos Sensados') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DatosSensadosPage(), // Navega a la página DatosSensadosPage.
        ),
      );
    } else if (item == 'Estado de la Batería') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BateriaPage(), // Navega a la página DatosSensadosPage.
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _showMenu(context), // Abre el menú flotante al tocar el botón de tres puntos.
            tooltip: 'Menu',
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
