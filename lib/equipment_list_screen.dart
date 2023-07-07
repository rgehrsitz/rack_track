import 'package:flutter/material.dart';
import 'package:rack_track/equipment.dart';
import 'package:rack_track/equipment_details_screen.dart';

class EquipmentListScreen extends StatefulWidget {
  final List<Equipment> initialEquipment;

  const EquipmentListScreen({Key? key, required this.initialEquipment})
      : super(key: key);

  @override
  EquipmentListScreenState createState() => EquipmentListScreenState();
}

class EquipmentListScreenState extends State<EquipmentListScreen> {
  late List<Equipment> equipmentList;

  @override
  void initState() {
    super.initState();
    equipmentList = widget.initialEquipment;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment List'),
      ),
      body: ListView.builder(
        itemCount: equipmentList.length,
        itemBuilder: (context, index) {
          final equipment = equipmentList[index];
          return ListTile(
            title: Text(equipment.name),
            onTap: () async {
              final updatedEquipment = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EquipmentDetailsScreen(
                    equipment: equipment,
                    onUpdate: (updatedEquipment) {
                      setState(() {
                        equipmentList[index] = updatedEquipment;
                      });
                    },
                  ),
                ),
              );

              if (updatedEquipment != null) {
                setState(() {
                  equipmentList[index] = updatedEquipment;
                });
              }
            },
          );
        },
      ),
    );
  }
}
