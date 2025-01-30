import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'add_and_edit_inventory_screen.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<dynamic> inventory = [];
  String inventoryFilePath = 'assets/data/inventory.json';

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  // Load inventory data from local storage (assets or local file system)
  _loadInventory() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/inventory.json');

    if (await file.exists()) {
      final String response = await file.readAsString();
      setState(() {
        inventory = json.decode(response);
      });
    } else {
      // If the file doesn't exist, load initial data from assets
      final String response = await rootBundle.loadString(inventoryFilePath);
      setState(() {
        inventory = json.decode(response);
      });
    }
  }

  // Save the inventory data to local storage
  _saveInventory() async {
    final String inventoryJson = json.encode(inventory);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/inventory.json');
    await file.writeAsString(inventoryJson);
  }

  // Add a new inventory item
  void _addItem() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInventoryItemScreen(
          onSubmit: (newItem) {
            setState(() {
              inventory.add(newItem);
            });
            _saveInventory();
          },
        ),
      ),
    );
  }

  // Edit an existing inventory item
  void _editItem(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddInventoryItemScreen(
          existingItem: inventory[index],
          onSubmit: (updatedItem) {
            setState(() {
              inventory[index] = updatedItem;
            });
            _saveInventory();
          },
        ),
      ),
    );
  }

  // Delete an inventory item
  void _deleteItem(int index) {
    setState(() {
      inventory.removeAt(index);
    });
    _saveInventory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inventář')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: inventory.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(inventory[index]['name']),
                  subtitle: Text('Aktuální počet: ${inventory[index]['quantity']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editItem(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteItem(index),
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
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
