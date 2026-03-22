class PaintingStatus {
  final int? id;
  final String name;
  final int orden;
  final String color;

  PaintingStatus({
    this.id,
    required this.name,
    required this.orden,
    required this.color,
  });

  factory PaintingStatus.fromMap(Map<String, dynamic> map) {
    return PaintingStatus(
      id: map['id'],
      name: map['name'],
      orden: map['orden'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'orden': orden, 'color': color};
  }
}
