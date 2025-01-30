import 'package:flutter/material.dart';
import 'appointment_screen.dart'; // Import your AppointmentScreen
import 'inventory_screen.dart'; // Import your InventoryScreen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs (Schůzky and Inventář)
      child: Scaffold(
        body: TabBarView(
          children: [
            // Tab 1: Appointments Screen
            AppointmentsScreen(),

            // Tab 2: Inventory Screen
            InventoryScreen(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.calendar_today),
              text: 'Návštěvy',
            ),
            Tab(
              icon: Icon(Icons.inventory),
              text: 'Inventář',
            ),
          ],
        ),
      ),
    );
  }
}
