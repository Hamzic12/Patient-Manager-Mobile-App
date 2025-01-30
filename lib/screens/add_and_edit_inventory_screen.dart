import 'package:flutter/material.dart';

class AddInventoryItemScreen extends StatefulWidget {
  final Map<String, dynamic>? existingItem;
  final Function(Map<String, dynamic>) onSubmit;

  AddInventoryItemScreen({this.existingItem, required this.onSubmit});

  @override
  _AddInventoryItemScreenState createState() => _AddInventoryItemScreenState();
}

class _AddInventoryItemScreenState extends State<AddInventoryItemScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController quantityController;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    isEditing = widget.existingItem != null;
    nameController = TextEditingController(text: widget.existingItem?['name'] ?? '');
    quantityController = TextEditingController(text: widget.existingItem?['quantity'].toString() ?? '10');
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final newItem = {
        'name': nameController.text,
        'quantity': int.parse(quantityController.text),
      };
      widget.onSubmit(newItem);  // Pass the new or updated item to the parent
      Navigator.of(context).pop(); // Close the screen after submission
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Upravit položku' : 'Nová položka')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name input field
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Název položky'),
                validator: (value) => value!.isEmpty ? 'Vyplňte název položky' : null,
              ),
              // Quantity input field
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(labelText: 'Počet'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Vyplňte počet';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Počet musí být číslo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Submit button
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(isEditing ? 'Uložit' : 'Uložit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
