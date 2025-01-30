import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddAppointmentScreen extends StatefulWidget {
  final Function(Map<String, String>) onSubmit;
  final DateTime selectedDate;
  final Map<String, String>? existingAppointment;

  AddAppointmentScreen({required this.onSubmit, required this.selectedDate, this.existingAppointment});

  @override
  _AddAppointmentScreenState createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController symptomsController;

  TimeOfDay selectedTime = TimeOfDay.now();
  late DateTime selectedDate;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    isEditing = widget.existingAppointment != null;
    selectedDate = isEditing ? DateFormat('dd-MM-yyyy').parse(widget.existingAppointment!['date']!) : widget.selectedDate;
    selectedTime = isEditing ? _parseTime(widget.existingAppointment!['time']!) : TimeOfDay.now();

    firstNameController = TextEditingController(text: widget.existingAppointment?['firstName'] ?? '');
    lastNameController = TextEditingController(text: widget.existingAppointment?['lastName'] ?? '');
    phoneController = TextEditingController(text: widget.existingAppointment?['phone'] ?? '');
    emailController = TextEditingController(text: widget.existingAppointment?['email'] ?? '');
    symptomsController = TextEditingController(text: widget.existingAppointment?['symptoms'] ?? '');
  }

  TimeOfDay _parseTime(String time) {
    try {
      final cleanTime = time.trim();
      final parts = cleanTime.split(":");
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } catch (e) {
      print("Error parsing time: $time");
      rethrow;
    }
  }

  void _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      locale: Locale('cs', 'CZ'), // Set the locale to Czech
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  void _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: true, // Optional: Use 24-hour format
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Map<String, String> newAppointment = {
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'symptoms': symptomsController.text,
        'date': DateFormat('dd-MM-yyyy').format(selectedDate),
        'time': selectedTime.format(context),
      };

      widget.onSubmit(newAppointment);
      Navigator.of(context).pop();
    }
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? 'Vyplňte $label' : null,
    );
  }

  Widget _buildDateTimePicker(String label, String value, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Text('$label: $value'),
      trailing: Icon(icon),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Upravit schůzku' : 'Nová schůzka')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(firstNameController, 'Jméno'),
              _buildTextField(lastNameController, 'Příjmení'),
              _buildTextField(phoneController, 'Telefon', keyboardType: TextInputType.phone),
              _buildTextField(emailController, 'E-mail', keyboardType: TextInputType.emailAddress),
              _buildTextField(symptomsController, 'Symptomy'),
              _buildDateTimePicker('Datum', DateFormat('dd-MM-yyyy').format(selectedDate), Icons.calendar_today, _selectDate),
              _buildDateTimePicker('Čas', selectedTime.format(context), Icons.access_time, _selectTime),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Uložit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
