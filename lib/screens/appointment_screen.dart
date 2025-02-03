import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'add_and_edit_appointment_screen.dart';
import 'appointment_detail_screen.dart'; // Import the detail screen

class AppointmentsScreen extends StatefulWidget {
  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  List<dynamic> appointments = [];
  List<dynamic> filteredAppointments = [];
  DateTime selectedDate = DateTime.now();
  String appointmentsFilePath = 'appointments.json';

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  // Load appointments from file
  _loadAppointments() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$appointmentsFilePath');
    if (file.existsSync()) {
      final String response = await file.readAsString();
      setState(() {
        appointments = json.decode(response);
        _filterAppointments();
      });
    }
  }

  // Save appointments to file
  _saveAppointments() async {
    final String appointmentsJson = json.encode(appointments);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$appointmentsFilePath');
    await file.writeAsString(appointmentsJson);
  }

  // Add a new appointment
  void _addAppointment(Map<String, String> newAppointment) {
    setState(() {
      appointments.add(newAppointment);
    });
    _saveAppointments();
    _filterAppointments();
  }

  // Edit an existing appointment
  void _editAppointment(int index, Map<String, String> updatedAppointment) {
    setState(() {
      appointments[index] = updatedAppointment;
    });
    _saveAppointments();
    _filterAppointments();
  }

  // Delete an appointment
  void _deleteAppointment(int index) {
    setState(() {
      appointments.removeAt(index);
    });
    _saveAppointments();
    _filterAppointments();
  }

  // Filter appointments by the selected date
  void _filterAppointments() {
    setState(() {
      filteredAppointments = appointments.where((appointment) {
        DateTime appointmentDate = DateFormat('dd-MM-yyyy').parse(appointment['date']);
        return appointmentDate == selectedDate;
      }).toList();
    });
  }

  // Navigate to the AddAppointmentScreen for adding a new appointment
  void _navigateToAddAppointment() async {
    final newAppointment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAppointmentScreen(
          selectedDate: selectedDate,
          onSubmit: _addAppointment,
        ),
      ),
    );

    if (newAppointment != null) {
      _addAppointment(newAppointment);
    }
  }

  // Navigate to the AddAppointmentScreen for editing an existing appointment
  void _navigateToEditAppointment(int index) async {
    int originalIndex = appointments.indexOf(filteredAppointments[index]);

    final updatedAppointment = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddAppointmentScreen(
          selectedDate: DateFormat('dd-MM-yyyy').parse(appointments[originalIndex]['date']),
          existingAppointment: Map<String, String>.from(appointments[originalIndex]),
          onSubmit: (updatedAppointment) {
            _editAppointment(originalIndex, updatedAppointment);
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Návštěvy')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              ).then((pickedDate) {
                if (pickedDate != null) {
                  setState(() {
                    selectedDate = pickedDate;
                    _filterAppointments();
                  });
                }
              });
            },
            child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${filteredAppointments[index]['firstName']} ${filteredAppointments[index]['lastName']}'),
                  subtitle: Text('${filteredAppointments[index]['time']}'),
                  onTap: () {
                    // Cast appointment from Map<String, dynamic> to Map<String, String>
                    Map<String, String> appointmentDetail = Map<String, String>.from(filteredAppointments[index]);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppointmentDetailScreen(appointment: appointmentDetail),
                      ),
                    );
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _navigateToEditAppointment(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteAppointment(appointments.indexOf(filteredAppointments[index])),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddAppointment,
        child: Icon(Icons.add),
      ),
    );
  }
}
