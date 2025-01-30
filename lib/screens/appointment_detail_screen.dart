import 'package:flutter/material.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Map<String, String> appointment;

  AppointmentDetailScreen({required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail schůzky'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              // Name
              _buildDetailRow('Jméno:', '${appointment['firstName']} ${appointment['lastName']}'),
              Divider(),

              // Phone
              _buildDetailRow('Telefon:', appointment['phone']!),
              Divider(),

              // Email
              _buildDetailRow('E-mail:', appointment['email']!),
              Divider(),

              // Symptoms
              _buildDetailRow('Symptomy:', appointment['symptoms']!),
              Divider(),

              // Date
              _buildDetailRow('Datum:', appointment['date']!),
              Divider(),

              // Time
              _buildDetailRow('Čas:', appointment['time']!),
              Divider(),

            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build each detail row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
