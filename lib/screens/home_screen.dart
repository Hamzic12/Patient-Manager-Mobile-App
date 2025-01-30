import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Urologická ordinace MUDr. Nussir',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Adjust the color as needed
              ),
            ),
            SizedBox(height: 40), // Space between the label and the icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/appointment'); // Přejít na Schůzky
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/pacient.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Schůzky',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 40), // Space between the two icons
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/inventory'); // Přejít na Inventář
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/inventory.png',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Inventář',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
