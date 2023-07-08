class Equipment {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  Map<String, dynamic> properties;
  List<Equipment> children;

  Equipment({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.properties,
    required this.children,
  });

  // Convert an Equipment object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'properties': properties,
      'children': children.map((e) => e.toJson()).toList(),
    };
  }

  // Create an Equipment object from a JSON map.
  static Equipment fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      properties: Map<String, dynamic>.from(json['properties']),
      children: (json['children'] as List)
          .map((e) => Equipment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
