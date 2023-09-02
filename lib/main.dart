import 'package:flutter/material.dart';
import 'menu_flotante.dart'; // Importa el archivo menu_flotante.dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Menu Flotante'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Aplicaciones Móviles'),
                const Text('Sistemas Telemáticos'),
                const Text('Examen Final'),
                const Text('Jordan Miranda'),
                const Text('Erick Pulley'),


                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/menu');
                  },
                  child: const Text('Ir al Menú Flotante'),
                ),
              ],
            ),
          ),
        ),
        '/menu': (context) => MyHomePage(title: 'Menu Flotante'),
      },
    );
  }
}
