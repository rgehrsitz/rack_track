import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'equipment.dart';

class DataService {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/equipment.json');
  }

  Future<File> writeEquipment(List<Equipment> equipment) async {
    final file = await _localFile;
    final json = jsonEncode(equipment.map((e) => e.toJson()).toList());
    return file.writeAsString(json);
  }

  Future<List<Equipment>> readEquipment() async {
    try {
      final file = await _localFile;
      final json = await file.readAsString();
      final data = jsonDecode(json) as List;
      return data.map((e) => Equipment.fromJson(e)).toList();
    } catch (e) {
      return [];
    }
  }
}
