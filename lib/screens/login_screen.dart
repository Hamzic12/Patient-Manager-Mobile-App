import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final String _validUsername = 'admin'; // Pevně definované uživatelské jméno
  final String _validPassword = '1234'; // Pevně definované heslo

  void _login() {
    if (_usernameController.text == _validUsername &&
        _passwordController.text == _validPassword) {
      // Po úspěšném přihlášení přesměrování na úvodní obrazovku
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      // Pokud je přihlášení neúspěšné, zobrazíme chybu
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Chyba přihlášení'),
          content: Text('Špatné uživatelské jméno nebo heslo.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Přihlášení',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Uživatelské jméno',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Heslo',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Přihlásit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
