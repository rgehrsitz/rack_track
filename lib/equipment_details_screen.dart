import 'package:flutter/material.dart';
import 'package:rack_track/equipment.dart';

class EquipmentDetailsScreen extends StatefulWidget {
  final Equipment equipment;
  final void Function(Equipment) onUpdate;

  const EquipmentDetailsScreen({
    Key? key,
    required this.equipment,
    required this.onUpdate,
  }) : super(key: key);

  @override
  EquipmentDetailsScreenState createState() => EquipmentDetailsScreenState();
}

class EquipmentDetailsScreenState extends State<EquipmentDetailsScreen> {
  late Equipment equipment;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Make a copy of the equipment to avoid modifying the original equipment
    equipment = Equipment(
      id: widget.equipment.id,
      name: widget.equipment.name,
      createdAt: widget.equipment.createdAt,
      updatedAt: widget.equipment.updatedAt,
      properties: Map<String, dynamic>.from(widget.equipment.properties),
      children: widget.equipment.children, // This is a shallow copy
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Equipment Details'),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                initialValue: equipment.name,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                onSaved: (value) {
                  equipment.name = value ?? '';
                },
              ),
              // TODO: Add more form fields for the other properties
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              widget.onUpdate(equipment);

              Navigator.pop(context);
            }
          },
        ));
  }
}
