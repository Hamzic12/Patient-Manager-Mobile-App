import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/appointment_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Urologická ordinace',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Přihlašovací obrazovka
        '/home': (context) => HomeScreen(), // Úvodní obrazovka
        '/appointment': (context) => AppointmentsScreen(), // Pacientská obrazovka
        '/inventory': (context) => InventoryScreen(), // Inventář obrazovka
      },
    );
  }
}
