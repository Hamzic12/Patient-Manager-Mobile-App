import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import this package
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
      // Set default locale and add localization delegates
      locale: Locale('cs', 'CZ'), // Set default language to Czech
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English (US)
        Locale('cs', 'CZ'), // Czech (Czech Republic)
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Login screen
        '/home': (context) => HomeScreen(), // Home screen
        '/appointment': (context) => AppointmentsScreen(), // Appointments screen
        '/inventory': (context) => InventoryScreen(), // Inventory screen
      },
    );
  }
}
