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
  late Map<String, TextEditingController> controllers;
  late List<String> keys;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    equipment = Equipment(
      id: widget.equipment.id,
      name: widget.equipment.name,
      createdAt: widget.equipment.createdAt,
      updatedAt: widget.equipment.updatedAt,
      properties: Map<String, dynamic>.from(widget.equipment.properties),
      children: widget.equipment.children,
    );

    keys = equipment.properties.keys.toList();
    controllers = {
      for (var key in keys)
        key: TextEditingController(text: equipment.properties[key].toString()),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment Details'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final controller = TextEditingController();
              final key = await showDialog<String>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add Field'),
                  content: TextField(
                    controller: controller,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Field Name',
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        Navigator.pop(context, controller.text);
                      },
                    ),
                  ],
                ),
              );

              if (key != null && key.isNotEmpty) {
                setState(() {
                  keys.add(key);
                  controllers[key] = TextEditingController();
                });
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: <Widget>[
            for (var key in keys)
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      controller: controllers[key],
                      decoration: InputDecoration(
                        labelText: key,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        keys.remove(key);
                        controllers.remove(key);
                      });
                    },
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            for (var key in keys) {
              equipment.properties[key] = controllers[key]!.text;
            }

            widget.onUpdate(equipment);

            Navigator.pop(context, equipment);
          }
        },
      ),
    );
  }
}
