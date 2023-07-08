import 'package:flutter/material.dart';
import 'package:rack_track/equipment.dart';
import 'package:rack_track/equipment_list_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const RackTrackApp());
}

class RackTrackApp extends StatelessWidget {
  const RackTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final equipment = [
      Equipment(
        id: '1',
        name: 'Server 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        properties: {'type': 'server', 'firmwareVersion': '1.0.0'},
        children: [],
      ),
      // Add more dummy equipment here
    ];

    return MaterialApp(
      title: 'Rack Track',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EquipmentListScreen(initialEquipment: equipment),
    );
  }
}
