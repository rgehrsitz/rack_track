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
}
