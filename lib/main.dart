import 'package:flutter/material.dart';
import 'package:rack_track/equipment.dart';
import 'package:rack_track/equipment_list_screen.dart';
import 'package:rack_track/data_service.dart';

void main() {
  runApp(const RackTrackApp());
}

class RackTrackApp extends StatefulWidget {
  const RackTrackApp({Key? key}) : super(key: key);

  @override
  _RackTrackAppState createState() => _RackTrackAppState();
}

class _RackTrackAppState extends State<RackTrackApp> {
  final dataService = DataService();
  late List<Equipment> equipment;

  @override
  void initState() {
    super.initState();
    dataService.readEquipment().then((data) {
      setState(() {
        equipment = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rack Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EquipmentListScreen(
        initialEquipment: equipment,
        onUpdate: (updatedEquipment) {
          setState(() {
            equipment = updatedEquipment;
          });
          dataService.writeEquipment(equipment);
        },
      ),
    );
  }
}
